protocol IWorkoutsListPresenter {
    func getData()
}

class WorkoutsListPresenter: IWorkoutsListPresenter {
    private var model: [IWorkoutsListModel]
    private var view: IWorkoutsListView
    
    init(model: [IWorkoutsListModel], view: IWorkoutsListView) {
        self.model = model
        self.view = view
    }
    
    func getData() {
        view.setDataInCell(model)
    }
}
