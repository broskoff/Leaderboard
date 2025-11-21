//
//  UserResult+CoreDataProperties.swift
//  LeaderboardHusky
//
//  Created by Tanya G. on 21.11.2025.
//
//

import Foundation
import CoreData


extension UserResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserResult> {
        return NSFetchRequest<UserResult>(entityName: "UserResult")
    }

    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var resultCount: Int16
    @NSManaged public var resultTime: Int32
    @NSManaged public var workout: Workout?

}

extension UserResult : Identifiable {

}
