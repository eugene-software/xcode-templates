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
import PromiseKit
import CoreData

class CoreDataWriter<ImportedType: Codable> {}

extension CoreDataWriter: DatabaseWriterProtocol where ImportedType: CoreDataCompatible {
    
    typealias WriteType = ImportedType
    
    static func deleteEntities(_ entity: WriteType.Type, predicate: NSPredicate?) -> Promise<Void> {
        
        return Promise<Void> { seal in
            
            CoreDataStorageController.shared.delete(WriteType.ManagedType.self, with: predicate) {
                seal.fulfill(Void())
            }
        }
    }
    
    static func importRemoteList(_ objectsToImport: [WriteType]) -> Promise<Void> {
        
        return Promise<Void> { seal in
            
            CoreDataStorageController.shared.insertList(objects: objectsToImport) {
                seal.fulfill(Void())
            }
        }
    }
}
