import SwiftUI

// MARK: - Ilustración del avatar (100% vector, diseño propio de Xternal B —
// sin relación con ningún personaje de ningún juego).

struct OriginalAvatarIllustration: View {
    var accent: Color = .red

    var body: some View {
        Canvas { context, size in
            let scale = min(size.width / 220, size.height / 360)
            context.translateBy(
                x: (size.width - 220 * scale) / 2,
                y: (size.height - 360 * scale) / 2
            )
            context.scaleBy(x: scale, y: scale)

            func draw(_ path: Path, fill: Color? = nil, stroke: Color? = nil, lineWidth: CGFloat = 1.5, opacity: Double = 1) {
                if let fill { context.fill(path, with: .color(fill.opacity(opacity))) }
                if let stroke { context.stroke(path, with: .color(stroke.opacity(opacity)), lineWidth: lineWidth) }
            }

            let dark1 = Color(white: 0.08)   // #141414
            let dark2 = Color(white: 0.23)   // #3a3a3a
            let dark3 = Color(white: 0.05)   // #0d0d0d
            let darkest = Color(white: 0.04) // #0a0a0a

            // Sombra en el piso
            draw(Path(ellipseIn: CGRect(x: 50, y: 335, width: 120, height: 20)), fill: accent, opacity: 0.2)

            // Piernas
            var legL = Path()
            legL.move(to: CGPoint(x: 88, y: 270))
            legL.addLine(to: CGPoint(x: 80, y: 330))
            legL.addQuadCurve(to: CGPoint(x: 88, y: 340), control: CGPoint(x: 78, y: 340))
            legL.addLine(to: CGPoint(x: 96, y: 340))
            legL.addLine(to: CGPoint(x: 102, y: 280))
            legL.closeSubpath()
            draw(legL, fill: dark1, stroke: dark2)

            var legR = Path()
            legR.move(to: CGPoint(x: 132, y: 270))
            legR.addLine(to: CGPoint(x: 140, y: 330))
            legR.addQuadCurve(to: CGPoint(x: 132, y: 340), control: CGPoint(x: 142, y: 340))
            legR.addLine(to: CGPoint(x: 124, y: 340))
            legR.addLine(to: CGPoint(x: 118, y: 280))
            legR.closeSubpath()
            draw(legR, fill: dark1, stroke: dark2)

            // Botas
            draw(Path(roundedRect: CGRect(x: 78, y: 332, width: 26, height: 10), cornerRadius: 3), fill: accent)
            draw(Path(roundedRect: CGRect(x: 116, y: 332, width: 26, height: 10), cornerRadius: 3), fill: accent)

            // Torso / campera
            var torso = Path()
            torso.move(to: CGPoint(x: 70, y: 160))
            torso.addQuadCurve(to: CGPoint(x: 78, y: 270), control: CGPoint(x: 60, y: 220))
            torso.addLine(to: CGPoint(x: 142, y: 270))
            torso.addQuadCurve(to: CGPoint(x: 150, y: 160), control: CGPoint(x: 160, y: 220))
            torso.closeSubpath()
            draw(torso, fill: Color(white: 0.09), stroke: accent, lineWidth: 2)

            draw(Path { $0.move(to: CGPoint(x: 85, y: 190)); $0.addLine(to: CGPoint(x: 135, y: 190)) }, stroke: accent, lineWidth: 1, opacity: 0.4)
            draw(Path { $0.move(to: CGPoint(x: 90, y: 215)); $0.addLine(to: CGPoint(x: 130, y: 215)) }, stroke: accent, lineWidth: 1, opacity: 0.4)

            // Brazos
            var armL = Path()
            armL.move(to: CGPoint(x: 70, y: 170))
            armL.addQuadCurve(to: CGPoint(x: 32, y: 230), control: CGPoint(x: 40, y: 180))
            armL.addQuadCurve(to: CGPoint(x: 44, y: 252), control: CGPoint(x: 30, y: 250))
            armL.addLine(to: CGPoint(x: 54, y: 252))
            armL.addQuadCurve(to: CGPoint(x: 72, y: 195), control: CGPoint(x: 58, y: 220))
            armL.closeSubpath()
            draw(armL, fill: dark1, stroke: dark2)

            var armR = Path()
            armR.move(to: CGPoint(x: 150, y: 170))
            armR.addQuadCurve(to: CGPoint(x: 188, y: 230), control: CGPoint(x: 180, y: 180))
            armR.addQuadCurve(to: CGPoint(x: 176, y: 252), control: CGPoint(x: 190, y: 250))
            armR.addLine(to: CGPoint(x: 166, y: 252))
            armR.addQuadCurve(to: CGPoint(x: 148, y: 195), control: CGPoint(x: 162, y: 220))
            armR.closeSubpath()
            draw(armR, fill: dark1, stroke: dark2)

            draw(Path(ellipseIn: CGRect(x: 39, y: 242, width: 20, height: 20)), fill: accent)
            draw(Path(ellipseIn: CGRect(x: 161, y: 242, width: 20, height: 20)), fill: accent)

            // Cadena / cuello
            var collar = Path()
            collar.move(to: CGPoint(x: 78, y: 150))
            collar.addQuadCurve(to: CGPoint(x: 142, y: 150), control: CGPoint(x: 110, y: 165))
            collar.addLine(to: CGPoint(x: 148, y: 172))
            collar.addQuadCurve(to: CGPoint(x: 72, y: 172), control: CGPoint(x: 110, y: 190))
            collar.closeSubpath()
            draw(collar, fill: dark3, stroke: accent, lineWidth: 2)

            draw(Path(ellipseIn: CGRect(x: 105, y: 163, width: 10, height: 10)), fill: accent)
            draw(Path { p in
                p.move(to: CGPoint(x: 100, y: 172))
                p.addQuadCurve(to: CGPoint(x: 120, y: 172), control: CGPoint(x: 110, y: 180))
            }, stroke: accent, lineWidth: 1.2)

            // Cabeza / máscara
            var head = Path()
            head.move(to: CGPoint(x: 72, y: 110))
            head.addQuadCurve(to: CGPoint(x: 110, y: 68), control: CGPoint(x: 72, y: 70))
            head.addQuadCurve(to: CGPoint(x: 148, y: 110), control: CGPoint(x: 148, y: 70))
            head.addQuadCurve(to: CGPoint(x: 130, y: 150), control: CGPoint(x: 148, y: 140))
            head.addQuadCurve(to: CGPoint(x: 90, y: 150), control: CGPoint(x: 110, y: 160))
            head.addQuadCurve(to: CGPoint(x: 72, y: 110), control: CGPoint(x: 72, y: 140))
            head.closeSubpath()
            draw(head, fill: dark1, stroke: accent, lineWidth: 2)

            draw(Path { p in
                p.move(to: CGPoint(x: 78, y: 108))
                p.addQuadCurve(to: CGPoint(x: 110, y: 108), control: CGPoint(x: 94, y: 96))
                p.addQuadCurve(to: CGPoint(x: 142, y: 108), control: CGPoint(x: 126, y: 96))
            }, stroke: accent, lineWidth: 2)

            draw(Path(ellipseIn: CGRect(x: 89, y: 107, width: 10, height: 10)), fill: accent)
            draw(Path(ellipseIn: CGRect(x: 121, y: 107, width: 10, height: 10)), fill: accent)

            // Capucha
            var hood = Path()
            hood.move(to: CGPoint(x: 72, y: 95))
            hood.addQuadCurve(to: CGPoint(x: 110, y: 48), control: CGPoint(x: 72, y: 55))
            hood.addQuadCurve(to: CGPoint(x: 148, y: 95), control: CGPoint(x: 148, y: 55))
            hood.addQuadCurve(to: CGPoint(x: 110, y: 62), control: CGPoint(x: 148, y: 70))
            hood.addQuadCurve(to: CGPoint(x: 72, y: 95), control: CGPoint(x: 72, y: 70))
            hood.closeSubpath()
            draw(hood, fill: darkest, stroke: dark2)

            // Picos (guiño a la corona del logo)
            draw(Path { p in
                p.move(to: CGPoint(x: 94, y: 50))
                p.addLine(to: CGPoint(x: 104, y: 34))
                p.addLine(to: CGPoint(x: 116, y: 34))
                p.addLine(to: CGPoint(x: 126, y: 50))
            }, stroke: accent, lineWidth: 2)
            draw(Path(ellipseIn: CGRect(x: 101, y: 31, width: 6, height: 6)), fill: accent)
            draw(Path(ellipseIn: CGRect(x: 113, y: 31, width: 6, height: 6)), fill: accent)
        }
        .aspectRatio(220.0 / 360.0, contentMode: .fit)
        .accessibilityHidden(true)
    }
}

