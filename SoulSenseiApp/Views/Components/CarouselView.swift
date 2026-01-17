import SwiftUI

struct CarouselView: View {
    let rail: Rail
    @Binding var currentIndex: Int

    private let cardSpacing: CGFloat = 16

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Title
            Text(rail.name)
                .font(AppFonts.carouselTitle)
                .foregroundColor(AppColors.primaryText)
                .padding(.horizontal, LayoutConstants.horizontalPadding)

            // Horizontal Carousel using TabView for reliable paging
            TabView(selection: $currentIndex) {
                ForEach(Array(rail.items.enumerated()), id: \.element.id) { index, item in
                    CarouselCardView(
                        item: item,
                        isActive: index == currentIndex
                    )
                    .padding(.horizontal, 24)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: LayoutConstants.cardHeight + 20)
            .animation(AnimationConstants.fadeAnimation, value: currentIndex)

            // Page Indicator
            HStack(spacing: 8) {
                ForEach(0..<rail.items.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? AppColors.accentColor : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .scaleEffect(index == currentIndex ? 1.2 : 1.0)
                        .animation(AnimationConstants.fadeAnimation, value: currentIndex)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CarouselView(
        rail: Rail(
            name: "1 on 1",
            items: [
                RailItem(
                    id: "1",
                    name: "Arjun Aiyar",
                    shortDescription: "Mentor, Life Coach And Spiritual Teacher",
                    image: "https://soulsensei.gumlet.io/cc513743-5a91-491d-ad30-ed1a46ec0685.jpg",
                    slug: "arjun-aiyar",
                    about: "Sample"
                ),
                RailItem(
                    id: "2",
                    name: "Tamanna C",
                    shortDescription: "Spiritual Coach, Psychic Healer",
                    image: "https://soulsensei.gumlet.io/e17937df-b86a-43ff-b5ce-929f326a58f9.jpg",
                    slug: "tamanna-c",
                    about: "Sample"
                )
            ],
            bgImage: ""
        ),
        currentIndex: .constant(0)
    )
}
