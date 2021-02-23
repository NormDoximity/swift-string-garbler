// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ssg",
    platforms: [
            .macOS(.v10_15),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/apple/swift-tools-support-core", .upToNextMinor(from: "0.1.10")),
        .package(name: "Mustache", url: "https://github.com/groue/GRMustache.swift", .upToNextMinor(from: "4.0.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ssg",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
                .product(name: "Mustache", package: "Mustache"),
            ]
        ),
        .testTarget(
            name: "ssgTests",
            dependencies: ["ssg"]),
    ]
)
