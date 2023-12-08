//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import DataStorageInterfaces

public class UserDefaultsProvider<T>: DataStorageProviderStrategy<T> {
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public override func insert(_ key: String, _ value: T) async throws -> T {
        userDefaults.set(value, forKey: key)
        return value
    }
    
    public override func fetchById(_ forKey: String) async throws -> T?  {
        if let result = userDefaults.value(forKey: forKey) as? T {
            return result
        }
        return nil
    }
    
}
