protocol IWorkoutPresenter: AnyObject {
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
