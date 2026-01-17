import Foundation

// MARK: - Network Error
enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func fetchData() async throws -> ResponseData
}

// MARK: - Network Service
final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchData() async throws -> ResponseData {
        guard let url = URL(string: APIConstants.baseURL) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            let apiResponse = try decoder.decode(APIResponse.self, from: data)
            return apiResponse.data
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}

// MARK: - Mock Network Service (for Previews)
final class MockNetworkService: NetworkServiceProtocol {
    var shouldFail = false

    func fetchData() async throws -> ResponseData {
        try await Task.sleep(nanoseconds: 500_000_000)

        if shouldFail {
            throw NetworkError.requestFailed(NSError(domain: "Mock", code: -1))
        }

        return ResponseData(
            rail: Rail(
                name: "1 on 1",
                items: [
                    RailItem(
                        id: "1",
                        name: "Arjun Aiyar",
                        shortDescription: "Mentor, Life Coach And Spiritual Teacher",
                        image: "https://soulsensei.gumlet.io/cc513743-5a91-491d-ad30-ed1a46ec0685.jpg",
                        slug: "arjun-aiyar",
                        about: "Sample about text"
                    ),
                    RailItem(
                        id: "2",
                        name: "Tamanna C",
                        shortDescription: "Spiritual Coach, Psychic Healer and Angel Therapist",
                        image: "https://soulsensei.gumlet.io/e17937df-b86a-43ff-b5ce-929f326a58f9.jpg",
                        slug: "tamanna-c",
                        about: "Sample about text"
                    )
                ],
                bgImage: "https://soulsensei.gumlet.io/e41e290d-cb1f-4d12-9fc2-d3bfdaf83ecf.png"
            ),
            railPageFaqs: [
                FAQ(question: "What is SoulSensei?", answer: "SoulSensei is a platform dedicated to connecting you with trusted guides."),
                FAQ(question: "How can SoulSensei help you?", answer: "At SoulSensei, we foster meaningful connections through live interactions.")
            ]
        )
    }
}
