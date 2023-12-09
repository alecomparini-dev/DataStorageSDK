//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation
import CoreData

import DataStorageInterfaces

public class CoreDataProvider<T>: DataStorageProviderStrategy<T>
where T: Identifiable<UUID>, T: NSManagedObject {
    
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
    public override func insert(_ object: T) async throws -> T? {
        
        let context = container.viewContext
        
        context.insert(object)
        
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        
        return object
    }
    
    
    
}
