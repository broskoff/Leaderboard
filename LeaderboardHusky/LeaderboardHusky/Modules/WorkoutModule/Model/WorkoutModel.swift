import Foundation

protocol IWorkoutsModel {
    var id: Int { get set }
    var date: String { get set }
    var image: String { get set }
    var description: String { get set }
    
    static func create() -> [WorkoutModel]
}

struct WorkoutModel: IWorkoutsModel {
    var id: Int
    var date: String
    var image: String
    var description: String
     
    static func create() -> [WorkoutModel] {
        var workouts = [WorkoutModel]()
        var date: Date = .now
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short

        for i in 1...10 {
            date += 86400 //текущая дата + 86400 сек (это 1 день)
            let dateString = formatter.string(from: date)
            let workout = WorkoutModel(id: i,
                                       date: dateString,
                                       image: "\(i)",
                                       description: Plug.arrayplugDescription[i - 1]) //заглушка
            workouts.append(workout)
        }
        
        return workouts
    }
}

