// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "DataStorageSDK",

    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(name: "DataStorageSDKMain", targets: ["DataStorageSDKMain"]),
    ],
    
    
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.18.0"))
    ],
    
    
    targets: [
        
//  MARK: - TARGET INTERFACE ADAPTERS
        
        .target(
            name: "DataStorageInterfaces",
            dependencies: [],
            path: "Sources/1InterfaceAdapter/Interfaces"
        ),
   
        
//  MARK: - TARGET DETAIL
        
        .target(
            name: "DataStorageDetail",
            dependencies: [
                "DataStorageInterfaces",
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
            ],
            path: "Sources/Detail"
        ),
        
        
        
//  MARK: - TARGET MAIN
        .target(
            name: "DataStorageSDKMain",
            dependencies: [
                "DataStorageDetail",
            ],
            path: "Sources/Main"
        ),


//  MARK: - TESTS TARGETS AREA
        
//        .testTarget(name: "DataStorageSDKTests", dependencies: []),
        
    ]
)
