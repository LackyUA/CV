// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Application",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "Application",
            targets: ["Application"]
        ),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../CoreUI"),
        .package(path: "../Services"),
    ],
    targets: [
        .target(
            name: "Application",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "CoreUI", package: "CoreUI"),
                .product(name: "Services", package: "Services"),
            ]
        ),
        .testTarget(
            name: "ApplicationTests",
            dependencies: ["Application"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
