//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation
import Security

import RealmSwift

import DataStorageInterfaces

public class KeyChainDataStorageProvider: DataStorageProviderStrategy {
    
    private let appName: String
   
    public init(appName: String) {
        self.appName = appName
    }

    
//  MARK: - INSERT
    public override func create<T>(_ key: String, _ value: T) async throws -> T? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: appName,
            kSecAttrAccount as String: key,
            kSecValueData as String: try JSONEncoder().encode(value as? [String])
        ]
        
        try await delete(key as! T)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        //TODO: - CREATE ERROR
        guard status == errSecSuccess else {
            return nil
        }
        
        return value
    }
    
    
//  MARK: - DELETE
    public override func delete<T>(_ key: T) async throws {
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: appName,
            kSecAttrAccount as String: key
        ]
        
        let statusDelete = SecItemDelete(deleteQuery as CFDictionary)
        
        //TODO: - CREATE ERROR
        guard statusDelete == errSecSuccess else {
            return
        }
    }
    
    
////  MARK: - FETCH
//    public override func fetch() async throws -> T? {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrService as String: appName,
//            kSecReturnAttributes as String: true,
//            kSecMatchLimit as String: kSecMatchLimitAll
//        ]
//        
//        var result: AnyObject?
//        let status = SecItemCopyMatching(query as CFDictionary, &result)
//        
//        if status == errSecSuccess {
//            if let items = result as? [[String: Any]] {
//                return items.map { item in
//                    if let account = item[kSecAttrAccount as String] as? String,
//                       let valueData = item[kSecValueData as String] as? Data,
//                       let value = String(data: valueData, encoding: .utf8) {
//                        return [account : value] as! T
//                    }
//                    
//                    return [:] as! T
//                    
//                } as? T
//            }
//        }
//        
//        return nil 
//    }

    

//  MARK: - FIND BY ID
    public override func findBy<T>(_ forKey: String) async throws -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: appName,
            kSecAttrAccount as String: forKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let valueData = result as? Data else {
            return nil
        }
            
        return try? JSONDecoder().decode([String].self, from: valueData) as? T
        
    }
    
    
    
}

