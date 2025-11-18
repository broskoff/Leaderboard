import UIKit

final class TrainingCoordinator: ICoordinator {
    var navigationController: UINavigationController
    var completionCoordinatorHandler: CoordinatorHandler?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showWorkoutsListViewController()
    }
    
    func showWorkoutsListViewController() {
        //возможно вместо фабрикиЭкранов будет фабрикаБилдеров которая будет собирать МВП-экран
        let controller = ScreenFactory.createWorkoutsListScreen()
        
        controller.completionHandler = { [weak self] workoutId in
            self?.showWorkoutSelectedViewController(with: workoutId)
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showWorkoutSelectedViewController(with workoutId: Int) {
        let controller = ScreenFactory.createWorkoutSelectedScreen(workoutId: workoutId)
        
        controller.completionHandler = { [weak self] workoutId in
            self?.showLeaderboardViewController(with: workoutId)
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showLeaderboardViewController(with workoutId: Int) {
        let controller = ScreenFactory.createLeaderboardScreen(workoutId: workoutId)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
