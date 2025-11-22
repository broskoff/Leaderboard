import UIKit

protocol ILeaderboardView: AnyObject {
    func setupLeaderboardTitle(workoutDate: String)
    func setLeaderboardData(users: [UserResult], workoutTypeResult: String)
    func showForEmptyLeaderboard(title: String, message: String)
    func createAlertAddResult(workoutTypeResult: String)
}

final class LeaderboardViewController: UIViewController {
    var leaderboardPresenter: ILeaderboardPresenter?
    
    private let leaderboardView = LeaderboardView()
    private var userResults: [UserResult] = []
    private var cellModels: [LeaderboardTableViewCellModel] = []
    
    override func loadView() {
        view = leaderboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardPresenter?.getWorkoutDate()
        
        configLeaderboardTableView()
        setupActions()
        leaderboardPresenter?.getData()
    }
    
    private func configLeaderboardTableView() {
        leaderboardView.leaderboardTableView.register(LeaderboardTableViewCell.self,
                                                      forCellReuseIdentifier: LeaderboardTableViewCell.id)
        leaderboardView.leaderboardTableView.dataSource = self
        leaderboardView.leaderboardTableView.delegate = self
        leaderboardView.leaderboardTableView.rowHeight = 60
        leaderboardView.leaderboardTableView.tableFooterView = UIView()
    }
    
    private func setupActions() {
        leaderboardView.leaderboardSegmentControl.addTarget(self,
                                                            action: #selector(segmentChanged(_:)),
                                                            for: .valueChanged)
        
        leaderboardView.addResultButton.addTarget(self,
                                                  action: #selector(addResultTapped),
                                                  for: .touchUpInside)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        leaderboardPresenter?.selectGender(index: sender.selectedSegmentIndex)
    }
    
    @objc private func addResultTapped() {
        leaderboardPresenter?.getworkoutTypeResult()
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.id,
                                                       for: indexPath) as? LeaderboardTableViewCell else { return UITableViewCell()}
        let model = cellModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: LeaderboardText.delete) { [weak self] _, _, _ in
            guard let self = self else { return }
            
            let deleteResult = userResults[indexPath.row]
            leaderboardPresenter?.deleteUserResult(object: deleteResult)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}

extension LeaderboardViewController: ILeaderboardView {
    func setupLeaderboardTitle(workoutDate: String) {
        title = "\(Headlines.leaderboard) \(workoutDate)"
    }
    
    func setLeaderboardData(users: [UserResult], workoutTypeResult: String) {
        userResults = users
        var models: [LeaderboardTableViewCellModel] = []
        for (index, user) in users.enumerated() {
            let rank = index + 1
            guard let name = user.name else { return }
            
            var resultText = ""
            switch workoutTypeResult { 
            case TypeResult.count:
                resultText = "\(user.resultCount)"
            case TypeResult.time:
                let totalSeconds = user.resultTime
                let minutes = totalSeconds / 60
                let seconds = totalSeconds % 60
                if seconds < 10 {
                    resultText = "\(minutes):0\(seconds)"
                } else {
                    resultText = "\(minutes):\(seconds)"
                }
            default:
                break
            }
            
            models.append(LeaderboardTableViewCellModel(rank: rank, name: name, resultText: resultText))
        }
        self.cellModels = models
        leaderboardView.leaderboardTableView.reloadData()
    }
    
    func showForEmptyLeaderboard(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LeaderboardText.ok, style: .default))
        present(alert, animated: true)
    }
    
    func createAlertAddResult(workoutTypeResult: String) {
        var name = ""
        var resultValue = 0
        var gender = ""
        
        let alert = UIAlertController(title: LeaderboardText.addResult, message: LeaderboardText.space, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = LeaderboardAlertField.name }
        alert.addTextField { tf in
            switch workoutTypeResult {
            case TypeResult.count:
                tf.placeholder = LeaderboardAlertField.countRep
                tf.keyboardType = .numberPad
            case TypeResult.time:
                tf.placeholder = LeaderboardAlertField.time
                tf.keyboardType = .numbersAndPunctuation
            default:
                break
            }
        }
        
        let genderSegment = UISegmentedControl(items: [LeaderboardButtonText.boy, LeaderboardButtonText.girl])
        genderSegment.selectedSegmentIndex = 0
        alert.view.addSubview(genderSegment)
        genderSegment.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        alert.addAction(UIAlertAction(title: LeaderboardButtonText.cancel, style: .cancel))
        alert.addAction(UIAlertAction(title: LeaderboardButtonText.save,
                                      style: .default,
                                      handler: { [weak self] _ in
            guard let self = self else { return }
            
            name = alert.textFields?[0].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Неизвестный"
            
            let resultText = alert.textFields?[1].text ?? "0"
            switch workoutTypeResult {
            case TypeResult.count:
                resultValue = Int(resultText) ?? 0
            case TypeResult.time:
                resultValue = convertStringToSeconds(time: resultText) //сделать проверку, результат запихнуть в презентер, пусть он конвертить время
            default:
                break
            }
            
            switch genderSegment.selectedSegmentIndex {
            case 0:
                gender = Gender.male
            case 1:
                gender = Gender.female
            default:
                break
            }
            leaderboardPresenter?.addResult(name: name, result: resultValue, gender: gender)
            
        }))
        present(alert, animated: true)
    }
    
    private func convertStringToSeconds(time: String) -> Int {
        let components = time.split(separator: ":")
        
        guard components.count == 2 else { return 0 }
        let minutes = Int(components[0]) ?? 0
        let seconds = Int(components[1]) ?? 0
        let totalScore = minutes * 60 + seconds
        return totalScore
    }
}
