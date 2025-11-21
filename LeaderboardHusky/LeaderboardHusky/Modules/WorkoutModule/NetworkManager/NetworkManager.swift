import Foundation

let networkServiceBaseURL = "https://69154abb84e8bd126af965b5.mockapi.io/api/v1/"

protocol INetworkManager {
    func getWorkouts(endPoint: String, completion: @escaping (Result<Workout, ServiceError>) -> Void)
}

enum ServiceError: Error {
    case invalidURL
    case noData
    case networkError(Error)
    case parsingError(Error)
    case badStatusCode(Int)
}

class NetworkManager: INetworkManager {
    
    func getWorkouts(endPoint: String, completion: @escaping (Result<Workout, ServiceError>) -> Void) {
        
        guard let url = URL(string: "\(networkServiceBaseURL)\(endPoint)") else {
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
                let workouts = try JSONDecoder().decode(WorkoutsListModel.self, from: data)
            } catch {
                completion(.failure(.parsingError(error)))
            }
        }
        
        task.resume()
    }
}
