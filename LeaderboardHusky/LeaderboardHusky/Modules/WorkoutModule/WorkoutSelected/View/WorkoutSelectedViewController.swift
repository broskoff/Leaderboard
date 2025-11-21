import UIKit

protocol IWorkoutSelectedView: AnyObject {
    func setDataForImageAndDescription(workouts: [IWorkoutSelectedModel], id selectedWorkout: Int)
    func setLoadingState()
}

final class WorkoutSelectedViewController: UIViewController, IWorkoutSelectedView  {
    var completionHandler: ((Int, String, String) -> ())?
    
    var workoutSelectedPresenter: IWorkoutPresenter?
    
    private let workoutSelectedView = WorkoutSelectedView()
    private var selectedWorkout: IWorkoutSelectedModel?
    
    override func loadView() {
        super.loadView()
        
        view = workoutSelectedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutSelectedPresenter?.getData()
        
        workoutSelectedView.leaderboardButton.addTarget(self,
                                                        action: #selector(buttonTapped),
                                                        for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        guard let selectedWorkout = selectedWorkout else { return }
        completionHandler?(selectedWorkout.id, selectedWorkout.typeResult, selectedWorkout.date)
    }
    
    func setDataForImageAndDescription(workouts: [IWorkoutSelectedModel], id: Int) {
        guard let workout = workouts.first else { return }
        
        let imageURL = URL(string: workout.image)
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.workoutSelectedView.workoutImageView.image = UIImage(data: imageData)
                self.workoutSelectedView.workoutDescriptionTV.text = workout.description
                self.title = "\(Headlines.workout.rawValue) \(workout.date)"
                self.hideLoadingState()
            }
            self.selectedWorkout = workout
        }
    }
    
    func setLoadingState() {
        workoutSelectedView.activityIndicatorView.startAnimating()
        workoutSelectedView.activityIndicatorView.isHidden = false
    }
    
    private func hideLoadingState() {
        workoutSelectedView.activityIndicatorView.stopAnimating()
    }
}

