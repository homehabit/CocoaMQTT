// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CocoaMQTT",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10)
    ],
    products: [
        .library(name: "CocoaMQTT", targets: [ "CocoaMQTT" ]),
        .library(name: "CocoaMQTTWebSocket", targets: [ "CocoaMQTTWebSocket" ])
    ],
    dependencies: [
        .package(url: "https://github.com/leeway1208/MqttCocoaAsyncSocket", from: "1.0.8"),
        .package(url: "https://github.com/homehabit/Starscream.git", revision: "1334815b730ef1bf16da377949a5e728a2e1d243"),
    ],
    targets: [
        .target(name: "CocoaMQTT",
                dependencies: [ "MqttCocoaAsyncSocket" ],
                path: "Source",
                exclude: ["CocoaMQTTWebSocket.swift"],
                swiftSettings: [ .define("IS_SWIFT_PACKAGE")]),
        .target(name: "CocoaMQTTWebSocket",
                dependencies: [ "CocoaMQTT", "Starscream" ],
                path: "Source",
                sources: ["CocoaMQTTWebSocket.swift"],
                swiftSettings: [ .define("IS_SWIFT_PACKAGE")]),
        .testTarget(name: "CocoaMQTTTests",
                    dependencies: [ "CocoaMQTT", "CocoaMQTTWebSocket" ],
                    path: "CocoaMQTTTests",
                    swiftSettings: [ .define("IS_SWIFT_PACKAGE")])
    ]
)
