//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation
import CoreData

import DataStorageInterfaces

public class CoreDataProvider: DataStorageProviderStrategy {
    
    private let container: NSPersistentContainer
    
    public init(container: NSPersistentContainer = NSPersistentContainer(name: "Main")) {
        self.container = container
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError("Cannot Load Core Data Model")
            }
        }
    }
    
    
    
//  MARK: - INSERT
    public override func insert<T>(_ object: T) async throws -> T? {
        
        let context = container.viewContext
        
        guard let object = object as? NSManagedObject else {
            debugPrint("Error: Object must be NSManagedObject")
            return nil
        }
        
        context.insert(object)
        
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                debugPrint("Error: \(error.localizedDescription)")
                return nil
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
