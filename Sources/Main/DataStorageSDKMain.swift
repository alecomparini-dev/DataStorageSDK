//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import DataStorageDetail

public class DataStorageMain<T> {
    
    private var dataProvider: DataStorageProviderStrategy<T>
    
    public init(dataProvider: DataStorageProviderStrategy<T>) {
        self.dataProvider = dataProvider
    }
    
    public func insert(_ object: T) async throws -> T? {
        return try await dataProvider.insert(object)
    }
    
    public func delete(_ object: T) async throws {
        return try await dataProvider.delete(object)
    }
    
    public func update(_ object: T) async throws -> T {
        return try await dataProvider.update(object)
    }

    public func fetch() async throws -> T? {
        return try await dataProvider.fetch()
    }
    
    public func fetch(limit: Int) async throws -> T? {
        return try await dataProvider.fetch(limit: limit)
    }
    
    public func fetchCount() async throws -> Int {
        return try await dataProvider.fetchCount()
    }
    
    public func fetchById(_ id: String) async throws -> T? {
        return try await dataProvider.fetchById(id)
    }

    public func findByColumn<D>(column: String, value: D) async throws -> T? {
        return try await dataProvider.findByColumn(column: column, value: value)
    }

    
//  MARK: - JSON AREA
    public func insert(_ key: String, _ object: T) async throws -> T? {
        return try await dataProvider.insert(key, object)
    }
    
    public func update(_ key: String, _ object: T) async throws -> T {
        return try await dataProvider.update(key, object)
    }

    public func fetchCount(_ key: String) async throws -> Int {
        return try await dataProvider.fetchCount(key)
    }

}
