import Foundation

protocol INetworkManagerWorkoutsList {
    func getWorkouts(completion: @escaping (Result<[IWorkoutsListModel], ServiceError>) -> Void)
}

protocol INetworkManagerWorkoutSelected {
    func getWorkoutSelected(id: Int, completion: @escaping (Result<[IWorkoutSelectedModel], ServiceError>) -> Void)
}

enum ServiceError: Error {
    case invalidURL
    case noData
    case networkError(Error)
    case parsingError(Error)
    case badStatusCode(Int)
}

final class NetworkManager: INetworkManagerWorkoutsList, INetworkManagerWorkoutSelected {
    
    private let networkServiceBaseURL = "https://69154abb84e8bd126af965b5.mockapi.io/api/v1/workouts"
    
    func getWorkouts(completion: @escaping (Result<[IWorkoutsListModel], ServiceError>) -> Void) {
        
        guard let url = URL(string: networkServiceBaseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                
                switch status {
                case 200..<300:
                    print("Успех")
                default:
                    print("Ошибка сервера")
                    completion(.failure(.badStatusCode(status)))
                }
            }
            
           guard let data = data else {
               completion(.failure(.noData))
               return
            }
            
            do {
                let workouts = try JSONDecoder().decode([WorkoutsListModel].self, from: data)
                completion(.success(workouts))
            } catch {
                completion(.failure(.parsingError(error)))
            }
        }
        
        task.resume()
    }
    
    func getWorkoutSelected(id: Int,
                            completion: @escaping (Result<[IWorkoutSelectedModel], ServiceError>) -> Void) {
        guard let url = URL(string: "\(networkServiceBaseURL)?id=\(id)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                
                switch status {
                case 200..<300:
                    print("Успех")
                default:
                    print("Ошибка сервера")
                    completion(.failure(.badStatusCode(status)))
                }
            }
            
           guard let data = data else {
               completion(.failure(.noData))
               return
            }
            
            do {
                let workoutSelected = try JSONDecoder().decode([WorkoutSelectedModel].self, from: data)
                completion(.success(workoutSelected))
            } catch {
                completion(.failure(.parsingError(error)))
            }
        }
        task.resume()
    }
}
