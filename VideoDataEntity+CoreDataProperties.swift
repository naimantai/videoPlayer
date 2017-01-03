//
//  VideoDataEntity+CoreDataProperties.swift
//  VideoPlayer
//
//  Created by Neven on 04/12/2016.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation
import CoreData


extension VideoDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoDataEntity> {
        return NSFetchRequest<VideoDataEntity>(entityName: "VideoDataEntity");
    }

    @NSManaged public var id: String?
    @NSManaged public var catagory: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var url: String?
    @NSManaged public var thumbnail: NSData?
    @NSManaged public var cover: NSData?

}
