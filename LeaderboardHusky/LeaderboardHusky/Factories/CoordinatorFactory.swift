import Foundation
import UIKit

final class CoordinatorFactory {
    
    func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController: navigationController)
    }
    
    func createTrainingCoordinator(navigationController: UINavigationController) -> TrainingCoordinator {
        TrainingCoordinator(navigationController: navigationController)
    }
}
