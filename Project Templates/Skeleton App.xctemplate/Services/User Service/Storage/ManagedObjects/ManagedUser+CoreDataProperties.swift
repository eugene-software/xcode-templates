//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom SKELETON Xcode template.
//
import Foundation
import CoreData


extension ManagedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedUser> {
        return NSFetchRequest<ManagedUser>(entityName: "ManagedUser")
    }

    @NSManaged public var id: Int64
}
