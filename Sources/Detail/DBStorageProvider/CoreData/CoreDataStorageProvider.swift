//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation
import CoreData

import DataStorageInterfaces

public class CoreDataStorageProvider: DataStorageProviderStrategy {
    
    private let context:  NSManagedObjectContext
    
    public init(context:  NSManagedObjectContext ) {
        self.context = context
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
            } catch {
                throw(DataStorageError.createError( "Error: \(error.localizedDescription)" ))
            }
        }
        
        return object as? T
    }
    
//    
//    public func insert<T>(_ object: T) async throws -> T? {
//        
//        let context = container.viewContext
//        
//        guard let object = object as? NSManagedObject else {
//            debugPrint("Error: Object must be NSManagedObject")
//            return nil
//        }
//        context.insert(object)
//        
//        if context.hasChanges {
//            do{
//                try context.save()
//            }catch{
//                debugPrint("Error: \(error.localizedDescription)")
//                return nil
//            }
//        }
//        
//        return object as? T
//    }
    
    
}
