import Foundation

final class DescribePresenter: DescribePresenterProtocol {
    
    //MARK: - Properties
    
    private weak var VC: DescribeViewProtocol?
    private let model: Book
    
    //MARK: - Initialise
    
    init(VC: DescribeViewProtocol, model: Book) {
        self.VC = VC
        self.model = model
    }
    
    //MARK: - Methods
    
    func getData() {
        VC?.updateView(with: model)
    }
}
