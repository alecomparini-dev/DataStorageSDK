//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

public protocol PersistenceNOSQLProvider {
    func create<T>(_ key: String, _ value: T) async throws -> T?
    func fetchCount(_ key: String) async throws -> Int
//    func update(_ key: String, _ value: T) async throws -> T
}

