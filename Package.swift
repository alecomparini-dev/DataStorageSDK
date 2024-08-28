// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "DataStorageSDK",

    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "DataStorageSDK", targets: ["DataStorageSDK"]),
    ],
    
    
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.28.0")),
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.44.0"))
    ],
    
    
    targets: [
        
//  MARK: - TARGET INTERFACE ADAPTERS
        
        .target(
            name: "DataStorageInterfaces",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "RealmSwift", package: "realm-swift")
            ],
            path: "Sources/1InterfaceAdapter/Interfaces"
        ),
   
        
//  MARK: - TARGET DETAIL
        
        .target(
            name: "DataStorageSDK",
            dependencies: [
                "DataStorageInterfaces",
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
                .product(name: "RealmSwift", package: "realm-swift")
            ],
            path: "Sources/Detail"
        ),
        
        
        

//  MARK: - TESTS TARGETS AREA
        
//        .testTarget(name: "DataStorageSDKTests", dependencies: []),
        
    ]
)
