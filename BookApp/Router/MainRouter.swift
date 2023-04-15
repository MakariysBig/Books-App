import UIKit

final class MainRouter: MainRouterProtocol {
    
    //MARK: - Properties
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    //MARK: - Initialise
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    //MARK: - Methods
    
    func initialBookViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = moduleBuilder?.createBookModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(model: Book) {
        if let navigationController = navigationController {
            guard let describeViewController = moduleBuilder?.createDescribeModule(with: model, router: self) else { return }
            navigationController.pushViewController(describeViewController, animated: true)
        }
    }
}
