import Foundation

/// Conexión de la app con tu bot de keys (main.py).
///
/// La app manda la key a `POST {serverURL}/api/app/verify` y el bot responde
/// si existe, está revocada o expiró. Se consulta una sola vez, al activar; luego la key queda guardada.
///
/// EDITA ESTO antes de compilar:
///  1. `serverURL`: la URL pública donde corre tu bot, SIN "/" al final y SIN
///     "/api/app/verify". Ejemplos:
///        "http://123.45.67.89:8080"      (IP del VPS + WEB_PORT de config.py)
///        "https://keys.tudominio.com"    (si tienes Caddy/Nginx con HTTPS)
///  2. `sharedSecret`: debe ser EXACTAMENTE igual a `APP_KEY_SHARED_SECRET`
///     en el config.py del bot (se envía en la cabecera X-App-Secret).
///     Si en config.py no lo tienes definido, deja aquí "" y el bot no lo exige.
enum KeyGateConfig {
    static let serverURL = "http://38.86.78.110:8080"
    static let sharedSecret = "47ba0a92cbe7bf2aca5b23127f5355bdf20f0f26e02933abddabdcf8995d4676"
}
