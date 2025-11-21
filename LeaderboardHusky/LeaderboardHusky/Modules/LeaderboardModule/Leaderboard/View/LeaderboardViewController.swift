import UIKit

protocol ILeaderboardView: AnyObject {
    func setupLeaderboardTitle(workoutDate: String)
    func setLeaderboardData(users: [UserResult], workoutTypeResult: String)
    func showForEmptyLeaderboard(title: String, message: String)
    func createAlertAddResult(workoutTypeResult: String)
}

final class LeaderboardViewController: UIViewController {
    
    var leaderboardPresenter: ILeaderboardPresenter!

    private let nameLeaderboard = "Лидерборд"
    private let leaderboardView = LeaderboardView()
    private var userResults: [UserResult] = []
    private var cellModels: [LeaderboardTableViewCellModel] = []

    override func loadView() {
        view = leaderboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardPresenter.getWorkoutDate()
        
        configLeaderboardTableView()
        setupActions()
        leaderboardPresenter.getData()
    }

    private func configLeaderboardTableView() {
        leaderboardView.leaderboardTableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.id)
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
        leaderboardPresenter.selectGender(index: sender.selectedSegmentIndex)
    }

    @objc private func addResultTapped() {
        leaderboardPresenter.getworkoutTypeResult()
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.id, for: indexPath) as! LeaderboardTableViewCell
        let model = cellModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

extension LeaderboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Удалить") { [weak self] _, _, _ in
            guard let self = self else { return }
            
            let deleteResult = userResults[indexPath.row]
            leaderboardPresenter.deleteUserResult(object: deleteResult)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}

extension LeaderboardViewController: ILeaderboardView {
    
    func setupLeaderboardTitle(workoutDate: String) {
        title = "\(nameLeaderboard) \(workoutDate)"
    }
    
    func setLeaderboardData(users: [UserResult], workoutTypeResult: String) {
        userResults = users
        // Преобразование UserResult в модел для отображения
        var models: [LeaderboardTableViewCellModel] = []
        for (index, user) in users.enumerated() {
            let rank = index + 1
            let name = user.name ?? "Неизвестный"
            
            var resultText = ""
            switch workoutTypeResult { //обратный конвертер времени утащить в презентер
            case "0":
                resultText = "\(user.resultCount)"
            case "1":
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
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
    
    func createAlertAddResult(workoutTypeResult: String) {
        var name = ""
        var resultValue = 0
        var gender = ""
        
        let alert = UIAlertController(title: "Добавить результат", message: "\n\n\n", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Имя" }
        alert.addTextField { tf in
            switch workoutTypeResult {
                case "0":
                    tf.placeholder = "Количество повторов"
                    tf.keyboardType = .numberPad
                case "1":
                    tf.placeholder = "Время __:__"
                    tf.keyboardType = .numbersAndPunctuation
            default:
                break
            }
        }
        
        let genderSegment = UISegmentedControl(items: ["Парень", "Девушка"])
        genderSegment.selectedSegmentIndex = 0
        alert.view.addSubview(genderSegment)
        genderSegment.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Сохранить",
                                      style: .default,
                                      handler: { [weak self] _ in
            guard let self = self else { return }
            
            name = alert.textFields?[0].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Неизвестный"
            
            let resultText = alert.textFields?[1].text ?? "0"
                switch workoutTypeResult {
                case "0":
                    resultValue = Int(resultText) ?? 0
                case "1":
                    resultValue = convertStringToSeconds(time: resultText) //сделать проверку, результат запихнуть в презентер, пусть он конвертить время
                default:
                    break
                }
            
            switch genderSegment.selectedSegmentIndex {
            case 0:
                gender = "male"
            case 1:
                gender = "female"
            default:
                break
            }
            leaderboardPresenter.addResult(name: name, result: resultValue, gender: gender)
            
        }))
        present(alert, animated: true)
    }
    
    func convertStringToSeconds(time: String) -> Int {
        let components = time.split(separator: ":")
        let minutes = Int(components[0]) ?? 0
        let seconds = Int(components[1]) ?? 0
        let totalScore = minutes * 60 + seconds
        return totalScore
    }
}

