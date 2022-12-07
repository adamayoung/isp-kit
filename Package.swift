// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "isp-kit",

    platforms: [
        .macOS(.v10_15)
    ],

    products: [
        .library(name: "Sportsbook", targets: ["Sportsbook"]),
        .library(name: "SCAN", targets: ["SCAN"]),
        .library(name: "SMP", targets: ["SMP"]),
        .library(name: "SIB", targets: ["SIB"]),
        .library(name: "SCA", targets: ["SCA"]),
        .library(name: "CMS", targets: ["CMS"])
    ],

    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.13.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.42.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0")
    ],

    targets: [
        .target(
            name: "Sportsbook",
            dependencies: [
                "SCAN",
                "SMP",
                "SIB",
                "SCA",
                "CMS",
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "SportsbookTests",
            dependencies: [
                "Sportsbook"
            ]
        ),

        .target(
            name: "SCAN",
            dependencies: [
                "GBPCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "SCANTests",
            dependencies: [
                "SCAN"
            ]
        ),

        .target(
            name: "SMP",
            dependencies: [
                "GBPCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "SMPTests",
            dependencies: [
                "SMP"
            ]
        ),

        .target(
            name: "SIB",
            dependencies: [
                "GBPCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "SIBTests",
            dependencies: [
                "SIB"
            ]
        ),

        .target(
            name: "SCA",
            dependencies: [
                "GBPCore",
                .product(name: "Logging", package: "swift-log")
            ],
            exclude: [
                "Resources"
            ]
        ),
        .testTarget(
            name: "SCATests",
            dependencies: [
                "SCA"
            ]
        ),

        .target(
            name: "CMS",
            dependencies: [
                "CMSCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "CMSTests",
            dependencies: [
                "CMS"
            ]
        ),

        .target(
            name: "PSA",
            dependencies: [
                "StarsCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "PSATests",
            dependencies: [
                "PSA"
            ]
        ),

        .target(
            name: "GBPCore",
            dependencies: [
                "ISPCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "GBPCoreTests",
            dependencies: [
                "GBPCore"
            ]
        ),

        .target(
            name: "CMSCore",
            dependencies: [
                "ISPCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "CMSCoreTests",
            dependencies: [
                "CMSCore"
            ]
        ),

        .target(
            name: "StarsCore",
            dependencies: [
                "ISPCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "StarsCoreTests",
            dependencies: [
                "StarsCore"
            ]
        ),

        .target(
            name: "ISPCore",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "ISPCoreTests",
            dependencies: [
                "ISPCore"
            ]
        )
    ]
)
