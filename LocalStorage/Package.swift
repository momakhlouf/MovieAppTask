// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalStorage",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LocalStorage",
            targets: ["LocalStorage"]
        ),
    ],
    dependencies: [
        .package(path: "CoreModels"),
      //I GET UNKOWN ERRORS FROM XCODE, SO WILL USE SWIFT DATA
        .package(url: "https://github.com/realm/realm-swift.git", from: "14.14.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LocalStorage",
            dependencies: [
                "CoreModels",
                
                    .product(name: "RealmSwift", package: "realm-swift")


            ]
        ),
    ]
)
