protocol IWorkoutPresenter {
    func getData()
}

final class WorkoutSelectedPresenter: IWorkoutPresenter {
    private var model: [IWorkoutsModel]
    private var view: IWorkoutSelectedView
    var selectedWorkoutID: Int!
    
    init(model: [IWorkoutsModel], view: IWorkoutSelectedView, selectedWorkoutID: Int!) {
        self.model = model
        self.view = view
        self.selectedWorkoutID = selectedWorkoutID
    }
    
    func getData() {
        view.setDataForImageAndDescription(workouts: model, id: selectedWorkoutID) //сюда должн передаться id с прошлого экрана
    }
    
    
}
