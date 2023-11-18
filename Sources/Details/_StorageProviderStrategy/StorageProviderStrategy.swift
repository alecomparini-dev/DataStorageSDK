//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import DataStorageInterfaces

public class StorageProviderStrategy: PersistenceProvider, PersistenceJSONProvider {
    
    public init() {}
    
    public func insert<T>(_ object: T) async throws -> T? {
        fatalError("The method insert, needs to be implemented by the subclasses ")
    }
    
    public func delete<T>(_ object: T) async throws {
        fatalError("The method delete, needs to be implemented by the subclasses ")
    }
    
    public func update<T>(_ object: T) async throws -> T {
        fatalError("The method update, needs to be implemented by the subclasses ")
    }

    public func fetch<T>() async throws -> [T] {
        fatalError("The method fetch, needs to be implemented by the subclasses ")
    }

    public func fetchById<T>(_ id: String) async throws -> T? {
        fatalError("The method fetchByID, needs to be implemented by the subclasses ")
    }

    public func findByColumn<T, DataType>(column: String, value: DataType) async throws -> [T] {
        fatalError("The method findByColumn, needs to be implemented by the subclasses ")
    }
    
    
//  MARK: - PersistenceJSONProvider
    public func insert<T>(_ key: String, _ value: T) async throws -> T? {
        fatalError("The method insert, needs to be implemented by the subclasses ")
    }
    
    public func update<T>(_ key: String, _ value: T) async throws -> T {
        fatalError("The method update, needs to be implemented by the subclasses ")
    }
    
}
