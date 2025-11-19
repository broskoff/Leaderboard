protocol ILeaderboardPresenter {
    func getData()
}

class LeaderboardPresenter: ILeaderboardPresenter {
    typealias SelectedWorkout = (Int, TypeResult, String)
    
    private let model: [IWorkoutSelectedModel] //тут наверное уже будет модел ЛБ
    private let view: ILeaderboardView
    let selectedWorkout: SelectedWorkout
    
    init(model: [IWorkoutSelectedModel], view: ILeaderboardView, selectedWorkout: SelectedWorkout) {
        self.model = model
        self.view = view
        self.selectedWorkout = selectedWorkout
    }
    
    func getData() {
        view.setData(workouts: model, workout: selectedWorkout)
    }
}
