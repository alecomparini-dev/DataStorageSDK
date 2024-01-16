//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation
import DataStorageInterfaces
import FirebaseFirestore

public class FirebaseDataStorageProvider: DataStorageProviderStrategyNOSQL {
    
    private var _db: Firestore!
    
    public override init() {
        super.init()
        configure()
    }
    
    public init(db: Firestore) {
        self._db = db
        super.init()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public var db: Firestore {_db}
    
    
//  MARK: - INSERT

    public override func create<T>(_ collection: String, _ object: T) async throws -> T? {
        guard var data = object as? [String : Any] else { return object }
        
        let document: DocumentReference = try await db.collection(collection)
            .addDocument(data: data)

        data.updateValue(document.documentID, forKey: "documentID")
        
        return data as? T
    }

    public override func create<T>(_ collection: String, _ documentID: String, _ object: T) async throws -> T? {
        guard let data = object as? [String : Any] else { return object }
        
        try await db.collection(collection)
            .document(documentID)
            .setData(data)
        
        return object
    }
    
    
//  MARK: - FETCH
    
    public override func fetch<T>(_ collection: String) async throws -> [T] {
        
        let querySnapshot: QuerySnapshot = try await db.collection(collection).getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? [T] ?? []
    }
    
    
    public override func fetch<T>(_ collection: String, limit: Int) async throws -> [T] {
        let querySnapshot: QuerySnapshot = try await db.collection(collection).limit(to: limit).getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? [T] ?? []
    }

    
    
//  MARK: - FETCH COUNT
    
    public override func fetchCount(_ collection: String) async throws -> Int {
        return try await db.collection(collection).getDocuments().count
    }

    
//  MARK: - FIND BY
    
    public override func findByID<T>(_ collection: String, _ documentID: String) async throws -> T? {
        let querySnapshot: DocumentSnapshot = try await db.collection(collection)
            .document(documentID)
            .getDocument()
        
        return querySnapshot.data() as? T
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        _db = Firestore.firestore()
    }
}
