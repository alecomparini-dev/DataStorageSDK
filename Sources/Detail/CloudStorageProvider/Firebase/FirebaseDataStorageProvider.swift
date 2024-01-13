//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation
import DataStorageInterfaces
import FirebaseFirestore

public class FirebaseDataStorageProvider: DataStorageProviderStrategy {
    
    private var _db: Firestore!
    private let _collection: String
    
    public init(collection: String) {
        self._collection = collection
        super.init()
        configure()
    }
    
//  MARK: - GET PROPERTIES
    
    public var db: Firestore {_db}
    
    public var collection: String {_collection}
    
    
//  MARK: - INSERT

    public override func create<T>(_ object: T) async throws -> T? {
        guard var data = object as? [String : Any] else { return object }
        
        let document: DocumentReference = try await db.collection(_collection).addDocument(data: data)

        data.updateValue(document.documentID, forKey: "documentID")
        
        return data as? T
    }

    public override func create<T>(_ document: String, _ object: T) async throws -> T? {
        guard let data = object as? [String : Any] else { return object }
        
        let path = collection + "/" + document
        
        let _: DocumentReference = try await db.collection(path).addDocument(data: data)
        
        return object
    }
    
    
//  MARK: - FETCH
//    
//    public override func fetch<T>() async throws -> [T] {
//        let querySnapshot: QuerySnapshot = try await db.collection(_collection).getDocuments()
//        
//        let data: [QueryDocumentSnapshot] = querySnapshot.documents
//        
//        return data.map { $0.data() } as? [T] ?? []
//    }
//    
//    public override func fetch<T>(limit: Int) async throws -> [T] {
//        let querySnapshot: QuerySnapshot = try await db.collection(_collection).limit(to: limit).getDocuments()
//        
//        let data: [QueryDocumentSnapshot] = querySnapshot.documents
//        
//        return data.map { $0.data() } as? [T] ?? []
//    }

    
    
//  MARK: - FETCH COUNT
    
    public override func fetchCount() async throws -> Int {
        return try await db.collection(_collection).getDocuments().count
    }
    
    public override func fetchCount(_ document: String) async throws -> Int {
        let path = collection + "/" + document
        
        return try await db.collection(path).getDocuments().count
    }

    
//  MARK: - FIND BY
    
    public override func findBy<T>(_ document: String) async throws -> T? {
        let path = collection + "/" + document
        
        let querySnapshot: QuerySnapshot = try await db.collection(path).getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        _db = Firestore.firestore()
    }
}
