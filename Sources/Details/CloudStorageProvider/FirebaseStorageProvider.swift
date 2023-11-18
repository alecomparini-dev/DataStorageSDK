//  Created by Alessandro Comparini on 17/11/23.
//

import Foundation

import FirebaseFirestore

public class FirebaseStorageProvider: StorageProviderStrategy {
    
    private var db: Firestore!
    
    private let collection: String
    
    public init(collection: String) {
        self.collection = collection
        super.init()
        configure()
    }
    
    
    
//  MARK: - INSERT
    public override func insert<T>(_ document: String, _ object: T) async throws -> T? {
        guard let data = object as? [String : Any] else { return object }
        
        try await db.collection(collection).document(document).setData(data)
        
        return object
    }

    
    public override func insert<T>(_ object: T) async throws -> T? {
        guard var data = object as? [String : Any] else { return object }
        
        let document: DocumentReference = try await db.collection(collection).addDocument(data: data)

        data.updateValue(document.documentID, forKey: "documentID")
        
        return [:] as? T
    }

    
    
//  MARK: - FETCH
    public override func fetch<T>() async throws -> [T] {
        
        
        return []
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
}
