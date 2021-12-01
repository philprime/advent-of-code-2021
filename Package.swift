// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "advent-of-code-2021",
    products: [
        .executable(name: "day-1", targets: ["day-1"])
    ],
    targets: [
        .executableTarget(name: "day-1", resources: [
            .process("Resources")
        ])
    ]
)
