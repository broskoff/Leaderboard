import UIKit

protocol IWorkoutsListView: AnyObject {
    func setDataInCell(_ data: [IWorkoutsListModel])
}

final class WorkoutsListViewController: UIViewController, IWorkoutsListView, IFlowController  {
    var completionHandler: ((Int) -> ())?
    var workoutsListPresenter: IWorkoutsListPresenter!
    
    private let workoutsListView = WorkoutsListView()
    private var workouts: [IWorkoutsListModel] = []
    
    override func loadView() {
        view = workoutsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Тренировки дня"
        
        configWorkoutsCollectionView()
        workoutsListPresenter.getData()
    }
    
    private func configWorkoutsCollectionView() {
        workoutsListView.workoutsCollectionView.dataSource = self
//коллекция, если что-то произойдёт — тап по ячейке — зови МЕНЯ. «меня» = ViewController (self).
        workoutsListView.workoutsCollectionView.delegate = self
        workoutsListView.workoutsCollectionView.register(
            WorkoutsListCollectionViewCell.self,
            forCellWithReuseIdentifier: WorkoutsListCollectionViewCell.id
        )
    }
    
    func setDataInCell(_ data: [IWorkoutsListModel]) {
        DispatchQueue.main.async {
            self.workouts = data
            self.workoutsListView.workoutsCollectionView.reloadData()
        }
    }
}

//ViewController делегат коллекции, решает что делать если над коллекцией совершили действие
extension WorkoutsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWorkout = workouts[indexPath.row].id
        completionHandler?(selectedWorkout)
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


extension WorkoutsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 170, height: 190)
    }
}
