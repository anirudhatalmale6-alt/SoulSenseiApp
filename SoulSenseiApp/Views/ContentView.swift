import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        Group {
            switch viewModel.viewState {
            case .idle, .loading:
                LoadingView()

            case .loaded:
                mainContent

            case .error(let message):
                ErrorView(message: message) {
                    Task {
                        await viewModel.retry()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }

    private var mainContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: LayoutConstants.verticalSpacing) {
                // Horizontal Carousel Section
                if let rail = viewModel.rail {
                    CarouselView(
                        rail: rail,
                        currentIndex: Binding(
                            get: { viewModel.currentCarouselIndex },
                            set: { viewModel.currentCarouselIndex = $0 }
                        )
                    )
                }

                // FAQ Section
                if !viewModel.faqs.isEmpty {
                    FAQView(
                        faqs: viewModel.faqs,
                        expandedIds: viewModel.expandedFAQIds,
                        onToggle: { id in
                            viewModel.toggleFAQ(id: id)
                        }
                    )
                }

                Spacer(minLength: 32)
            }
            .padding(.top, 16)
        }
        .background(AppColors.background)
    }
}

#Preview {
    ContentView()
}
