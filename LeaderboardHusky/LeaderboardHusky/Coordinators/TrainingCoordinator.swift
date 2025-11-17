import UIKit

class TrainingCoordinator: ICoordinator {
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
        let controller = ScreenFactory().createWorkoutsListScreen()
        
        //тут еще добавится код который захватывает ячейку и передает инфу на следующий экран
        controller.completionHandler = { [weak self] workoutId in
            self?.showWorkoutSelectedViewController(workoutId: workoutId)
            
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showWorkoutSelectedViewController(workoutId: Int) {
        let controller = ScreenFactory().createWorkoutSelectedScreen(workoutId: workoutId)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
