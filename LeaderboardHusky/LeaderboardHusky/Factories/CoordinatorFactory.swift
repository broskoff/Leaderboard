import UIKit

final class CoordinatorFactory {
    
    static func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController: navigationController)
    }
    
    static func createTrainingCoordinator(navigationController: UINavigationController) -> TrainingCoordinator {
        TrainingCoordinator(navigationController: navigationController)
    }
}
