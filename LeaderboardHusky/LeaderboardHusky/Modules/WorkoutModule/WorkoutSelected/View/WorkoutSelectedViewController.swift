import UIKit

protocol IWorkoutSelectedView: AnyObject {
    func setDataForImageAndDescription(workouts: [IWorkoutsModel], id selectedWorkout: Int)
}

final class WorkoutSelectedViewController: UIViewController, IWorkoutSelectedView  {
   
    var workoutSelectedPresenter: IWorkoutPresenter!
    
    private let workoutSelectedView = WorkoutSelectedView()
    private var workouts: [IWorkoutsModel]!
    private var selectedWorkoutId: Int!
    
    override func loadView() {
        super.loadView()
        
        view = workoutSelectedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutSelectedPresenter.getData()
    }
    
    func setDataForImageAndDescription(workouts: [any IWorkoutsModel], id: Int) {
       for workout in workouts {
            if workout.id == id {
                workoutSelectedView.workoutImageView.image = UIImage(named: workout.image)
                workoutSelectedView.workoutDescriptionTV.text = workout.description
                title = "Тренировка \(workout.date)"
            }
        }
        
    }
}

