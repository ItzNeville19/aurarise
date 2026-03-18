// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Stomp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Stomp",
            targets: ["Stomp"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Stomp",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
