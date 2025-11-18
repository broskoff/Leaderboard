import UIKit

protocol ILeaderboardView {
    func setData(workouts: [IWorkoutsModel], id: Int)
}

final class LeaderboardViewController: UIViewController {
    
    var leaderboardPresenter: ILeaderboardPresenter!
    
    private let leaderboardView = LeaderboardView()
    
    override func loadView() {
        super.loadView()
        
        view = leaderboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configLeaderboardTableView()
        
        leaderboardPresenter.getData()
        
        //MOCK
        MockData.currentLeaderboard = MockData.boysLeaderboard
        
        leaderboardView.leaderboardSegmentControl.addTarget(self,
                                                            action: #selector(segmentChanged),
                                                            for: .valueChanged)
    }
    
    //MOCK
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            MockData.currentLeaderboard = MockData.boysLeaderboard
        } else {
            MockData.currentLeaderboard = MockData.girlsLeaderboard
        }
        
        leaderboardView.leaderboardTableView.reloadData()
    }
    
    private func configLeaderboardTableView() {
        leaderboardView.leaderboardTableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.id)
        
        leaderboardView.leaderboardTableView.dataSource = self
        leaderboardView.leaderboardTableView.delegate = self
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return MockData.currentLeaderboard.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.id, for: indexPath) as! LeaderboardTableViewCell
        //MOCK
        let item = MockData.currentLeaderboard[indexPath.row]
        cell.configure(rank: item.rank, name: item.name, result: item.result)
        
        return cell
    }
}

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension LeaderboardViewController: ILeaderboardView {
    func setData(workouts: [IWorkoutsModel], id: Int) {
        for workout in workouts {
            if workout.id == id {
                title = "Лидерборд \(workout.date)"
            }
        }
    }
}
