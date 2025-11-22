protocol IWorkoutsListPresenter: AnyObject {
    func getData()
}

final class WorkoutsListPresenter: IWorkoutsListPresenter {
    private var view: IWorkoutsListView
    private var networkManager: INetworkManagerWorkoutsList
    private var model: [IWorkoutsListModel] = []
    
    init(view: IWorkoutsListView, networkManager: INetworkManagerWorkoutsList) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getData() {
        view.setLoadingState()
        
        networkManager.getWorkouts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let workouts):
                self.model = workouts
                self.view.setDataInCell(self.model)
            case .failure(let error):
                switch error {
                case .invalidURL:
                    print(ErrorTextsPrint.invalidURL)
                case .noData:
                    print(ErrorTextsPrint.noData)
                case .networkError(let error):
                    print("\(ErrorTextsPrint.networkError) \(error.localizedDescription)")
                case .parsingError(let error):
                    print("\(ErrorTextsPrint.parsingError)  \(error)")
                case .badStatusCode(let status):
                    print("\(ErrorTextsPrint.badStatusCode) \(status)")
                }
            }
        }
    }
}
