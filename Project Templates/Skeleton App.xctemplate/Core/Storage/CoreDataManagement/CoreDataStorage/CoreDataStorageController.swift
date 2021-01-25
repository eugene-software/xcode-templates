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
import FirebaseCrashlytics

class FrameworkPersistentContainer: NSPersistentContainer {}

private extension DispatchQueue {
    static var coreDataConcurrent: DispatchQueue = DispatchQueue(label: UUID().uuidString, qos: .userInitiated, attributes: .concurrent)
}

class CoreDataStorageController: NSObject {
    
    //Static Properties
    //
    static var shared: CoreDataStorageInterface = {
        return CoreDataStorageController(completionClosure: nil)
    }()
    
    //Private Properties
    //
    private var persistentContainer: NSPersistentContainer!
    private var backgroundContext: NSManagedObjectContext?
    
    //Public Properties
    //
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(completionClosure: (() -> Void)?) {
        
        super.init()
        loadStore(completionClosure: completionClosure)
        setupObservers()
    }
    
    func loadStore(completionClosure: (() -> Void)?) {
        
        persistentContainer = FrameworkPersistentContainer(name: "LocalStorageDataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                Crashlytics.crashlytics().record(error: error)
                print("Failed to load Core Data stack: \(error)")
            }
            completionClosure?()
        }
        
        // Initialize background context to perform all operations in background.
        //
        backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func setupObservers() {
       
    }
}


//MARK: - DataStorageInterface

extension CoreDataStorageController: CoreDataStorageInterface {
    
    func query<Type>(type: Type.Type, predicate: NSPredicate?, context: NSManagedObjectContext?, sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?) -> [Type.ManagedType]? where Type : CoreDataCompatible {
        
        let context = context ?? backgroundContext
        
        // Fetch entity with appropriate class
        //
        let entityName = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        
        return context?.safeFetch(fetchRequest)
    }
    
    func setValues<Type: CoreDataCompatible>(type: Type.Type, values: [String: Any?], predicate: NSPredicate?) {
        
        guard !values.isEmpty else { return }
        
        let entityName = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        let result = backgroundContext?.safeFetch(fetchRequest)
        result?.forEach({ (obj) in
            
            values.forEach { (key, value) in
                obj.setValue(value, forKeyPath: key)
            }
        })
    }
    
    func count<Type: CoreDataCompatible>(type: Type.Type, predicate: NSPredicate, context: NSManagedObjectContext?) -> Int {
        
        let context = context ?? backgroundContext
        
        let entityName = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        return (try? context?.count(for: fetchRequest)) ?? 0
    }
    
    func findPersistentObjects<Type>(type: Type.Type, with predicate: NSPredicate?, context: NSManagedObjectContext?) -> [Type.ManagedType]? where Type : CoreDataCompatible {
        
        let context = context ?? backgroundContext
        
        // Fetch entity with appropriate class
        //
        let entityName = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = predicate
        
        return context?.safeFetch(fetchRequest)
    }
    
    func deletePersistentObjects<Type>(type: Type.Type, with predicate: NSPredicate?) where Type : CoreDataCompatible {
        
        let entityName = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        let result = backgroundContext?.safeFetch(fetchRequest)
        result?.forEach { (obj) in
            backgroundContext?.delete(obj)
        }
    }
    
