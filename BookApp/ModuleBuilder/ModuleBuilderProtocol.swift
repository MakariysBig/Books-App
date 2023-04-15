import UIKit

protocol ModuleBuilderProtocol {
    func createBookModule(router: MainRouterProtocol) -> UIViewController
    func createDescribeModule(with model: Book, router: MainRouterProtocol) -> UIViewController
}
