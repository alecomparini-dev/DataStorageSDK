//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation
import CoreData
import DataStorageInterfaces

public class CoreDataStorageProvider: DataStorageProviderStrategy {
    
    private let context:  NSManagedObjectContext
    
    public init(context:  NSManagedObjectContext ) {
        self.context = context
        super.init()
    }
    
    
//  MARK: - INSERT
    public override func create<T>(_ object: T) async throws -> T? {
        guard let object = object as? NSManagedObject else {
            throw(DataStorageError.objectMustBeNSManagedObject)
        }
        
        context.insert(object)
        
        let ret: [T] = try await findBy(column: "name", value: "Marcos")
        print(ret)

        
        if context.hasChanges {
            try context.save()
        }
        
        return object as? T
    }
    
    
//  MARK: - FETCH
    
    public override func fetch<T>() async throws -> [T] {
        guard let object = T.self as? NSManagedObject.Type else {
            throw DataStorageError.objectMustBeNSManagedObject
        }
        
        let request = object.fetchRequest()
        
        return try context.fetch(request) as? [T] ?? []
    }
    
    
//  MARK: - FIND BY COLUMN , VALUE
    
    public override func findBy<T,V>(column: String, value: V) async throws -> [T] {
        guard let object = T.self as? NSManagedObject.Type else {
            throw DataStorageError.objectMustBeNSManagedObject
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: object))
        
        fetchRequest.predicate = NSPredicate(format: "%K == %@", column, value as! CVarArg)
        
        return try context.fetch(fetchRequest) as! [T]
    }

    
//  MARK: - DELETE
    
    public override func delete<T>(_ object: T) async throws {
        guard let object = object as? NSManagedObject else {
            throw(DataStorageError.objectMustBeNSManagedObject)
        }
        
        context.delete(object)
        
        guard context.hasChanges else { return }
        
        do {
            
            try await context.perform {
                try self.context.save()
            }
            
        } catch let error {
            context.rollback()
            throw error
        }
    }
    
    
//  MARK: - UPDATE
    
    public override func update<T>(_ object: T) async throws {
        guard let object = object as? NSManagedObject else {
            throw DataStorageError.objectMustBeNSManagedObject
        }
        
        
        guard context.hasChanges else { return }
        
        do {
            
            try await context.perform {
                try self.context.save()
            }
            
        } catch let error {
            context.rollback()
            throw error
        }

    }
}