    func remove<Type>(entity: Type.Type) where Type : CoreDataCompatible {
        
        let entityName = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: entityName)
        let result = backgroundContext?.safeFetch(fetchRequest)
        result?.forEach { (obj) in
            backgroundContext?.delete(obj)
        }
    }
    
    func fetchOrCreate<Type>(object: Type?, id: Int64, idKey: String) -> Type.ManagedType? where Type : CoreDataCompatible {
        
        guard let object = object as? Type.ManagedType.ExportType else { return nil }
        
        let entityName = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(key: idKey, id: id)
        
        let result = backgroundContext?.safeFetch(fetchRequest)
        if let first = result?.first {
            first.configure(with: object, in: self)
            return first
        } else {
            let objectMO = addPersistentObject(type: Type.ManagedType.self, with: nil)
            objectMO?.configure(with: object, in: self)
            return objectMO
        }
    }
    
    func remove<Type>(object: Type?, id: Int64, idKey: String) where Type : CoreDataCompatible {
        
        let name = String(describing: Type.ManagedType.self)
        let fetchRequest = NSFetchRequest<Type.ManagedType>(entityName: name)
        fetchRequest.predicate = NSPredicate(key: idKey, id: id)
        
        let results = backgroundContext?.safeFetch(fetchRequest)

        if let result = results?.first {
            delete(persistent: result)
        }
    }
    
    func save(saveBlock: @escaping () -> Void, completionBlock: @escaping () -> Void) {
        
        let context = backgroundContext
        context?.perform { [weak context] in
            saveBlock()
            context?.saveSelfAndParent() {
                DispatchQueue.main.async {
                    completionBlock()
                }
            }
        }
    }
    
    func deleteTables(but names: [String], completion: (() -> Void)?) {
        
        
        let allEntitiyNames = persistentContainer.managedObjectModel.entities.compactMap { $0.name }
        let toBeRemoved = allEntitiyNames.filter { !names.contains($0) }
        
        DispatchQueue.coreDataConcurrent.async {[weak self] in
            
            guard let context = self?.backgroundContext else { return }
            
            do {
                for name in toBeRemoved {
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    try context.executeAndMergeChanges(using: deleteRequest)
                }
            } catch {
                Crashlytics.crashlytics().record(error: error)
            }
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
    func destroyAndReloadDatabase(completion: (() -> Void)?) {
        
        viewContext.reset()
        backgroundContext?.reset()

        do {
            let coordinator = persistentContainer.persistentStoreCoordinator
            let stores = coordinator.persistentStores
            for store in stores {
                let url = coordinator.url(for: store)
                try coordinator.destroyPersistentStore(at: url, ofType: store.type, options: nil)
                try FileManager.default.removeItem(at: url)
            }

        } catch {
            Crashlytics.crashlytics().record(error: error)
        }

        backgroundContext = nil
        
        DispatchQueue.main.async {
            self.loadStore(completionClosure: completion)
        }
    }
}


//MARK: - Private methods

private extension CoreDataStorageController {
    
    func delete<T>(persistent object: T) where T : NSManagedObject {
        backgroundContext?.delete(object)
    }
    
    func addPersistentObject<T>(type: T.Type, with predicate: NSPredicate?) -> T? where T : NSManagedObject {
        
        guard let context = backgroundContext else { return nil }
        // Create entity with appropriate class
        //
        let name = String(describing: T.self)
        let entity = NSEntityDescription.insertNewObject(forEntityName:name, into: context) as? T
        
        return entity
    }
}


//MARK: Convenience saving context
//
private extension NSManagedObjectContext {
    
    func safeFetch<T>(_ request: NSFetchRequest<T>) -> [T]? where T : NSFetchRequestResult {
        
        do {
            return try fetch(request)
        }
        catch {
            Crashlytics.crashlytics().record(error: error)
            return nil
        }
   }
    
    var hasChanges: Bool {

        let registeredObjects = self.registeredObjects.filter { return $0.hasPersistentChangedValues }
        let updatedObjects = self.updatedObjects.filter { return $0.hasPersistentChangedValues }
        return (updatedObjects.count > 0) || (registeredObjects.count > 0) || !insertedObjects.isEmpty || !deletedObjects.isEmpty
    }
    
    func saveContextInstantly() {
        
        // Nothing to save
        //
        if !self.hasChanges { return }
        
        do {
            try save()
        } catch {
            Crashlytics.crashlytics().record(error: error)
            fatalError("Error  saving context: \(error)")
        }
    }
    
    func saveSelfAndParent(completion: (() -> Void)?) {
        saveContextInstantly()
        
        if (parent != nil) {
            parent?.perform({[weak self] in
                self?.parent?.saveSelfAndParent(completion: completion)
            })
        } else {
            completion?()
        }
    }
}


extension NSManagedObjectContext {
    
    /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
    ///
    /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
    /// - Throws: An error if anything went wrong executing the batch deletion.
    public func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
        
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
    }
}
