//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import RealmSwift
import CoreData

import DataStorageInterfaces


public class DataStorageProviderStrategy: PersistenceProvider, PersistenceNOSQLProvider {

    public init() {}

//  MARK: - CREATE
    public func create<T>(_ object: T) async throws -> T? {
        fatalError("The method create, needs to be implemented by the subclasses ")
    }

    
//  MARK: - FETCH
    public func fetch<T>() async throws -> [T] {
        fatalError("The method fetch, needs to be implemented by the subclasses ")
    }
    
    public func fetch<T>(limit: Int) async throws -> [T] {
        fatalError("The method fetch, needs to be implemented by the subclasses ")
    }

    public func fetchCount() async throws -> Int {
        fatalError("The method fetch, needs to be implemented by the subclasses ")
    }

    
//  MARK: - FIND BY
    
    public func findBy<T>(_ id: String) async throws -> T? {
        fatalError("The method fetchByID, needs to be implemented by the subclasses ")
    }

    public func findBy<T,D>(column: String, value: D) async throws -> [T] {
        fatalError("The method findByColumn, needs to be implemented by the subclasses ")
    }

    
//  MARK: - DELETE
    public func delete<T>(_ object: T) async throws {
        fatalError("The method delete, needs to be implemented by the subclasses ")
    }
    
    
    
//  MARK: - PersistenceNOSQLProvider
    
    //  MARK: - CREATE
    public func create<T>(_ key: String, _ value: T) async throws -> T? {
        fatalError("The method create, needs to be implemented by the subclasses ")
    }
    
    public func create<T>(_ path: String, _ key: String, _ value: T) async throws -> T? {
        fatalError("The method create, needs to be implemented by the subclasses ")
    }
    

    //  MARK: - FETCH
    public func fetch<T>(_ path: String) async throws -> [T] {
        fatalError("The method fetch, needs to be implemented by the subclasses ")
    }
    
    public func fetch<T>(_ path: String, limit: Int) async throws -> [T] {
        fatalError("The method fetch with limit, needs to be implemented by the subclasses ")
    }
    
    
    //  MARK: - COUNT
    public func fetchCount(_ key: String) async throws -> Int {
        fatalError("The method fetchCount, needs to be implemented by the subclasses ")
    }
    
    
    //  MARK: - FIND
    public func findBy<T>(_ path: String, _ key: String) async throws -> T? {
        fatalError("The method findByID, needs to be implemented by the subclasses ")
    }

    
    //  MARK: - UPDATE
    public func update<T>(_ path: String, _ key: String, _ value: T) async throws {
        fatalError("The method update, needs to be implemented by the subclasses ")
    }
    
    

    
    //    public func update(_ object: T) async throws -> T {
    //        fatalError("The method update, needs to be implemented by the subclasses ")
    //    }
    //
    //
    //
    ////  MARK: - PersistenceJSONProvider

    //
    //    public func update(_ key: String, _ value: T) async throws -> T {
    //        fatalError("The method update, needs to be implemented by the subclasses ")
    //    }
    //
        
    //}

    

}






