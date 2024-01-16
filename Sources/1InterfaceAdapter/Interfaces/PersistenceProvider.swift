//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation


public protocol PersistenceProvider{
    func create<T>(_ object: T) async throws -> T?
    
    func fetch<T>() async throws -> [T]
    func fetch<T>(limit: Int) async throws -> [T]
    func fetchCount() async throws -> Int
    
    func findBy<T>(_ id: String) async throws -> T?
    func findBy<T,V>(column: String, value: V) async throws -> [T]

    //    func delete(_ object: T) async throws
//    func update(_ object: T) async throws -> T

}


