import Foundation

protocol IWorkoutsListModel {
    var id: Int { get set }
    var date: String { get set }
    var image: String { get set }
    
    static func create() -> [WorkoutsListModel]
}

struct WorkoutsListModel: Decodable, IWorkoutsListModel {
    var id: Int
    var date: String
    var image: String
     
    static func create() -> [WorkoutsListModel] {
        var workouts = [WorkoutsListModel]()
        var date: Date = .now
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short

        for i in 1...10 {
            date += 86400 //текущая дата + 86400 сек (это 1 день)
            let dateString = formatter.string(from: date)
            let workout = WorkoutsListModel(id: i,
                                       date: dateString,
                                       image: "\(i)") 
            workouts.append(workout)
        }
        
        return workouts
    }
}

