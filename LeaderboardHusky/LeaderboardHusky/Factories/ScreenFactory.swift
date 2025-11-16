import Foundation
import UIKit

class ScreenFactory {
    
    func createWorkoutsListScreen() -> WorkoutsListViewController {
        let model = WorkoutModel.create()
        let view = WorkoutsListViewController()
        let presenter = WorkoutsListPresenter(model: model, view: view)
        
        view.workoutsListPresenter = presenter
        return view
    }
    
    func createWorkoutSelectedScreen(workoutId: Int) -> WorkoutSelectedViewController {
        WorkoutSelectedViewController()
    }
}
 
