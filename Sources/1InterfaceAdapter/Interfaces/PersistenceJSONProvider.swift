//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

public protocol PersistenceJSONProvider {
    func insert<T>(_ key: String, _ value: T) async throws -> T?
    func update<T>(_ key: String, _ value: T) async throws -> T
}

