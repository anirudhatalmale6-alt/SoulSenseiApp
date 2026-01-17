import SwiftUI

struct CarouselCardView: View {
    let item: RailItem
    let isActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Section
            AsyncImageView(url: item.image)
                .frame(height: LayoutConstants.cardImageHeight)
                .clipped()

            // Text Content
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(AppFonts.cardName)
                    .foregroundColor(AppColors.primaryText)
                    .lineLimit(1)

                Text(item.shortDescription)
                    .font(AppFonts.cardDescription)
                    .foregroundColor(AppColors.secondaryText)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: LayoutConstants.cardHeight)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cardCornerRadius))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .opacity(isActive ? 1.0 : 0.7)
        .scaleEffect(isActive ? 1.0 : 0.92)
        .animation(AnimationConstants.fadeAnimation, value: isActive)
    }
}

#Preview {
    CarouselCardView(
        item: RailItem(
            id: "1",
            name: "Arjun Aiyar",
            shortDescription: "Mentor, Life Coach And Spiritual Teacher",
            image: "https://soulsensei.gumlet.io/cc513743-5a91-491d-ad30-ed1a46ec0685.jpg",
            slug: "arjun-aiyar",
            about: "Sample about"
        ),
        isActive: true
    )
    .padding()
}
