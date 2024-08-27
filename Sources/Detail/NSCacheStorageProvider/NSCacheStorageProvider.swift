//  Created by Alessandro Comparini on 27/08/24.
//

import Foundation
import DataStorageInterfaces

public class NSCacheStorageProvider: DataStorageProviderStrategy {
    public static let shared = NSCacheStorageProvider()
    
    private let cache = NSCache<NSString, AnyObject>()
    
    private override init() {}
    
    
//  MARK: - CREATE
    
    public override func create<T>(_ key: String, _ object: T) async throws -> T? {
        cache.setObject(object as AnyObject, forKey: NSString(string: key))
        return object
    }


//  MARK: - FIND BY
    
    public override func findBy<T>(_ key: String) async throws -> T? {
        let result = cache.object(forKey: NSString(string: key))
        return result as? T
    }

    
//  MARK: - DELETE
    
    public override func delete<T>(_ key: T) async throws {
        guard let key = key as? String else {throw DataStorageError.createError("Parameter key must be String")}
        cache.removeObject(forKey: NSString(string: key))
    }

    
}
