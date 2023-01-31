// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LiteNet",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LiteNet",
            targets: ["LiteNet"]),
    ],
    dependencies: [
        .package(
            name: "Alamofire",
            url: "https://github.com/Alamofire/Alamofire.git",
            .exact("5.5.0")
        ),
    ],
    targets: [
        .target(
            name: "LiteNet",
            dependencies: ["Alamofire"],
            path: "Sources"
        )
    ]
)
