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

protocol DatabaseWriterProtocol {
    
    associatedtype WriteType: Codable
    
    /// Efficiently reloads entities by reloading passed ones and removing others
    ///
    /// - Parameters:
    ///   - objectsToImport: Objects to be imported to database
    /// - Returns: An empty promise when the work is finished
    ///
    
    @discardableResult
    static func reloadEntities(_ objectsToImport: [WriteType], predicate: NSPredicate?, valuesToBeReloaded: [String: Any?]?) -> Promise<Void>
    
    /// Efficiently removes all objects by entity name from the database.
    ///
    /// - Parameters:
    ///   - entity: Object type to be deleted from database
    /// - Returns: An empty promise when the work is finished
    ///
    @discardableResult
    static func deleteEntities(_ entity: WriteType.Type) -> Promise<Void>
    
    /// Efficiently removes Updatable object from the database.
    ///
    /// - Parameters:
    ///   - objectToDelete: Object to be deleted from database
    ///   - id: id for searching existing object and delete it
    ///   - idKey: Id key for search
    ///   - writer: DatabaseWriter object for operations
    /// - Returns: An empty promise when the work is finished
    ///
    @discardableResult
    static func deleteRemote(_ objectToDelete: WriteType?, with id: Int64, idKey: String) -> Promise<Void>
    
    /// Efficiently saves Updatable object to the database.
    ///
    /// - Parameters:
    ///   - objectToImport: Object to be imported to database
    ///   - id: id for searching existing object and update it if found
    ///   - idKey: Id key for search
    ///   - writer: DatabaseWriter object for operations
    /// - Returns: An empty promise when the work is finished
    ///
    @discardableResult
    static func importRemote(_ objectToImport: WriteType?, with id: Int64, idKey: String) -> Promise<Void>
    /// Efficiently saves Updatable object list to the database.
    ///
    /// - Parameters:
    ///   - objectsToImport: Objects to be imported to database
    ///   - writer: DatabaseWriter object for operations
    /// - Returns: An empty promise when the work is finished
    ///
    @discardableResult
    static func importRemoteList(_ objectsToImport: [WriteType]) -> Promise<Void>
}

extension DatabaseWriterProtocol {
    
    @discardableResult
    static func importRemote(_ objectToImport: WriteType?, with id: Int64, idKey: String = "id") -> Promise<Void> {
        return importRemote(objectToImport, with: id, idKey: idKey)
    }
    
    @discardableResult
    static func deleteRemote(_ objectToDelete: WriteType?, with id: Int64, idKey: String = "id") -> Promise<Void> {
        return deleteRemote(objectToDelete, with: id, idKey: idKey)
    }
}


class AppDatabaseImporter<ImportedType: Codable> {}

extension AppDatabaseImporter: DatabaseWriterProtocol where ImportedType: CoreDataCompatible {
    
    typealias Writer = CoreDataWriter
    typealias WriteType = ImportedType
    
    static func reloadEntities(_ objectsToImport: [WriteType], predicate: NSPredicate? = nil, valuesToBeReloaded: [String: Any?]? = nil) -> Promise<Void> {
        return Writer<WriteType>.reloadEntities(objectsToImport, predicate: predicate, valuesToBeReloaded: valuesToBeReloaded)
    }
    
    @discardableResult
    static func deleteEntities(_ entity: WriteType.Type) -> Promise<Void> {
        return Writer<WriteType>.deleteEntities(entity)
    }
    
    @discardableResult
    static func deleteRemote(_ objectToDelete: WriteType?, with id: Int64, idKey: String) -> Promise<Void> {
        return Writer<WriteType>.deleteRemote(objectToDelete, with: id)
    }
    
    @discardableResult
    static func importRemote(_ objectToImport: WriteType?, with id: Int64, idKey: String) -> Promise<Void> {
        return Writer<WriteType>.importRemote(objectToImport, with: id, idKey: idKey)
    }
    
    @discardableResult
    static func importRemoteList(_ objectsToImport: [WriteType]) -> Promise<Void> {
        return Writer<WriteType>.importRemoteList(objectsToImport)
    }
}
