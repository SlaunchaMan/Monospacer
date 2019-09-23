// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Monospacer",
    products: [.library(name: "Monospacer", targets: ["Monospacer"])],
    targets: [
        .target(name: "Monospacer", dependencies: []),
        .testTarget(name: "MonospacerTests", dependencies: ["Monospacer"]),
    ]
)
