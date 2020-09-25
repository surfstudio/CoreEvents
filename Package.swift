// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreEvents",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "CoreEvents",
            targets: ["CoreEvents"]),
    ],
    targets: [
        .target(
            name: "CoreEvents",
            path: "CoreEvents/CoreEvents"
        ),
        .testTarget(
            name: "CoreEventsTests",
            dependencies: [
                "CoreEvents"
            ],
            path: "CoreEvents/CoreEventsTests"
        ),
    ]
)

