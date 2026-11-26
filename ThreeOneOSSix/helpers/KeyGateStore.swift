import Foundation
import UIKit

/// Motivo por el que una key fue rechazada. El texto en rojo de KeyGateView
/// solo aparece para estos casos.
enum KeyRejectionReason: Equatable {
    case malformed      // vacía o con formato imposible
    case notFound       // el bot no la conoce
    case revoked        // revocada desde el panel del bot
    case expired        // venció según el bot
    case rateLimited    // demasiados intentos fallidos desde esta IP
    case forbidden      // el secreto compartido no coincide con el del bot
    case network        // sin internet / servidor caído / URL mal puesta
    case server         // respuesta inesperada del servidor
}

/// Cliente del endpoint `/api/app/verify` del bot (ver `app_verify_key` en
/// main.py). La clave NUNCA se compara localmente: el bot es la única fuente
/// de verdad (revoked / expires_at).
enum KeyVerifier {
    enum Outcome: Equatable {
        case valid(expiresAt: Int?)
        case rejected(KeyRejectionReason)
    }

    /// ID estable del dispositivo; el bot lo guarda como `last_device`.
    static var deviceID: String {
        UIDevice.current.identifierForVendor?.uuidString ?? "SIN-IDENTIFIER-FOR-VENDOR"
    }

    /// Deja la key como la normaliza el bot (mayúsculas, solo A-Z/0-9) y la
    /// vuelve a formatear XB-XXXX-XXXX-XXXX. Así no importan espacios, guiones
    /// de más, minúsculas ni saltos de línea al pegar.
    static func normalized(_ raw: String) -> String {
        let compact = raw.uppercased().filter { $0.isASCII && ($0.isLetter || $0.isNumber) }
        guard compact.hasPrefix("XB"), compact.count == 14 else { return compact }
        let body = Array(compact.dropFirst(2))
        let groups = stride(from: 0, to: 12, by: 4).map { String(body[$0..<$0 + 4]) }
        return "XB-" + groups.joined(separator: "-")
    }

    static func verify(_ raw: String) async -> Outcome {
        let key = normalized(raw)
        guard !key.isEmpty else { return .rejected(.malformed) }

        let base = KeyGateConfig.serverURL.trimmingCharacters(in: CharacterSet(charactersIn: "/ \n"))
        guard let url = URL(string: base + "/api/app/verify") else { return .rejected(.network) }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !KeyGateConfig.sharedSecret.isEmpty {
            request.setValue(KeyGateConfig.sharedSecret, forHTTPHeaderField: "X-App-Secret")
        }
        let body: [String: String] = ["key": key, "device": deviceID]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            return .rejected(.network)
        }
        guard let http = response as? HTTPURLResponse else { return .rejected(.server) }

        let errorCode = (try? JSONSerialization.jsonObject(with: data) as? [String: Any])?["error"] as? String
        switch http.statusCode {
        case 200:
            let exp = (try? JSONSerialization.jsonObject(with: data) as? [String: Any])?["expires_at"] as? Int
            return .valid(expiresAt: exp)
        case 404:
            // Ojo: un 404 sin JSON del bot ("not_found") significa que la URL
            // apunta a otro servidor / ruta equivocada, no a una key mala.
            return errorCode == "not_found" ? .rejected(.notFound) : .rejected(.server)
        case 403:
            switch errorCode {
            case "revoked": return .rejected(.revoked)
            case "expired": return .rejected(.expired)
            default:        return .rejected(.forbidden)
            }
        case 400:
            return .rejected(.malformed)
        case 429:
            return .rejected(.rateLimited)
        default:
            return .rejected(.server)
        }
    }
}

/// Drives the "enter your key" gate. Verifica con el bot una sola vez; después
/// la key queda guardada junto con su fecha de vencimiento, que se compara
/// localmente; la app no vuelve a consultar al servidor.
@MainActor
final class KeyGateStore: ObservableObject {
    enum State: Equatable {
        case needsKey(error: String?)
        case unlocked
    }

    @Published private(set) var state: State = .needsKey(error: nil)
    /// true mientras se espera la respuesta del bot (para deshabilitar el botón).
    @Published private(set) var isChecking = false

    private let defaults = UserDefaults.standard
    private let keyDefaultsKey = "xb.licenseKey"
    private let expiryDefaultsKey = "xb.licenseExpiry"   // epoch s; 0 = sin caducidad
    /// Al abrir la app: si ya hay una key guardada (aceptada antes por el bot),
    /// entra directo, sin red. La key se verifica UNA sola vez, al activar.
    func bootstrap() {
        guard defaults.string(forKey: keyDefaultsKey) != nil else {
            state = .needsKey(error: nil)
            return
        }
        state = .unlocked
        checkExpiry()
    }

    /// Compara la fecha de vencimiento guardada con la hora del iPhone. No usa red.
    /// Llamar al abrir y al volver a primer plano.
    func checkExpiry() {
        guard case .unlocked = state else { return }
        let exp = defaults.double(forKey: expiryDefaultsKey)
        if exp > 0, Date().timeIntervalSince1970 >= exp {
            defaults.removeObject(forKey: keyDefaultsKey)
            defaults.removeObject(forKey: expiryDefaultsKey)
            state = .needsKey(error: message(for: .expired))
        }
    }

    /// Botón "Activar": única consulta al bot.
    func submit(key rawKey: String) {
        let trimmed = rawKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            state = .needsKey(error: message(for: .malformed))
            return
        }
        guard !isChecking else { return }
        isChecking = true
        Task {
            let outcome = await KeyVerifier.verify(trimmed)
            isChecking = false
            switch outcome {
            case .valid(let expiresAt):
                defaults.set(KeyVerifier.normalized(trimmed), forKey: keyDefaultsKey)
                defaults.set(Double(expiresAt ?? 0), forKey: expiryDefaultsKey)
                state = .unlocked
            case .rejected(let reason):
                state = .needsKey(error: message(for: reason))
            }
        }
    }

    private func message(for reason: KeyRejectionReason) -> String {
        switch reason {
        case .malformed:
            return "Escribe tu key completa (XB-XXXX-XXXX-XXXX)."
        case .notFound:
            return "Esa key no existe. Revisa que esté bien escrita."
        case .revoked:
            return "Esta key fue revocada. Pide una nueva."
        case .expired:
            return "Esta key ya expiró. Pide una nueva."
        case .rateLimited:
            return "Demasiados intentos fallidos. Espera unos minutos e inténtalo de nuevo."
        case .forbidden:
            return "La app no está autorizada por el servidor (secreto distinto al de config.py)."
        case .network:
            return "No se pudo conectar con el servidor. Revisa tu internet y la URL del bot."
        case .server:
            return "El servidor respondió algo inesperado. Revisa que la URL apunte a tu bot."
        }
    }

    func reset() {
        defaults.removeObject(forKey: keyDefaultsKey)
        defaults.removeObject(forKey: expiryDefaultsKey)
        state = .needsKey(error: nil)
    }
}