// MARK: - Zonas de activación

enum AvatarZone: String, CaseIterable, Identifiable {
    case head, neck, chest

    var id: String { rawValue }

    var label: String {
        switch self {
        case .head: return "CABEZA"
        case .neck: return "CUELLO"
        case .chest: return "PECHO"
        }
    }

    var systemImage: String {
        switch self {
        case .head: return "face.smiling"
        case .neck: return "link"
        case .chest: return "tshirt"
        }
    }
}

enum AvatarZoneState: Equatable {
    case idle
    case active        // compatible y activado correctamente → verde
    case incompatible  // error de compatibilidad → rojo

    var tint: Color {
        switch self {
        case .idle: return .white.opacity(0.5)
        case .active: return .green
        case .incompatible: return .red
        }
    }

    var statusText: String {
        switch self {
        case .idle: return "Toca para activar"
        case .active: return "Activo · compatible"
        case .incompatible: return "Error de compatibilidad"
        }
    }
}

/// Maneja el estado de las 3 zonas. La función `checkCompatibility` es el
/// ÚNICO lugar que hay que reemplazar por la lógica real de cada zona
/// (qué hace que CABEZA/CUELLO/PECHO sean compatibles o no en este
/// dispositivo) — hoy es un placeholder basado en la versión de iOS, al
/// mismo estilo que ya usa el resto del proyecto (ver `ContainerStore.swift`,
/// `GestaltRegionService.swift`).
@MainActor
final class AvatarZoneStore: ObservableObject {
    @Published private(set) var states: [AvatarZone: AvatarZoneState] =
        Dictionary(uniqueKeysWithValues: AvatarZone.allCases.map { ($0, .idle) })

