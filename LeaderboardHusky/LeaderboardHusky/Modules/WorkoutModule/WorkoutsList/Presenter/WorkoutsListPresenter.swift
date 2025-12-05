import Foundation

protocol IWorkoutsListPresenter: AnyObject {
    func getData()
}

final class WorkoutsListPresenter: IWorkoutsListPresenter {
    
    private var workouts: [IWorkoutsListModel] = []
    private var view: IWorkoutsListView
    private var storageManager: IStorageManagerWorkoutsList
    private var networkManager: INetworkManager
    
    init(view: IWorkoutsListView,
         storageManager: IStorageManagerWorkoutsList,
         networkManager: INetworkManager) {
        self.view = view
        self.storageManager = storageManager
        self.networkManager = networkManager
    }
    
    func getData() {
        view.render(state: .loading)
        
        networkManager.loadData(from: .baseURL,
                                for: [WorkoutsListModel].self,
                                id: nil) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let workouts):
                DispatchQueue.main.async {
                    self.view.render(state: .loaded(workouts))
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
