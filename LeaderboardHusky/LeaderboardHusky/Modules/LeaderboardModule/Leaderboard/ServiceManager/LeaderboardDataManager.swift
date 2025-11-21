import UIKit
import CoreData

protocol ILeaderboardDataManager {
    func fetchResults(for workoutId: Int, gender: String, typeResult: String) -> [UserResult]
    func addResult(name: String, result: Int, gender: String, workoutId: Int, typeResult: String)
    func deleteContext(object: UserResult)
}

final class LeaderboardDataManager: ILeaderboardDataManager {

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchResults(for workoutId: Int, gender: String, typeResult: String) -> [UserResult] {
        let request: NSFetchRequest<UserResult> = UserResult.fetchRequest()
        var predicates: [NSPredicate] = [NSPredicate(format: "workout.id == %d", workoutId)]
        
        predicates.append(NSPredicate(format: "gender == %@", gender))
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        switch typeResult {
        case TypeResult.count.rawValue:
            // Сортируем только по количеству повторов (descending)
            request.sortDescriptors = [NSSortDescriptor(key: "resultCount", ascending: false)]
        case TypeResult.time.rawValue:
            // Сортируем только по времени (ascending), меньшее время — лучше
            request.sortDescriptors = [NSSortDescriptor(key: "resultTime", ascending: true)]
        default:
            break
        }
        
        do {
            return try context.fetch(request)
        } catch {
            print("Ошибка извлечения результата: \(error)")
            return []
        }
    }
    
    func addResult(name: String, result: Int, gender: String, workoutId: Int, typeResult: String) {
        
        let new = UserResult(context: context)
        new.name = name
        new.gender = gender
        new.resultCount = Int16(result)
        new.resultTime = Int32(result)
        
        
        if let workout = fetchWorkout(with: workoutId) {
            new.workout = workout
            workout.addToResults(new)
        } else {
            let workout = Workout(context: context)
            workout.id = Int64(workoutId)
            
            workout.typeResult = typeResult
            workout.addToResults(new)
            new.workout = workout
        }
        
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения результата: \(error)")
        }
    }
    
    func deleteContext(object: UserResult)  {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения результата: \(error)")
        }
    }
    
    private func fetchWorkout(with id: Int) -> Workout? {
        let request: NSFetchRequest<Workout> = Workout.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return try? context.fetch(request).first
    }
}
