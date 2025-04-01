// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ORBLoading",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ORBLoading",
            targets: ["ORBLoading"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: .init(4, 5, 1)),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ORBLoading",
            dependencies: [
                .product(name: "Lottie", package: "lottie-spm"),
                .product(name: "SnapKit", package: "SnapKit")
            ]),
        .testTarget(
            name: "ORBLoadingTests",
            dependencies: ["ORBLoading"]
        ),
    ]
)
