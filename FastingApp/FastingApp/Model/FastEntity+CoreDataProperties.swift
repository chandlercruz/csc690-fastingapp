//
//  FastEntity+CoreDataProperties.swift
//  FastingApp
//
//  Created by Chandler Cruz on 12/10/20.
//
//

import UIKit
import CoreData


extension FastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FastEntity> {
        return NSFetchRequest<FastEntity>(entityName: "FastEntity")
    }

    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var timeFasted: Double

}

extension FastEntity : Identifiable {

}
