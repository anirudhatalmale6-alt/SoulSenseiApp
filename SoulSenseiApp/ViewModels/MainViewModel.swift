import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var viewState: ViewState<ResponseData> = .idle
    @Published var expandedFAQIds: Set<String> = []
    @Published var currentCarouselIndex: Int = 0

    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol

    // MARK: - Computed Properties
    var rail: Rail? {
        if case .loaded(let data) = viewState {
            return data.rail
        }
        return nil
    }

    var faqs: [FAQ] {
        if case .loaded(let data) = viewState {
            return data.railPageFaqs
        }
        return []
    }

    var isLoading: Bool {
        if case .loading = viewState {
            return true
        }
        return false
    }

    var errorMessage: String? {
        if case .error(let message) = viewState {
            return message
        }
        return nil
    }

    // MARK: - Initialization
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    // MARK: - Public Methods
    func fetchData() async {
        viewState = .loading

        do {
            let data = try await networkService.fetchData()
            viewState = .loaded(data)
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }

    func toggleFAQ(id: String) {
        if expandedFAQIds.contains(id) {
            expandedFAQIds.remove(id)
        } else {
            expandedFAQIds.insert(id)
        }
    }

    func isFAQExpanded(id: String) -> Bool {
        expandedFAQIds.contains(id)
    }

    func retry() async {
        await fetchData()
    }
}
