import UIKit

final class ScreenFactory {
    
    static func createWorkoutsListScreen() -> WorkoutsListViewController {
        let model = WorkoutModel.create()
        let view = WorkoutsListViewController()
        let presenter = WorkoutsListPresenter(model: model, view: view)
        
        view.workoutsListPresenter = presenter
        return view
    }
    
    static func createWorkoutSelectedScreen(workoutId: Int) -> WorkoutSelectedViewController {
        let model = WorkoutModel.create()
        let view = WorkoutSelectedViewController()
        let presenter = WorkoutSelectedPresenter(model: model, view: view, selectedWorkoutID: workoutId)
        
        view.workoutSelectedPresenter = presenter
        
        return view
    }
    
    static func createLeaderboardScreen(workoutId: Int) -> LeaderboardViewController {
        let model = WorkoutModel.create()
        let view = LeaderboardViewController()
        let presenter = LeaderboardPresenter(model: model, view: view, selectedWorkout: workoutId)
        
        view.leaderboardPresenter = presenter
        
        return view
    }
}
 
