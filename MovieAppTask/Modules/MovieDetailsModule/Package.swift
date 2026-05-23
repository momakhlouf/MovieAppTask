// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetailsModule",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MovieDetailsModule",
            targets: ["MovieDetailsModule"]
        ),
    ],
    dependencies: [
        .package(path: "../../Networking"),
        .package(path: "../../Commons"),
        .package(path: "../../LocalStorage"),
        .package(path: "../../DesignSystem"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MovieDetailsModule",
            dependencies: [
                "Networking",
                "Commons",
                "LocalStorage",
                "DesignSystem"
                ],
        ),
        .testTarget(
            name: "MovieDetailsModuleTests",
            dependencies: ["MovieDetailsModule"]
        ),
    ]
)
