import Foundation

struct WorkoutModel {
    let id: Int
    let date: String
    let image: String
    let description: String
    
    static func create() -> [WorkoutModel] {
        var workouts = [WorkoutModel]()
        var date: Date = .now
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short

        for i in 1...10 {
            date += 1
            let dateString = formatter.string(from: date)
            let workout = WorkoutModel(id: i, date: dateString, image: "\(i)", description: "Потная треня")
            workouts.append(workout)
        }
        
        return workouts
    }
}

