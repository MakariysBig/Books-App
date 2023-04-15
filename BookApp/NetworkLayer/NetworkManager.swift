import Foundation

//MARK: - NetworkProtocol

protocol NetworkProtocol {
    func getBooks(completion: @escaping (Result< BookModel, Error >) -> Void)}

//MARK: - NetworkManager

final class NetworkManager: NetworkProtocol {
    private let networkEngine: NetworkEngine

    init(networkEngine: NetworkEngine = NetworkEngine()) {
        self.networkEngine = networkEngine
    }
    
    func getBooks(completion: @escaping (Result< BookModel, Error >) -> Void) {
        networkEngine.request(endpoint: BookEndpoint.getData, completion: completion)
    }
}
