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

    public override func create<T>(_ pathString: String, _ object: T) async throws -> T? {
        guard let data = object as? [String : Any] else { return object }
        
        let ref = db.reference().childByAutoId().child(pathString)
        
        let document: DatabaseReference = try await ref.setValue(data)
        
        return [document.key ?? "-": object] as? T
    }
    
    public override func create<T>(_ pathString: String, _ documentID: String, _ object: T) async throws -> T? {
        guard let data = object as? [String : Any] else { return object }
        
        let ref = db.reference().child("\(pathString)/\(documentID)")
        
        let _: DatabaseReference = try await ref.setValue(data)
        
        return object
    }

    
    
//  MARK: - FETCH
    
    public override func fetch<T>(_ pathString: String) async throws -> [T] {
        
        return try await withCheckedThrowingContinuation { continuation in
            let ref = db.reference().child("\(pathString)")
    
            ref.observeSingleEvent(of: .value, with: { snapshot in
                guard let data = snapshot.valueInExportFormat() as? [[String: Any]] else { return continuation.resume(returning: []) }
                continuation.resume(returning: data.map { $0 } as? [T] ?? [])
            }) { error in
                continuation.resume(throwing: DataStorageError.createError( "Error: \(error.localizedDescription)" ))
            }
        }
        
    }
    
    
    public override func fetch<T>(_ pathString: String, limit: Int = 10) async throws -> [T] {
        return try await withCheckedThrowingContinuation { continuation in
            
            let ref = db.reference().child("\(pathString)")
    
            ref.queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value, with: { snapshot in
                guard let data = snapshot.valueInExportFormat() as? [[String: Any]] else { return continuation.resume(returning: []) }
                continuation.resume(returning: data.map { $0 } as? [T] ?? [])
            }) { error in
                continuation.resume(throwing: DataStorageError.createError( "Error: \(error.localizedDescription)" ))
            }
        }

    }

    
    
    
//  MARK: - FIND BY
    
//    public override func findBy<T>(_ collection: String, _ documentID: String) async throws -> T? {
//        let querySnapshot: DocumentSnapshot = try await db.collection(collection)
//            .document(documentID)
//            .getDocument()
//        
//        return querySnapshot.data() as? T
//    }
    
    
//  MARK: - UPDATE
//    public override func update<T>(_ collection: String, _ documentID: String, _ value: T) async throws {
//        guard let data = value as? [String : Any] else { return }
//        
//        try await db.collection(collection)
//            .document(documentID)
//            .updateData(data)
//    }
    

}
