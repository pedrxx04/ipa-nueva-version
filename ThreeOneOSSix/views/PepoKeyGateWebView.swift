import SwiftUI

/// Reemplaza a `KeyGateView` como primera pantalla de la app: dentro de un
/// único WKWebView corre el boot de Apple y, después, la key gate del HTML
/// "Pepo Banned". La verificación de la key NUNCA ocurre en el HTML — se
/// reenvía tal cual a `KeyGateStore.submit(key:)`, que sigue hablando con el
/// bot de Telegram (`/api/app/verify`) exactamente como antes. Este archivo
/// solo traduce la respuesta del store de vuelta al HTML.
struct PepoKeyGateWebView: View {
    @ObservedObject var store: KeyGateStore
    @StateObject private var bridge = PepoSkinBridge()

    var body: some View {
        PepoSkinWebView(
            startMode: .boot,
            bridge: bridge,
            onVerifyRequested: { key in store.submit(key: key) },
            onLogoutRequested: { store.reset() }
        )
        .ignoresSafeArea()
        .onChange(of: store.state) { newState in
            // Un error real del bot (key inválida/revocada/expirada/sin red…)
            // se pinta en el HTML con el mismo texto que ya usaba KeyGateView.
            // Si la key es válida, `store.state` pasa a `.unlocked` y es
            // App.swift quien retira esta pantalla por completo — no hay nada
            // que decirle al HTML en ese caso.
            if case .needsKey(let error) = newState, let error {
                bridge.reportKeyResult(ok: false, message: error, maskedKey: nil)
            }
        }
    }
}
