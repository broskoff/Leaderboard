import Foundation

protocol IWorkoutsListPresenter {
    func getData()
}

class WorkoutsListPresenter: IWorkoutsListPresenter {
    private var model: [IWorkoutsModel]
    private var view: IWorkoutsListView
    
    init(model: [IWorkoutsModel], view: IWorkoutsListView) {
        self.model = model
        self.view = view
    }
    
    func getData() {
        model = WorkoutModel.create()
        view.setDataInCell(model)
    }
}
