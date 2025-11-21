protocol IWorkoutsListPresenter {
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
                    print("Неверный URL")
                case .noData:
                    print("Нет данных")
                case .networkError(let error):
                    print("Ошибка сети: \(error.localizedDescription)")
                case .parsingError(let error):
                    print("Ошибка парсинга: \(error)")
                case .badStatusCode(let status):
                    print("Ошибка, статус код: \(status)")
                }
            }
        }
    }
}
