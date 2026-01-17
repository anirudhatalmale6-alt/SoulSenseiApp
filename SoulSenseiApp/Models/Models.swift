import Foundation

// MARK: - API Response
struct APIResponse: Codable {
    let data: ResponseData
}

struct ResponseData: Codable {
    let rail: Rail
    let railPageFaqs: [FAQ]
}

// MARK: - Rail (Carousel Data)
struct Rail: Codable {
    let name: String
    let items: [RailItem]
    let bgImage: String
}

struct RailItem: Codable, Identifiable {
    let id: String
    let name: String
    let shortDescription: String
    let image: String
    let slug: String
    let about: String
}

// MARK: - FAQ
struct FAQ: Codable, Identifiable {
    let question: String
    let answer: String

    var id: String { question }
}

// MARK: - View State
enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case error(String)
}
