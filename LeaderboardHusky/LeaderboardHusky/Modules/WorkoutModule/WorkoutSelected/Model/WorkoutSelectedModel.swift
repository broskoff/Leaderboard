import Foundation

protocol IWorkoutSelectedModel {
    var id: Int { get set }
    var date: String { get set }
    var image: String { get set }
    var description: String { get set }
    var typeResult: TypeResult { get }
    
    static func create() -> [WorkoutSelectedModel]
}

enum TypeResult: String {
    case resultCount = "0"
    case resultTime = "1"
}

struct WorkoutSelectedModel: IWorkoutSelectedModel {
    var id: Int
    var date: String
    var image: String
    var description: String
    var typeResult: TypeResult
     
    static func create() -> [WorkoutSelectedModel] {
        var workouts = [WorkoutSelectedModel]()
        var date: Date = .now
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short

        for i in 1...10 {
            date += 86400 //текущая дата + 86400 сек (это 1 день)
            let dateString = formatter.string(from: date)
            let workout = WorkoutSelectedModel(id: i,
                                               date: dateString,
                                               image: "\(i)",
                                               description: Plug.arrayplugDescription[i - 1], //заглушка
                                               typeResult: .resultTime) //заглушка
            workouts.append(workout)
        }
        
        return workouts
    }
}

