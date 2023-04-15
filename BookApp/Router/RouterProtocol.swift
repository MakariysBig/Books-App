import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol MainRouterProtocol: RouterProtocol {
    func initialBookViewController()
    func showDetail(model: Book)
}
