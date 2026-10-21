// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "CoreUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "CoreUI",
            targets: ["CoreUI"]
        ),
    ],
    targets: [
        .target(
            name: "CoreUI",
            resources: [
                .process("DesignSystem/Foundations/Assets/Resources"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
