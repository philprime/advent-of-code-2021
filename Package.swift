// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "advent-of-code-2021",
    products: [
        .executable(name: "day-1", targets: ["day-1"]),
        .executable(name: "day-2", targets: ["day-2"]),
        .executable(name: "day-3", targets: ["day-3"]),
        .executable(name: "day-4", targets: ["day-4"]),
        .executable(name: "day-5", targets: ["day-5"])
    ],
    targets: [
        // Library
        .target(name: "assets", resources: [
            .process("Resources")
        ]),
        .target(name: "lib"),
        // Days
        .executableTarget(name: "day-1", resources: [
            .process("Resources")
        ]),
        .executableTarget(name: "day-2", resources: [
            .process("Resources")
        ]),
        .testTarget(name: "day-2-tests", dependencies: [
            "day-2"
        ]),
        .executableTarget(name: "day-3", resources: [
            .process("Resources")
        ]),
        .testTarget(name: "day-3-tests", dependencies: [
            "day-3"
        ]),
        .executableTarget(name: "day-4", dependencies: [
            "lib"
        ], resources: [
            .process("Resources")
        ]),
        .testTarget(name: "day-4-tests", dependencies: [
            "day-4"
        ]),
        .executableTarget(name: "day-5", dependencies: [
            "lib",
            "assets"
        ], resources: [
            .process("Resources")
        ]),
        .testTarget(name: "day-5-tests", dependencies: [
            "day-5"
        ]),
    ]
)
