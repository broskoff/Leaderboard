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
        let model = WorkoutModel.create()
        let view = WorkoutSelectedViewController()
        let presenter = WorkoutSelectedPresenter(model: model, view: view, selectedWorkoutID: workoutId) //передать workoutId с первого экрана
        
        view.workoutSelectedPresenter = presenter
        
        return view
    }
}
 
