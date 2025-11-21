import Foundation
import CoreData

extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var id: Int64
    @NSManaged public var typeResult: String?
    @NSManaged public var results: NSSet?
}

extension Workout {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: UserResult)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: UserResult)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)
}

extension Workout : Identifiable {

}
