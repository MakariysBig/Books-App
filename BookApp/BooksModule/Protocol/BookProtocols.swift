import Foundation

//MARK: - View

protocol BookViewProtocol: AnyObject {
    func updateView()
    func updateButtonImage(with state: SortState)
    func networkError(with error: String)
}

//MARK: - Presenter

protocol BookPresenterProtocol {
    init(VC: BookViewProtocol, networkManager: NetworkProtocol, router: MainRouterProtocol)
    
    func getData()
    func sortData()
    func getArrayCount() -> Int
    func getModel(with index: Int) -> Book
    func showDetailModule(model: Book)
}
