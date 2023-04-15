import Foundation

//MARK: - Book Endpoint

enum BookEndpoint: Endpoint {
    case getData
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURl: String {
        switch self {
        default:
            return "openlibrary.org"
        }
    }

    var path: String {
        switch self {
        case .getData:
            return "/search.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getData:
            return [
                     URLQueryItem(name: "author",   value: "rowling"),
                     URLQueryItem(name: "title",    value: "harry+potter"),
                     URLQueryItem(name: "language", value: "eng")
            ]
        }
    }

    var method: String {
        switch self {
        case .getData:
            return "GET"
        }
    }
}
