import PackageDescription

let package = Package(
    name: "wise_text",
    platforms: [
        .iOS("15.0"),
        .macOS("10.15")
    ],
    products: [
        .library(name: "wise-text", targets: ["wise_text"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "wise_text",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: []
        )
    ]
)
