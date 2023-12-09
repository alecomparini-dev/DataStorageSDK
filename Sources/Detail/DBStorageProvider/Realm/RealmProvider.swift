//  Created by Alessandro Comparini on 08/12/23.
//

import Foundation
import RealmSwift
import DataStorageInterfaces

public class RealmProvider<T: Object>: PersistenceProvider {
    
    private var realm: Realm
    
    public init(realm: Realm? = nil) throws {
        if let realm {
            self.realm = realm
        }
        self.realm = try Realm()
    }
    
    
//  MARK: - GET AREA
    public func getFileRealm() -> String {
        if let fileRealm = Realm.Configuration.defaultConfiguration.fileURL {
            return String(describing: fileRealm)
        }
        return ""
    }
    
    
//  MARK: - INSERT

    public func insert(_ object: T) async throws -> T? {
        try self.realm.write {
            self.realm.add(object)
        }
        return object
    }
    
    
}
