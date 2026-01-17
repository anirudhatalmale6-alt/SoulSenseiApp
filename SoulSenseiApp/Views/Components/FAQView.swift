import SwiftUI

struct FAQView: View {
    let faqs: [FAQ]
    let expandedIds: Set<String>
    let onToggle: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Title
            Text("Frequently Asked Questions")
                .font(AppFonts.faqSectionTitle)
                .foregroundColor(AppColors.primaryText)
                .padding(.horizontal, LayoutConstants.horizontalPadding)

            // FAQ List
            VStack(spacing: 12) {
                ForEach(faqs) { faq in
                    FAQItemView(
                        faq: faq,
                        isExpanded: expandedIds.contains(faq.id),
                        onTap: {
                            withAnimation(AnimationConstants.expandAnimation) {
                                onToggle(faq.id)
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, LayoutConstants.horizontalPadding)
        }
    }
}

#Preview {
    FAQView(
        faqs: [
            FAQ(question: "What is SoulSensei?", answer: "SoulSensei is a platform dedicated to connecting you with trusted guides."),
            FAQ(question: "How can SoulSensei help you?", answer: "At SoulSensei, we foster meaningful connections through live interactions.")
        ],
        expandedIds: ["What is SoulSensei?"],
        onToggle: { _ in }
    )
    .background(Color.gray.opacity(0.1))
}
