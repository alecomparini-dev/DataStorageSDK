//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

public protocol PersistenceProvider {
    func insert<T>(_ object: T) async throws -> T?
    func delete<T>(_ object: T) async throws
    func update<T>(_ object: T) async throws -> T
    func fetch<T>() async throws -> T?
    func fetch<T>(limit: Int) async throws -> T?
    func fetchCount() async throws -> Int
    func fetchById<T>(_ id: String) async throws -> T?
    func findByColumn<T, DataType>(column: String, value: DataType) async throws -> T?
}
