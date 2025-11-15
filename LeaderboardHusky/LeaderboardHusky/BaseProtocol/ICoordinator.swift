import Foundation
import UIKit

typealias CoordinatorHandler = () -> ()

protocol ICoordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    var completionCoordinatorHandler: CoordinatorHandler? { get set }
    
    func start()
}
