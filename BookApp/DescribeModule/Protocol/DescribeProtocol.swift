import Foundation

//MARK: - View

protocol DescribeViewProtocol: AnyObject {
    func updateView(with model: Book)
}

//MARK: - Presenter

protocol DescribePresenterProtocol {
    init(VC: DescribeViewProtocol, model: Book)
    
    func getData()
}
