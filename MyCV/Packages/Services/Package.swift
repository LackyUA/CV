// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Services",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "Services",
            targets: ["Services"]
        ),
    ],
    targets: [
        .target(
            name: "Services",
            resources: [
                .process("Resources"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
