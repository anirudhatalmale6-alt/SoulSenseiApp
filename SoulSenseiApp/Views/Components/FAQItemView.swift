import SwiftUI

struct FAQItemView: View {
    let faq: FAQ
    let isExpanded: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Question Row
            Button(action: onTap) {
                HStack(alignment: .center, spacing: 12) {
                    Text(faq.question)
                        .font(AppFonts.faqQuestion)
                        .foregroundColor(AppColors.primaryText)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.chevronColor)
                        .rotationEffect(.degrees(isExpanded ? 0 : 0))
                }
                .padding(LayoutConstants.faqPadding)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            // Answer (Expandable)
            if isExpanded {
                Text(faq.answer)
                    .font(AppFonts.faqAnswer)
                    .foregroundColor(AppColors.secondaryText)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, LayoutConstants.faqPadding)
                    .padding(.bottom, LayoutConstants.faqPadding)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(AppColors.faqBackground)
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.faqCornerRadius))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    VStack(spacing: 16) {
        FAQItemView(
            faq: FAQ(
                question: "What is SoulSensei?",
                answer: "SoulSensei is a platform dedicated to connecting you with trusted guides across practices and modalities."
            ),
            isExpanded: false,
            onTap: {}
        )

        FAQItemView(
            faq: FAQ(
                question: "How can SoulSensei help you?",
                answer: "At SoulSensei, we foster meaningful connections through live interactions with trusted guides."
            ),
            isExpanded: true,
            onTap: {}
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
