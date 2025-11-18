protocol ILeaderboardPresenter {
    func getData()
}

class LeaderboardPresenter: ILeaderboardPresenter {
    private let model: [IWorkoutsModel] //тут наверное уже будет модел ЛБ
    private let view: ILeaderboardView
    let selectedWorkout: Int
    
    init(model: [IWorkoutsModel], view: ILeaderboardView, selectedWorkout: Int) {
        self.model = model
        self.view = view
        self.selectedWorkout = selectedWorkout
    }
    
    func getData() {
        view.setData(workouts: model, id: selectedWorkout)
    }
}
