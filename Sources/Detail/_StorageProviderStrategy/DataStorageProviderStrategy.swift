//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import RealmSwift
import CoreData

import DataStorageInterfaces

public class DataStorageProviderStrategy: PersistenceProvider {
    
    public init() {}
    
    public func insert<T>(_ object: T) async throws -> T? {
        fatalError("The method insert, needs to be implemented by the subclasses ")
    }
    
}



//    public func insert(_ object: C) async throws -> C? {
//        fatalError("The method insert, needs to be implemented by the subclasses ")
//    }
    
//    public func insert<T>(_ object: T) async throws -> T? {
//        fatalError("The method insert, needs to be implemented by the subclasses ")
//    }
    
//    public func delete(_ object: T) async throws {
//        fatalError("The method delete, needs to be implemented by the subclasses ")
//    }
//    
//    public func update(_ object: T) async throws -> T {
//        fatalError("The method update, needs to be implemented by the subclasses ")
//    }
//
//    public func fetch() async throws -> T? {
//        fatalError("The method fetch, needs to be implemented by the subclasses ")
//    }
//    
//    public func fetch(limit: Int) async throws -> T? {
//        fatalError("The method fetch, needs to be implemented by the subclasses ")
//    }
//
//    public func fetchCount() async throws -> Int {
//        fatalError("The method fetch, needs to be implemented by the subclasses ")
//    }
//
//    public func fetchById(_ id: String) async throws -> T? {
//        fatalError("The method fetchByID, needs to be implemented by the subclasses ")
//    }
//
//    public func findByColumn<DataType>(column: String, value: DataType) async throws -> T? {
//        fatalError("The method findByColumn, needs to be implemented by the subclasses ")
//    }
//    
//    
////  MARK: - PersistenceJSONProvider
//    public func insert(_ key: String, _ value: T) async throws -> T? {
//        fatalError("The method insert, needs to be implemented by the subclasses ")
//    }
//    
//    public func update(_ key: String, _ value: T) async throws -> T {
//        fatalError("The method update, needs to be implemented by the subclasses ")
//    }
//    
//    public func fetchCount(_ document: String) async throws -> Int {
//        fatalError("The method update, needs to be implemented by the subclasses ")
//    }
    
//}
