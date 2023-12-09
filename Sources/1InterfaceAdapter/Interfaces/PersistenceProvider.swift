//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation
import RealmSwift
import CoreData




public protocol PersistenceProvider: DefaultPersistenceProvider, CoreDataPersistenceProvider, RealmPersistenceProvider {
//    func insert(_ object: C) async throws -> C?
    
//    func delete(_ object: T) async throws
//    func update(_ object: T) async throws -> T
//    func fetch() async throws -> T?
//    func fetch(limit: Int) async throws -> T?
//    func fetchCount() async throws -> Int
//    func fetchById(_ id: String) async throws -> T?
//    func findByColumn<D>(column: String, value: D) async throws -> T?
}

public protocol DefaultProtocol: Identifiable {}
public protocol DefaultPersistenceProvider {
    func insert<T: DefaultProtocol>(_ object: T) async throws -> T?
}

public protocol CoreDataProtocol: NSManagedObject, Identifiable {}
public protocol CoreDataPersistenceProvider {
    func insert<T: CoreDataProtocol>(_ object: T) async throws -> T?
}

public protocol RealmProtocol: Object, Identifiable {}
public protocol RealmPersistenceProvider {
    func insert<T: RealmProtocol>(_ object: T) async throws -> T?
}
