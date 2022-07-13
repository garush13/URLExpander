// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "URLExpander",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9)
    ],
    products: [
        .library(
            name: "URLExpander",
            targets: ["URLExpander"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "URLExpander",
            dependencies: []
        ),
        .testTarget(
            name: "URLExpanderTests",
            dependencies: ["URLExpander"]
        ),
    ]
)
