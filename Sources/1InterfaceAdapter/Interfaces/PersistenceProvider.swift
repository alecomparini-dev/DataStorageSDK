//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

public protocol PersistenceProvider {
    associatedtype T
    func insert(_ object: T) async throws -> T?
    func delete(_ object: T) async throws
    func update(_ object: T) async throws -> T
    func fetch() async throws -> T?
    func fetch(limit: Int) async throws -> T?
    func fetchCount() async throws -> Int
    func fetchById(_ id: String) async throws -> T?
    func findByColumn<D>(column: String, value: D) async throws -> T?
}
