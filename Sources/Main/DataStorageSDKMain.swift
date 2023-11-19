//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import DataStorageDetail

public class DataStorageMain {
    
    private var dataProvider: DataStorageProviderStrategy
    
    public init(dataProvider: DataStorageProviderStrategy) {
        self.dataProvider = dataProvider
    }
    
    public func insert<T>(_ object: T) async throws -> T? {
        return try await dataProvider.insert(object)
    }
    
    public func delete<T>(_ object: T) async throws {
        return try await dataProvider.delete(object)
    }
    
    public func update<T>(_ object: T) async throws -> T {
        return try await dataProvider.update(object)
    }

    public func fetch<T>() async throws -> T? {
        return try await dataProvider.fetch()
    }
    
    public func fetch<T>(limit: Int) async throws -> T? {
        return try await dataProvider.fetch(limit: limit)
    }
    
    public func fetchCount() async throws -> Int {
        return try await dataProvider.fetchCount()
    }
    
    public func fetchById<T>(_ id: String) async throws -> T? {
        return try await dataProvider.fetchById(id)
    }

    public func findByColumn<T, DataType>(column: String, value: DataType) async throws -> T? {
        return try await dataProvider.findByColumn(column: column, value: value)
    }
    
}
