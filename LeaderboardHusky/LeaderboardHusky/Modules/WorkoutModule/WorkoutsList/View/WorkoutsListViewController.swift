import UIKit

final class WorkoutsListViewController: UIViewController {
    
    let workoutsListView = WorkoutsListView()
    let workouts = WorkoutModel.create()
    
    override func loadView() {
        view = workoutsListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Тренировки дня"
        
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
        return 10
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


extension WorkoutsListViewController: UICollectionViewDelegate  {
    
}

extension WorkoutsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 170, height: 190)
    }
}
