import Foundation

final class BookPresenter: BookPresenterProtocol {
    
    //MARK: - Private properties
    
    private let dispatchGroup = DispatchGroup()
    private let router: MainRouterProtocol?
    private let networkManager: NetworkProtocol?

    private weak var VC: BookViewProtocol?
    private var booksArray = [Book]()
    private var sortState: SortState?

    //MARK: - Initialise
    
    init(VC: BookViewProtocol, networkManager: NetworkProtocol, router: MainRouterProtocol) {
        self.VC = VC
        self.networkManager = networkManager
        self.router = router
    }
    
    //MARK: - Internal methods
    
    func showDetailModule(model: Book) {
        router?.showDetail(model: model)
    }
    
    func getArrayCount() -> Int {
        booksArray.count
    }
    
    func getModel(with index: Int) -> Book {
        return booksArray[index]
    }
    
    func sortData() {
        if sortState == .up {
            sortState = .down
            booksArray = booksArray.sorted { $0.firstPublishYear > $1.firstPublishYear }
        } else {
            sortState = .up
            booksArray = booksArray.sorted { $0.firstPublishYear < $1.firstPublishYear }
        }
        VC?.updateButtonImage(with: sortState ?? .down)
    }
    
    func getData() {
        networkManager?.getBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.booksArray = data.docs
                self.VC?.updateView()
            case .failure(let error):
                self.VC?.networkError(with: error.localizedDescription)
            }
        }
    }
}
