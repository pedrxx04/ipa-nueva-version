import SwiftUI

/// Full-screen gate shown before anything else in the app (even before
/// onboarding). "Pegar key" reads the clipboard; "Activar" asks the Telegram key bot
/// (/api/app/verify) whether the key is valid.
///
/// Visual language: fondo negro, acento rojo, tarjeta "LICENCIA" con el
/// mismo layout que el mock de referencia (header con logo + nombre +
/// badge de versión de iOS, headline grande, campo de key, botón pill y
/// mensaje de error que solo aparece si la key enviada es inválida).
struct KeyGateView: View {
    @ObservedObject var store: KeyGateStore
    @State private var input = ""
    @FocusState private var fieldFocused: Bool

    private var errorText: String? {
        if case .needsKey(let error) = store.state { return error }
        return nil
    }

    /// "iOS 26.0" / "iOS 27.0" — mayor.menor en vivo, tomado del propio
    /// dispositivo donde corre la ipa (ver AppInfo en Utils.swift).
    private var iosVersionBadge: String {
        let v = ProcessInfo.processInfo.operatingSystemVersion
        return "iOS \(v.majorVersion).\(v.minorVersion)"
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // Glow rojo desenfocado, igual al de la referencia — un blob
            // de color detrás del contenido, no una textura ni una imagen.
            Circle()
                .fill(Color.red)
                .frame(width: 340, height: 340)
                .blur(radius: 110)
                .opacity(0.45)
                .offset(x: -40, y: -300)
                .allowsHitTesting(false)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    header

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Activación")
                            .font(.system(size: 40, weight: .heavy))
                            .foregroundStyle(.white)
                        Text("Una key por dispositivo. Se guarda en el Keychain y abre el control center.")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.55))
                    }

                    licenseCard

                    deviceIDRow

                    footerNote
                }
                .padding(.horizontal, AppTheme.pageInset)
                .padding(.top, 20)
                .padding(.bottom, 32)
            }
        }
        .onAppear { fieldFocused = true }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            HStack(spacing: 10) {
                AppLogo(size: 34)
                    .clipShape(Circle())
                    .overlay(Circle().strokeBorder(Color.red.opacity(0.6), lineWidth: 1))
                Text("XTERNAL B")
                    .font(.system(size: 13, weight: .semibold))
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.92))
            }
            Spacer()
            Text(iosVersionBadge)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .tracking(1)
                .foregroundStyle(.white.opacity(0.45))
        }
    }

    // MARK: - License card

    private var licenseCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("LICENCIA")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(1.5)
                    .foregroundStyle(Color.red)
                Spacer()
                Circle()
                    .fill(errorText == nil ? Color.white.opacity(0.18) : Color.orange)
                    .frame(width: 8, height: 8)
            }

            Text("Introduce tu key")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)

            HStack(spacing: 10) {
                Text("#")
                    .foregroundStyle(.white.opacity(0.35))
                TextField("", text: $input, prompt: Text("XB-XXXX-XXXX-XXXX").foregroundColor(.white.opacity(0.3)))
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .font(.body.monospaced())
                    .foregroundStyle(.white)
                    .focused($fieldFocused)
                    .submitLabel(.go)
                    .onSubmit(attemptValidate)

                Button(action: pasteFromClipboard) {
                    Image(systemName: "doc.on.clipboard")
                        .foregroundStyle(.white.opacity(0.55))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 14)
            .frame(minHeight: 48)
            .background(
                Color.white.opacity(0.06),
                in: RoundedRectangle(cornerRadius: 12, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
            )

            Button(action: attemptValidate) {
                HStack {
                    Label(store.isChecking ? "Verificando…" : "Activar", systemImage: "key.fill")
                    Spacer()
                    Image(systemName: "arrow.right")
                }
            }
            .buttonStyle(RedPillButtonStyle())
            .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || store.isChecking)

            // Solo visible cuando la key enviada no pasa la validación —
            // nunca se muestra antes de que el usuario intente activar.
            if let errorText {
                Text(errorText)
                    .font(.footnote)
                    .foregroundStyle(Color.red)
                    .transition(.opacity)
            }
        }
        .padding(20)
        .background(
            Color.white.opacity(0.04),
            in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.2), value: errorText)
    }

    // MARK: - Device ID (lo que el cliente te manda para que le generes la key)

    private var deviceIDRow: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text("ID de este dispositivo")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(0.5)
                    .foregroundStyle(.white.opacity(0.4))
                Text(KeyVerifier.deviceID)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.75))
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
            Spacer()
            Button {
                UIPasteboard.general.string = KeyVerifier.deviceID
            } label: {
                Image(systemName: "doc.on.doc")
                    .foregroundStyle(.white.opacity(0.55))
            }
            .buttonStyle(.plain)
        }
        .padding(14)
        .background(
            Color.white.opacity(0.04),
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
    }

    // MARK: - Footer

    private var footerNote: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "lock.shield")
                .foregroundStyle(.white.opacity(0.4))
            Text("La key se verifica con el servidor. Necesitas conexión a internet para activar.")
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.4))
        }
    }

    private func pasteFromClipboard() {
        if let clip = UIPasteboard.general.string, !clip.isEmpty {
            input = clip
        }
    }

    private func attemptValidate() {
        fieldFocused = false
        store.submit(key: input)
    }
}

/// Botón rojo, grande y fácil de tocar.
private struct RedPillButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(
                Color.red.opacity(!isEnabled ? 0.35 : (configuration.isPressed ? 0.75 : 1)),
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}
