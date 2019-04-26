//
//  Message+CoreDataProperties.swift
//  MessageAR
//
//  Created by Dev on 26/04/2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var id: String?
    @NSManaged public var text: String?
    @NSManaged public var createDate: String?
    @NSManaged public var author: User?
    @NSManaged public var chat: Chat?

}
