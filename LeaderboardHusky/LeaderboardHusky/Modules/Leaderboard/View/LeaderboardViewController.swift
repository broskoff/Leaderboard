import UIKit

protocol ILeaderboardView: AnyObject {
    func setupLeaderboardTitle(workoutData: String)
    func setLeaderboardData(users: [UserResult])
    func showForEmptyLeaderboard(title: String, message: String)
}

final class LeaderboardViewController: UIViewController {
    
    var leaderboardPresenter: ILeaderboardPresenter!

    private let nameLeaderboard = "Лидерборд"
    private let leaderboardView = LeaderboardView()
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
        createAlert()
    }
}

extension LeaderboardViewController {
    func convertStringToSeconds(time: String) -> Int {
        let components = time.split(separator: ":")
        let minutes = Int(components[0]) ?? 0
        let seconds = Int(components[1]) ?? 0
        let totalScore = minutes * 60 + seconds
        return totalScore
    }
    
    func createAlert() {
        var name = ""
        var resultValue = 0
        var gender = ""
        
        let alert = UIAlertController(title: "Добавить результат", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Имя" }
        alert.addTextField { tf in
            switch self.leaderboardPresenter.workoutTypeResult {
                case .resultCount:
                    tf.placeholder = "Количество повторов"
                    tf.keyboardType = .numberPad
                case .resultTime:
                    tf.placeholder = "Время __:__"
                    tf.keyboardType = .numbersAndPunctuation
                }
        }
        alert.addTextField { $0.placeholder = "Пол (male/female)" }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Сохранить",
                                      style: .default,
                                      handler: { [weak self] _ in
            guard let self = self else { return }
            name = alert.textFields?[0].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Неизвестный"
            let resultText = alert.textFields?[1].text ?? "0"
                switch self.leaderboardPresenter.workoutTypeResult {
                case .resultCount:
                    resultValue = Int(resultText) ?? 0
                case .resultTime:
                    resultValue = convertStringToSeconds(time: resultText)
                }
            gender = alert.textFields?[2].text?.lowercased() ?? "male"//это должно быть через алерт.сегментКонтрол
            leaderboardPresenter.addResult(name: name, result: resultValue, gender: gender)
            
        }))
        present(alert, animated: true)
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

extension LeaderboardViewController: UITableViewDelegate {} //если захочу чтобы таблица реагировала на нажатия ячеек, на выделение строк, swipe-действия

extension LeaderboardViewController: ILeaderboardView {
    
    func setupLeaderboardTitle(workoutData: String) {
        title = "\(nameLeaderboard) \(workoutData)"
    }
    
    func setLeaderboardData(users: [UserResult]) {
        // Преобразование UserResult в модели для отображения и подсчёт рангов
        var models: [LeaderboardTableViewCellModel] = []
        for (index, user) in users.enumerated() {
            let rank = index + 1
            let name = user.name ?? "Неизвестный"
            
            var resultText = ""
            switch self.leaderboardPresenter.workoutTypeResult {
            case .resultCount:
                resultText = "\(user.resultCount)"
            case .resultTime:
                let totalSeconds = user.resultTime
                let minutes = totalSeconds / 60
                let seconds = totalSeconds % 60
                
                resultText = "\(minutes):\(seconds)"
            }
            
            models.append(LeaderboardTableViewCellModel(rank: rank, name: name, resultText: resultText))
        }
        self.cellModels = models
        leaderboardView.leaderboardTableView.reloadData()
    }

    func showForEmptyLeaderboard(title: String, message: String) {
        // Показываем аккуратно не блокирующий алерт (можно показывать только при первом запуске)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

