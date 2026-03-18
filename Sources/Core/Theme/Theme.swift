import SwiftUI

// MARK: - Color System

struct StompColors {
    static let background = Color(red: 0.05, green: 0.05, blue: 0.07) // Near black
    static let surfacePrimary = Color(red: 0.12, green: 0.12, blue: 0.15)
    static let surfaceSecondary = Color(red: 0.18, green: 0.18, blue: 0.22)
    static let border = Color(red: 0.25, green: 0.25, blue: 0.30)

    static let accent = Color(red: 1.0, green: 0.34, blue: 0.0) // Vibrant orange
    static let accentLight = Color(red: 1.0, green: 0.5, blue: 0.2)

    static let textPrimary = Color.white
    static let textSecondary = Color(red: 0.75, green: 0.75, blue: 0.8)
    static let textTertiary = Color(red: 0.55, green: 0.55, blue: 0.6)

    static let success = Color(red: 0.2, green: 0.8, blue: 0.4)
    static let failure = Color(red: 0.95, green: 0.25, blue: 0.25)
    static let warning = Color(red: 1.0, green: 0.65, blue: 0.0)

    static let glass = Color.white.opacity(0.05)
}

// MARK: - Typography

struct StompTypography {
    // Display sizes - for ritual moments
    static let displayLarge = Font.system(size: 72, weight: .bold, design: .default)
    static let displayMedium = Font.system(size: 56, weight: .bold, design: .default)
    static let displaySmall = Font.system(size: 44, weight: .bold, design: .default)

    // Heading sizes
    static let headingLarge = Font.system(size: 32, weight: .bold, design: .default)
    static let headingMedium = Font.system(size: 24, weight: .semibold, design: .default)
    static let headingSmall = Font.system(size: 20, weight: .semibold, design: .default)

    // Body text
    static let bodyLarge = Font.system(size: 18, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 16, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 14, weight: .regular, design: .default)

    // Caption
    static let captionLarge = Font.system(size: 13, weight: .medium, design: .default)
    static let captionSmall = Font.system(size: 11, weight: .regular, design: .default)

    // Monospace (for streaks, numbers)
    static let monoLarge = Font.system(size: 32, weight: .bold, design: .monospaced)
    static let monoMedium = Font.system(size: 24, weight: .bold, design: .monospaced)
    static let monoSmall = Font.system(size: 16, weight: .semibold, design: .monospaced)
}

// MARK: - Spacing

struct StompSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

// MARK: - Corner Radius

struct StompRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
}

// MARK: - Shadows

struct StompShadows {
    static let sm: (CGFloat, CGFloat, CGFloat) = (0, 2, 8)
    static let md: (CGFloat, CGFloat, CGFloat) = (0, 4, 12)
    static let lg: (CGFloat, CGFloat, CGFloat) = (0, 8, 24)

    static func shadow(_ level: (CGFloat, CGFloat, CGFloat)) -> some View {
        Shadow(x: level.0, y: level.1, blur: level.2)
    }
}

struct Shadow: ViewModifier {
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat

    func body(content: Content) -> some View {
        content.shadow(color: Color.black.opacity(0.3), x: x, y: y, blur: blur)
    }
}

// MARK: - Modifiers

extension View {
    func stompSurface() -> some View {
        self
            .background(StompColors.surfacePrimary)
            .cornerRadius(StompRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: StompRadius.md)
                    .stroke(StompColors.border, lineWidth: 1)
            )
    }

    func stompGlassSurface() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: StompRadius.md)
                    .fill(StompColors.glass)
                    .backdrop()
            )
            .overlay(
                RoundedRectangle(cornerRadius: StompRadius.md)
                    .stroke(StompColors.border.opacity(0.3), lineWidth: 1)
            )
    }

    func stompButton() -> some View {
        self
            .padding(.horizontal, StompSpacing.md)
            .padding(.vertical, StompSpacing.sm)
            .background(StompColors.accent)
            .cornerRadius(StompRadius.md)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
    }

    func stompSecondaryButton() -> some View {
        self
            .padding(.horizontal, StompSpacing.md)
            .padding(.vertical, StompSpacing.sm)
            .background(StompColors.surfaceSecondary)
            .cornerRadius(StompRadius.md)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(StompColors.textPrimary)
            .overlay(
                RoundedRectangle(cornerRadius: StompRadius.md)
                    .stroke(StompColors.border, lineWidth: 1)
            )
    }
}

// Backdrop effect (simplified for glass morphism)
extension View {
    func backdrop() -> some View {
        self.background(.ultraThinMaterial)
    }
}
