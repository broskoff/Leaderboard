import UIKit

enum StateWorkoutsListScreen {
    case loading
    case loaded([IWorkoutsListModel])
    case error(ServiceError)
}

protocol IWorkoutsListView: AnyObject {
    func render(state: StateWorkoutsListScreen)
}

final class WorkoutsListViewController: UIViewController, IWorkoutsListView  {
    var completionHandler: ((Int) -> ())?
    var workoutsListPresenter: IWorkoutsListPresenter?
    
    private var workouts: [IWorkoutsListModel] = []
    private let workoutsListView = WorkoutsListView()
    
    override func loadView() {
        view = workoutsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Headlines.workouts
        workoutsListPresenter?.getData()
        configWorkoutsCollectionView()
    }
    
    private func configWorkoutsCollectionView() {
        workoutsListView.workoutsCollectionView.dataSource = self
        workoutsListView.workoutsCollectionView.delegate = self
        workoutsListView.workoutsCollectionView.register(
            WorkoutsListCollectionViewCell.self,
            forCellWithReuseIdentifier: WorkoutsListCollectionViewCell.id
        )
    }
}

extension WorkoutsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = workoutsListView.workoutsCollectionView.dequeueReusableCell(withReuseIdentifier: WorkoutsListCollectionViewCell.id, for: indexPath) as? WorkoutsListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let workout = workouts[indexPath.row]
        cell.setData(workout: workout.image, date: workout.date)
        return cell
    }
}

extension WorkoutsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWorkout = workouts[indexPath.row].id
        completionHandler?(selectedWorkout)
    }
}

extension WorkoutsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: WorkoutsList.widthCellCollectionView,
                      height: WorkoutsList.heightCellCollectionView)
    }
}

extension WorkoutsListViewController {
    func render(state: StateWorkoutsListScreen) {
        switch state {
        case .loading:
            self.workoutsListView.activityIndicatorView.isHidden = false
            self.workoutsListView.workoutsCollectionView.isHidden = true
        case .loaded(let workouts):
            self.workoutsListView.activityIndicatorView.isHidden = true
            self.workoutsListView.workoutsCollectionView.isHidden = false
            self.workouts = workouts
            self.workoutsListView.workoutsCollectionView.reloadData()
        case .error(let error):
            print(error)
        }
    }
}
