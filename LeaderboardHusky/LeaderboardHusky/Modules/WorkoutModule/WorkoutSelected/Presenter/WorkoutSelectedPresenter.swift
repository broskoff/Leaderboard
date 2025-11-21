protocol IWorkoutPresenter {
    func getData()
}

final class WorkoutSelectedPresenter: IWorkoutPresenter {
    private var model: [IWorkoutSelectedModel] = []
    private var view: IWorkoutSelectedView
    private var networkManager: INetworkManagerWorkoutSelected
    private var selectedWorkoutID: Int
    
    init(view: IWorkoutSelectedView, selectedWorkoutID: Int, networkManager: INetworkManagerWorkoutSelected) {
        self.view = view
        self.selectedWorkoutID = selectedWorkoutID
        self.networkManager = networkManager
    }
    
    func getData() {
        view.setLoadingState()
        
        networkManager.getWorkoutSelected(id: selectedWorkoutID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let workouts):
                self.model = workouts
                self.view.setDataForImageAndDescription(workouts: model, id: selectedWorkoutID)
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
