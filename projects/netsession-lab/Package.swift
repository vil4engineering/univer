// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "NetSessionLab",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(name: "NetSessionCore", targets: ["NetSessionCore"]),
    ],
    targets: [
        .target(
            name: "NetSessionCore",
            path: "Sources/NetSessionCore"
        ),
        .testTarget(
            name: "NetSessionCoreTests",
            dependencies: ["NetSessionCore"],
            path: "Tests/NetSessionCoreTests",
            resources: [
                .copy("Fixtures"),
            ]
        ),
    ]
)
