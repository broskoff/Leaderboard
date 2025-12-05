import Foundation

protocol IWorkoutPresenter: AnyObject {
    func getData()
}

final class WorkoutSelectedPresenter: IWorkoutPresenter {
    private var view: IWorkoutSelectedView
    private var networkManager: INetworkManager
    private var selectedWorkoutId: Int
    
    init(view: IWorkoutSelectedView, selectedWorkoutID: Int, networkManager: INetworkManager) {
        self.view = view
        self.selectedWorkoutId = selectedWorkoutID
        self.networkManager = networkManager
    }
    
    func getData() {
        view.render(state: .loading)
        
        networkManager.loadData(from: .baseURLForWorkout,
                                for: [WorkoutSelectedModel].self,
                                id: selectedWorkoutId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let workout):
                    self.view.setDataForImageAndDescription(workouts: workout, id: selectedWorkoutId)
                DispatchQueue.main.async {
                    self.view.render(state: .loaded)
                }
            case .failure(let error):
                view.render(state: .error(error))
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
