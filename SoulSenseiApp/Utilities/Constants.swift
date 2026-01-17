import SwiftUI

// MARK: - API Constants
enum APIConstants {
    static let baseURL = "https://gist.githubusercontent.com/sanjeevworkstation/c27e6cc85b7d4bcaf8ec73d96a0ae25b/raw/4a2ce8c5215f2d7a7201338a6af49a77c0f81f6a/assignment.json"
}

// MARK: - Layout Constants
enum LayoutConstants {
    static let horizontalPadding: CGFloat = 16
    static let verticalSpacing: CGFloat = 24
    static let cardWidth: CGFloat = UIScreen.main.bounds.width - 80
    static let cardHeight: CGFloat = 400
    static let cardCornerRadius: CGFloat = 16
    static let cardImageHeight: CGFloat = 280
    static let faqCornerRadius: CGFloat = 12
    static let faqPadding: CGFloat = 16
}

// MARK: - Color Constants
enum AppColors {
    static let background = Color(hex: "F5F5F5")
    static let cardBackground = Color.white
    static let primaryText = Color.black
    static let secondaryText = Color.gray
    static let accentColor = Color(hex: "6B4EE6")
    static let faqBackground = Color.white
    static let chevronColor = Color.gray.opacity(0.6)
}

// MARK: - Font Constants
enum AppFonts {
    static let carouselTitle = Font.system(size: 20, weight: .bold)
    static let cardName = Font.system(size: 18, weight: .semibold)
    static let cardDescription = Font.system(size: 14, weight: .regular)
    static let faqSectionTitle = Font.system(size: 20, weight: .bold)
    static let faqQuestion = Font.system(size: 16, weight: .medium)
    static let faqAnswer = Font.system(size: 14, weight: .regular)
}

// MARK: - Animation Constants
enum AnimationConstants {
    static let fadeAnimation = Animation.easeInOut(duration: 0.3)
    static let expandAnimation = Animation.spring(response: 0.3, dampingFraction: 0.8)
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
