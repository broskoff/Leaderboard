import UIKit

final class AppCoordinator: ICoordinator {
    var navigationController: UINavigationController
    var completionCoordinatorHandler: CoordinatorHandler?
    
    private var childCoordinators: [ICoordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showTrainingCoordinator()
    }
    
    private func showTrainingCoordinator() {
        let trainingCoordinator = CoordinatorFactory().createTrainingCoordinator(navigationController: navigationController)
        
        childCoordinators.append(trainingCoordinator)
        trainingCoordinator.start()
    }
    
}
