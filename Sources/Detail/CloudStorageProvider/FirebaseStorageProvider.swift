//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import FirebaseFirestore

public class FirebaseStorageProvider<T>: DataStorageProviderStrategy<T> {
    
    private var db: Firestore!
    
    private let collection: String
    
    public init(collection: String) {
        self.collection = collection
        super.init()
        configure()
    }
    
    
    
//  MARK: - INSERT
    public override func insert(_ document: String, _ object: T) async throws -> T? {
        guard let data = object as? [String : Any] else { return object }
        
        try await db.collection(collection).addDocument(data: data)
        
        return object
    }

    public override func insert(_ object: T) async throws -> T? {
        guard var data = object as? [String : Any] else { return object }
        
        let document: DocumentReference = try await db.collection(collection).addDocument(data: data)

        data.updateValue(document.documentID, forKey: "documentID")
        
        return data as? T
    }

    
    
//  MARK: - FETCH
    public override func fetch() async throws -> T? {
        
        let querySnapshot: QuerySnapshot = try await db.collection(collection).getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }
    
    public override func fetch(limit: Int) async throws -> T? {
        
        let querySnapshot: QuerySnapshot = try await db.collection(collection).limit(to: limit).getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }
    
    public override func fetchCount() async throws -> Int {
        return try await db.collection(collection).getDocuments().count
    }
    
    public override func fetchCount(_ document: String) async throws -> Int {
        let path = collection + "/" + document
        return try await db.collection(path).getDocuments().count
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
}
