//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

public protocol PersistenceNOSQLProvider {
    func create<T>(_ path: String, _ value: T) async throws -> T?
    func create<T>(_ path: String, _ key: String, _ value: T) async throws -> T?
    
    func fetch<T>(_ path: String) async throws -> [T]
    func fetch<T>(_ path: String, limit: Int) async throws -> [T]
        
    func fetchCount(_ path: String) async throws -> Int
    
    func findBy<T>(_ path: String, _ key: String) async throws -> T?
    
    func update<T>(_ path: String, _ key: String, _ value: T) async throws

    
    
}

