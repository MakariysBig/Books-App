import Foundation

// MARK: - Welcome
struct BookModel: Codable {
    let numFound, start: Int
    let numFoundExact: Bool
    let docs: [Book]
    let welcomeNumFound: Int
    let q: String

    enum CodingKeys: String, CodingKey {
        case numFound, start, numFoundExact, docs
        case welcomeNumFound = "num_found"
        case q
    }
}

// MARK: - Doc
struct Book: Codable {
    let title: String
    let firstPublishYear: Int
    let ratingsAverage: Double?
    let coverI: Int?
    let firstSentence: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case firstPublishYear = "first_publish_year"
        case ratingsAverage = "ratings_average"
        case coverI = "cover_i"
        case firstSentence = "first_sentence"
    }
}

// MARK: - Sort

enum SortState {
    case up
    case down
}