    func toggle(_ zone: AvatarZone) {
        if states[zone] != .idle {
            states[zone] = .idle
            return
        }
        states[zone] = checkCompatibility(zone) ? .active : .incompatible
    }

    /// PLACEHOLDER — reemplazar por la verificación real de cada zona.
    private func checkCompatibility(_ zone: AvatarZone) -> Bool {
        let majorVersion = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
        switch zone {
        case .head, .neck: return majorVersion >= 17
        case .chest: return majorVersion >= 26
        }
    }
}

// MARK: - Pantalla

struct AvatarStageView: View {
    @StateObject private var zoneStore = AvatarZoneStore()

    @State private var dragRotation: CGFloat = 0
    @State private var scale: CGFloat = 1
    @GestureState private var dragOffset: CGFloat = 0
    @GestureState private var pinchDelta: CGFloat = 1

    private var iosVersionBadge: String {
        let v = ProcessInfo.processInfo.operatingSystemVersion
        return "iOS \(v.majorVersion).\(v.minorVersion)"
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Circle()
                .fill(Color.red)
                .frame(width: 320, height: 320)
                .blur(radius: 100)
                .opacity(0.35)
                .offset(y: -280)
                .allowsHitTesting(false)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    VStack(alignment: .leading, spacing: 2) {
                        Text("LIVE MESH")
                            .font(.system(size: 10, weight: .semibold))
                            .tracking(1.5)
                            .foregroundStyle(.white.opacity(0.4))
                        Text("AVATAR")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundStyle(.white)
                    }

                    avatarCanvas

                    Text("GESTO: ARRASTRAR · PELLIZCAR · 2 TOQUES RESETEA")
                        .font(.system(size: 10, weight: .medium))
                        .tracking(0.5)
                        .foregroundStyle(.white.opacity(0.4))

                    zoneCard
                }
                .padding(.horizontal, AppTheme.pageInset)
                .padding(.top, 20)
                .padding(.bottom, 32)
            }
        }
    }

    private var header: some View {
        HStack {
            HStack(spacing: 10) {
                AppLogo(size: 30)
                    .clipShape(Circle())
                    .overlay(Circle().strokeBorder(Color.red.opacity(0.6), lineWidth: 1))
                Text("XTERNAL B")
                    .font(.system(size: 12, weight: .semibold))
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

    private var avatarCanvas: some View {
        OriginalAvatarIllustration()
            .frame(height: 280)
            .scaleEffect(scale * pinchDelta)
            .rotation3DEffect(
                .degrees(dragRotation + dragOffset),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.4
            )
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = Double(value.translation.width) / 2
                    }
                    .onEnded { value in
                        dragRotation += value.translation.width / 2
                    }
            )
            .simultaneousGesture(
                MagnificationGesture()
                    .updating($pinchDelta) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        scale = min(max(scale * value, 0.6), 1.8)
                    }
            )
            .onTapGesture(count: 2) {
                withAnimation(.spring()) {
                    dragRotation = 0
                    scale = 1
                }
            }
            .frame(maxWidth: .infinity)
    }

    private var zoneCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("ZONAS")
                .font(.system(size: 11, weight: .semibold))
                .tracking(1.5)
                .foregroundStyle(Color.red)

            HStack(spacing: 10) {
                ForEach(AvatarZone.allCases) { zone in
                    zoneButton(zone)
                }
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
    }

    private func zoneButton(_ zone: AvatarZone) -> some View {
        let state = zoneStore.states[zone] ?? .idle
        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                zoneStore.toggle(zone)
            }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: zone.systemImage)
                    .font(.system(size: 18, weight: .medium))
                Text(zone.label)
                    .font(.system(size: 11, weight: .bold))
                    .tracking(0.5)
                Circle()
                    .fill(state.tint)
                    .frame(width: 6, height: 6)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                state == .idle ? Color.white.opacity(0.06) : state.tint.opacity(0.15),
                in: RoundedRectangle(cornerRadius: 14, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(state == .idle ? Color.white.opacity(0.12) : state.tint.opacity(0.6), lineWidth: 1)
            )
            .foregroundStyle(state == .idle ? Color.white : state.tint)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(zone.label) — \(state.statusText)")
    }
}
