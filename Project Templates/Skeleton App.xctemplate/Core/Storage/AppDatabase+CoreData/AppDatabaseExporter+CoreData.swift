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
import PromiseKit

class CoreDataReader<ExportedType: Codable> { }

extension CoreDataReader: DatabaseReaderProtocol where ExportedType: CoreDataCompatible {
    
    typealias ReadType = ExportedType
    
    static func exportRemoteSingle(predicate: NSPredicate?, sort: [NSSortDescriptor]?) -> ReadType? {
        
        let controller = CoreDataStorageController.shared
        let objects = controller.query(type: ReadType.ManagedType.self,
                                       predicate: predicate,
                                       sortDescriptors: sort,
                                       fetchLimit: 1)
        
        return objects?.first?.getObject() as? ReadType
    }
    
    static func exportRemote(_ type: ReadType.Type, predicate: NSPredicate?, sort: [NSSortDescriptor]?) -> Promise<ReadType?> {
        
        let controller = CoreDataStorageController.shared
        
        return Promise { seal in
            
            controller.asyncQuery(type: ReadType.ManagedType.self,
                                  predicate: predicate,
                                  sortDescriptors: sort,
                                  fetchLimit: 1)
            { result in
                
                let object = result?.first?.getObject() as? ReadType
                DispatchQueue.main.async {
                    seal.fulfill(object)
                }
            }
        }
    }
    
    static func exportRemoteList(_ type: ReadType.Type, predicate: NSPredicate?, sort: [NSSortDescriptor]?) -> Promise<[ReadType]?> {
        
        let controller = CoreDataStorageController.shared
        
        return Promise { seal in
            
            controller.asyncQuery(type: ReadType.ManagedType.self,
                                  predicate: predicate,
                                  sortDescriptors: nil,
                                  fetchLimit: nil)
            { result in
                
                let mapped = result?.compactMap { obj in
                    return obj.getObject() as? ReadType
                }
                DispatchQueue.main.async {
                    seal.fulfill(mapped)
                }
            }
        }
    }
    
    static func fetchedResultsProvider(_ type: ReadType.Type,
                                       mainPredicate: NSPredicate,
                                       optionalPredicates: [NSPredicate]?,
                                       sorting sortDescriptors: [NSSortDescriptor],
                                       sectionName: String?,
                                       fetchLimit: Int?) -> FetchedResultsProviderInterface
    {
        
        let controller = CoreDataStorageController.shared
        
        return controller.fetchedResultsProvider(type,
                                                 mainPredicate: mainPredicate,
                                                 optionalPredicates: optionalPredicates,
                                                 sorting: sortDescriptors,
                                                 sectionName: sectionName,
                                                 fetchLimit: fetchLimit)
    }
    
    static func compute(_ type: ReadType.Type, operation: DatabaseReaderComputationOperation, keyPath: String, predicate: NSPredicate) -> Int? {
        
        let controller = CoreDataStorageController.shared
        
        return controller.compute(ReadType.ManagedType.self, operation: operation.rawValue, keyPath: keyPath, predicate: predicate)
    }
}