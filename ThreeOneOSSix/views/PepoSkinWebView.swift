import SwiftUI
import WebKit

/// Pequeño canal de ida y vuelta entre SwiftUI y el HTML "Pepo Banned". La
/// vista que crea un `PepoSkinWebView` también crea uno de estos y lo observa
/// para reaccionar a lo que pasa dentro del WKWebView (sin acoplar el webview
/// a KeyGateStore directamente).
final class PepoSkinBridge: ObservableObject {
    fileprivate weak var webView: WKWebView?

    /// Resultado real de `KeyVerifier` (el bot de Telegram), pintado dentro
    /// del HTML exactamente como si lo hubiera validado el propio JS.
    func reportKeyResult(ok: Bool, message: String?, maskedKey: String?) {
        let okLiteral = ok ? "true" : "false"
        func js(_ s: String?) -> String {
            guard let s else { return "null" }
            let data = try? JSONSerialization.data(withJSONObject: [s])
            let encoded = data.flatMap { String(data: $0, encoding: .utf8) }
            // encoded es ["texto"] en JSON; nos quedamos solo con el string.
            return encoded.map { String($0.dropFirst().dropLast()) } ?? "null"
        }
        webView?.evaluateJavaScript("window.onKeyResult(\(okLiteral), \(js(message)), \(js(maskedKey)));")
    }
}

/// Aloja el HTML "Pepo Banned" dentro de la app nativa. En modo `.boot`
/// arranca con el logo de Apple y, al completarse, deja ver la key gate;
/// en modo `.skin` salta directo al panel principal (pestañas + nav), que es
/// la capa que se muestra por encima de la interfaz original ya desbloqueada.
struct PepoSkinWebView: UIViewRepresentable {
    enum StartMode: String {
        case boot
        case skin
    }

    let startMode: StartMode
    @ObservedObject var bridge: PepoSkinBridge
    var onVerifyRequested: ((String) -> Void)?
    var onLogoutRequested: (() -> Void)?

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> WKWebView {
        let controller = WKUserContentController()
        controller.add(context.coordinator, name: "keyGate")

        let config = WKWebViewConfiguration()
        config.userContentController = controller
        config.allowsInlineMediaPlayback = true
        // Los sonidos de boot / "opción activada" / "opción desactivada" del
        // HTML deben poder sonar sin que la persona toque antes la pantalla.
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false

        let html = PepoSkinHTML.source
            .replacingOccurrences(of: "__START_MODE__", with: startMode.rawValue)
            .replacingOccurrences(of: "__OS_LABEL__", with: "iOS \(AppInfo.osVersion)")
            .replacingOccurrences(of: "__OS_BUILD_LABEL__", with: "iOS \(AppInfo.osVersion) · \(AppInfo.osBuild)")
        webView.loadHTMLString(html, baseURL: nil)

        bridge.webView = webView
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        bridge.webView = uiView
    }

    final class Coordinator: NSObject, WKScriptMessageHandler {
        let parent: PepoSkinWebView
        init(_ parent: PepoSkinWebView) { self.parent = parent }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            guard let body = message.body as? [String: Any],
                  let action = body["action"] as? String else { return }
            switch action {
            case "verify":
                if let key = body["key"] as? String {
                    parent.onVerifyRequested?(key)
                }
            case "logout":
                parent.onLogoutRequested?()
            default:
                break
            }
        }
    }
}
