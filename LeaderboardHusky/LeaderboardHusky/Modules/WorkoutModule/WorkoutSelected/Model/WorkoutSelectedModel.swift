import Foundation

protocol IWorkoutSelectedModel {
    var id: Int { get set }
    var date: String { get set }
    var image: String { get set }
    var description: String { get set }
    var typeResult: String { get set }
}

struct WorkoutSelectedModel: Decodable, IWorkoutSelectedModel {
    var id: Int
    var date: String
    var image: String
    var description: String
    var typeResult: String
}
