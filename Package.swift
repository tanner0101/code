// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Code",
    products: [
        .library(name: "Code", targets: ["Code"]),
        .library(name: "Consoles", targets: ["Consoles"]),
        .library(name: "Commands", targets: ["Commands"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tanner0101/sourcekit.git", .branch("master")),
        .package(url: "https://github.com/vapor/leaf.git", .branch("recursive-descent")),
        .package(url: "https://github.com/vapor/core.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/bits.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Code", dependencies: ["SourceKit", "Leaf", "Consoles", "Bits"]),
        .testTarget(name: "CodeTests", dependencies: ["Code"]),
        .target(name: "Consoles", dependencies: ["Core", "Bits"]),
        .testTarget(name: "ConsolesTests", dependencies: ["Consoles"]),
        .target(name: "Commands", dependencies: ["Core", "Consoles"]),
        .testTarget(name: "CommandsTests", dependencies: ["Commands"]),
    ]
)
