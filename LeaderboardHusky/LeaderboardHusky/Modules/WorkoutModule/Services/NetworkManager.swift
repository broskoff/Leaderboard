import Foundation

enum ServiceError: Error {
    case invalidURL
    case noData
    case networkError(Error)
    case parsingError(Error)
    case badStatusCode(Int)
}

enum Endpoint {
    case workouts
    case workout(id: Int)
    
    var url: String {
        switch self {
        case .workouts:
            return "https://69154abb84e8bd126af965b5.mockapi.io/api/v1/workouts"
        case .workout(let id):
            return  "https://69154abb84e8bd126af965b5.mockapi.io/api/v1/workouts?id=\(id)"
        }
    }
}

protocol INetworkManager: AnyObject {
    func loadData<T: Decodable>(from endpoint: Endpoint,
                                          for type: T.Type,
                                          completion: @escaping (Result<T, ServiceError>) -> Void)
}

final class NetworkManager: INetworkManager {
    func loadData<T: Decodable>(from endpoint: Endpoint,
                                          for type: T.Type,
                                          completion: @escaping (Result<T, ServiceError>) -> Void) {
        
        guard let url = URL(string: endpoint.url) else {
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
                case StatusText.codeStatus200..<StatusText.codeStatus300:
                    print(StatusText.success)
                default:
                    print(StatusText.badStatusCode)
                    completion(.failure(.badStatusCode(status)))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.parsingError(error)))
            }
        }
        task.resume()
    }
}
