//  Created by Alessandro Comparini on 26/09/24.
//

import Foundation
import DataStorageInterfaces
import FirebaseDatabase

public class FirebaseRealtimeDataStorageProvider: DataStorageProviderStrategy {
    
    private var _db: Database!
    
    public override init() {
        _db = Database.database()
        super.init()
    }
    
    public init(db: Database = Database.database()) {
        _db = db
        super.init()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public var db: Database { _db }
    
    
//  MARK: - INSERT

    public override func create<T>(_ pathString: String, _ value: T) async throws -> T? {
        let ref = db.reference().childByAutoId().child(pathString)
        
        let document: DatabaseReference = try await ref.setValue(value)
        
        return ["key": document.key] as? T
    }
    
    public override func create<T>(_ pathString: String, _ key: String, _ value: T) async throws -> T? {
        let ref = db.reference().child("\(pathString)/\(key)")
        
        try await ref.setValue(value)
        
        return value
    }

    
//  MARK: - FETCH
    
    public override func fetch<T>(_ pathString: String) async throws -> [T] {
        return try await withCheckedThrowingContinuation { continuation in
            let ref = db.reference().child("\(pathString)")
    
            ref.observeSingleEvent(of: .value, with: { snapshot in
                guard let data = snapshot.valueInExportFormat() as? [String: Any] else { return continuation.resume(returning: []) }
                continuation.resume(returning: [data] as? [T] ?? [])
            }) { error in
                continuation.resume(throwing: DataStorageError.createError( "Error: \(error.localizedDescription)" ))
            }
        }
    }
    
    public override func fetch<T>(_ pathString: String, limit: Int = 10) async throws -> [T] {
        return try await withCheckedThrowingContinuation { continuation in
            
            let ref = db.reference().child("\(pathString)")
    
            ref.queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value, with: { snapshot in
                guard let data = snapshot.valueInExportFormat() as? [String: Any] else { return continuation.resume(returning: []) }
                continuation.resume(returning: [data] as? [T] ?? [])
            }) { error in
                continuation.resume(throwing: DataStorageError.createError( "Error: \(error.localizedDescription)" ))
            }
        }
    }

    
//  MARK: - FIND BY
    
    public override func findBy<T>(_ pathString: String, _ key: String) async throws -> T? {
        return try await withCheckedThrowingContinuation { continuation in
            
            let ref = db.reference().child("\(pathString)/\(key)")
    
            ref.observeSingleEvent(of: .value, with: { snapshot in
                guard let data = snapshot.valueInExportFormat() as? [String: Any] else { return continuation.resume(returning: nil) }
                continuation.resume(returning: data as? T)
            }) { error in
                continuation.resume(throwing: DataStorageError.createError( "Error: \(error.localizedDescription)" ))
            }
        }
    }
    
    
//  MARK: - UPDATE
    public override func update<T>(_ pathString: String, _ key: String, _ value: T) async throws {
        let ref = db.reference().child("\(pathString)/\(key)")
        
        try await ref.updateChildValues(value)
    }
    
    
//  MARK: - DELETE
    public override func delete(_ pathString: String, _ key: String) async throws {
        let ref = db.reference().child("\(pathString)/\(key)")
        
        try await ref.removeValue()
    }
    
}
