protocol ILeaderboardPresenter {
    func getData()
    func selectGender(index: Int)
    func addResult(name: String, result: Int, gender: String)
    func getWorkoutDate()
    func getworkoutTypeResult()
    func deleteUserResult(object: UserResult)
}


final class LeaderboardPresenter: ILeaderboardPresenter {
    private let workoutId: Int
    private let workoutDate: String
    private var workoutTypeResult: TypeResult
    private var view: ILeaderboardView
    private var dataManager: ILeaderboardDataManager
    
    private var currentGender = "male"
    
    init(view: ILeaderboardView,
         selectedWorkout: (id: Int, typeResult: TypeResult, date: String),
         dataManager: ILeaderboardDataManager) {
        
        self.view = view
        self.dataManager = dataManager
        self.workoutId = selectedWorkout.id
        self.workoutTypeResult = selectedWorkout.typeResult
        self.workoutDate = selectedWorkout.date
    }
    
    func getworkoutTypeResult() {
        view.createAlertAddResult(workoutTypeResult: workoutTypeResult)
    }
    
    func getWorkoutDate() {
        view.setupLeaderboardTitle(workoutDate: workoutDate)
    }
    
    func getData() {
        loadAndShow()
    }
    
    func selectGender(index: Int) { 
        if index == 0 {
                currentGender = "male"
            } else {
                currentGender = "female"
            }
        
        loadAndShow()
    }
    
    func addResult(name: String, result: Int, gender: String) {
        switch workoutTypeResult {
        case .resultCount:
            dataManager.addResult(name: name,
                                  result: result,
                                  gender: gender,
                                  workoutId: workoutId,
                                  typeResult: workoutTypeResult.rawValue)
        case .resultTime:
            dataManager.addResult(name: name,
                                  result: result,
                                  gender: gender,
                                  workoutId: workoutId,
                                  typeResult: workoutTypeResult.rawValue)
        }
        loadAndShow()
    }
    
    private func loadAndShow() {
        let users = dataManager.fetchResults(for: workoutId,
                                             gender: currentGender,
                                             typeResult: workoutTypeResult)
        if users.isEmpty {
            view.showForEmptyLeaderboard(title: "Лидерборд пуст",
                                         message: "Пока нет результатов — добавь первый!")
            view.setLeaderboardData(users: [], workoutTypeResult: workoutTypeResult)
            return
        }
        view.setLeaderboardData(users: users, workoutTypeResult: workoutTypeResult)
    }
    
    func deleteUserResult(object: UserResult) {
        dataManager.deleteContext(object: object)
        
        loadAndShow()
    }
}
