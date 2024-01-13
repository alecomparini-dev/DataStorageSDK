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
        
        if context.hasChanges {
            do{
                try context.save()
            } catch let error {
                throw(DataStorageError.createError( "Error: \(error.localizedDescription)" ))
            }
        }
        
        return object as? T
    }
    
    
//  MARK: - FETCH
    
    public override func fetch<T>() async throws -> T? {
        var object: NSManagedObject.Type?
        
        if let obj = T.self as? NSManagedObject.Type {
            object = obj
        }
        
        if let obj = [T].self.Element as? NSManagedObject.Type {
            object = obj
        }
            
        guard let object else { throw DataStorageError.objectMustBeNSManagedObject }
        
        let request = object.fetchRequest()
 
        guard let result = try context.fetch(request) as? T else { return nil}
        
        return result
    }
    
}
