import Foundation
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
        let viewController = ScreenFactory().createWorkoutsListScreen()
        
        //тут еще добавится код который захватывает ячейку и передает инфу на следующий экран
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
