//
//  User+CoreDataProperties.swift
//  MessageAR
//
//  Created by Dev on 26/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//
//

import Foundation
import CoreData


extension User {
  @NSManaged public var id: String
  @NSManaged public var name: String
  @NSManaged public var profileIconPath: String?
  @NSManaged public var messages: NSSet?
  
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

}

// MARK: Generated accessors for messages
extension User {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: Message)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: Message)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}
