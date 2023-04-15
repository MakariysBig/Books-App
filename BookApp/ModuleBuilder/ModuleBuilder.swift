import UIKit

final class ModuleBuilder: ModuleBuilderProtocol {
    func createDescribeModule(with model: Book, router: MainRouterProtocol) -> UIViewController {
        let VC = DescribeViewController()
        let presenter = DescribePresenter(VC: VC, model: model)
        VC.presenter = presenter
        
        return VC
    }
    
    func createBookModule(router: MainRouterProtocol) -> UIViewController {
        let VC = BookViewController()
        let networkManager = NetworkManager()
        let presenter = BookPresenter(VC: VC, networkManager: networkManager, router: router)
        VC.presenter = presenter
        
        return VC
    }
}
