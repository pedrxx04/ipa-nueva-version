import SwiftUI

/// La pantalla "muchas opciones" del HTML (pestañas + nav inferior) puesta
/// por encima de la interfaz original de la app (`ContentView`), que queda
/// montada por debajo sin tocarse. Se muestra una vez pasada la key gate y la
/// pantalla de versiones soportadas (`OnboardingView`, sin cambios).
struct PepoSkinOverlayView: View {
    var onLogout: () -> Void
    @StateObject private var bridge = PepoSkinBridge()

    var body: some View {
        PepoSkinWebView(
            startMode: .skin,
            bridge: bridge,
            onVerifyRequested: nil,
            onLogoutRequested: onLogout
        )
        .ignoresSafeArea()
    }
}
