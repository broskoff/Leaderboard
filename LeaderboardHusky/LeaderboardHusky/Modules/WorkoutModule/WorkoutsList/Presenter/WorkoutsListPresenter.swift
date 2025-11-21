protocol IWorkoutsListPresenter {
    func getData()
}

class WorkoutsListPresenter: IWorkoutsListPresenter {
    private var view: IWorkoutsListView
    private var networkManager: INetworkManagerWorkoutsList
    private var model: [IWorkoutsListModel] = []
    
    init(view: IWorkoutsListView, networkManager: INetworkManagerWorkoutsList) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getData() {
        networkManager.getWorkouts { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let workouts):
                self.model = workouts
                view.setDataInCell(self.model)
            case .failure(let error):
                switch error {
                case .invalidURL:
                    print("Invalid URL")
                case .noData:
                    print("No data")
                case .networkError(let error):
                    print("Network error: \(error.localizedDescription)")
                case .parsingError(let error):
                    print("Parsing error: \(error)")
                case .badStatusCode(let status):
                    print("Ошибка, статус код: \(status)")
                }
            }
        }
//        view.setLoadingState()
    }
}
