import UIKit

protocol IWorkoutSelectedView: AnyObject {
    func setDataForImageAndDescription(workouts: [IWorkoutSelectedModel], id selectedWorkout: Int)
}

final class WorkoutSelectedViewController: UIViewController, IWorkoutSelectedView  {
    var completionHandler: ((Int, TypeResult, String) -> ())?
   
    var workoutSelectedPresenter: IWorkoutPresenter!
    
    private let workoutSelectedView = WorkoutSelectedView()
    private var workouts: [IWorkoutSelectedModel]!
    private var selectedWorkout: IWorkoutSelectedModel!
    
    override func loadView() {
        super.loadView()
        
        view = workoutSelectedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutSelectedPresenter.getData()
        
        workoutSelectedView.leaderboardButton.addTarget(self,
                                                        action: #selector(buttonTapped),
                                                        for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        completionHandler?(selectedWorkout.id, selectedWorkout.typeResult, selectedWorkout.date)
    }
    
    func setDataForImageAndDescription(workouts: [any IWorkoutSelectedModel], id: Int) {
       for workout in workouts {
            if workout.id == id {
                workoutSelectedView.workoutImageView.image = UIImage(named: workout.image)
                workoutSelectedView.workoutDescriptionTV.text = workout.description
                title = "Тренировка \(workout.date)"
                
                selectedWorkout = workout
            }
        }
    }
}

