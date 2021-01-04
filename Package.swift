// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BrandiUtility",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BrandiUtility",
            targets: ["BrandiUtility"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BrandiUtility",
            dependencies: ["Realm", "SDWebImage"],
            path: "Sources"),
        .testTarget(
            name: "BrandiUtilityTests",
            dependencies: ["BrandiUtility"]),
    ]
)

if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
    package.dependencies += [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa", from: "10.5.0"),
        .package(name: "SDWebImage", url: "https://github.com/SDWebImage/SDWebImage", from: "5.10.2"),
    ]
} else {
    package.dependencies += [
        .package(path: "../Realm"),
        .package(path: "../RealmDatabase"),
        .package(path: "../SDWebImage"),
    ]
}
