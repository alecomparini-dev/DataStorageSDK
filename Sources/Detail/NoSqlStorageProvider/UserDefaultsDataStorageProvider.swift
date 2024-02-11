//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import DataStorageInterfaces

public class UserDefaultsDataStorageProvider: DataStorageProviderStrategy {
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public override func create<T>(_ key: String, _ value: T) async throws -> T {
        userDefaults.set(value, forKey: key)
        return value
    }
    
    public override func findBy<T>(_ forKey: String) async throws -> T?  {
        if let result = userDefaults.value(forKey: forKey) as? T {
            return result
        }
        return nil
    }
    
}
