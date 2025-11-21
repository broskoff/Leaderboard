import UIKit

final class ScreenFactory {
    
    static func createWorkoutsListScreen() -> WorkoutsListViewController {
        let networkManager = NetworkManager()
        let view = WorkoutsListViewController()
        let presenter = WorkoutsListPresenter(view: view, networkManager: networkManager)
        
        view.workoutsListPresenter = presenter
        return view
    }
    
    static func createWorkoutSelectedScreen(workoutId: Int) -> WorkoutSelectedViewController {
        let networkManager = NetworkManager()
        let view = WorkoutSelectedViewController()
        let presenter = WorkoutSelectedPresenter(view: view, selectedWorkoutID: workoutId, networkManager: networkManager)
        
        view.workoutSelectedPresenter = presenter
        
        return view
    }
    
    static func createLeaderboardScreen(workout: (id: Int, typeResult: String, date: String)) -> LeaderboardViewController {
        let dataManager = LeaderboardDataManager()
        let view = LeaderboardViewController()
        let presenter = LeaderboardPresenter(view: view, selectedWorkout: workout, dataManager: dataManager)
        
        view.leaderboardPresenter = presenter
        
        return view
    }
}
 
