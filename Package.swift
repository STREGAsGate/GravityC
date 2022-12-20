// swift-tools-version: 5.4
//
// Gravity source cloned from commit:
// https://github.com/marcobambini/gravity/tree/971337cc01877d62972e42cab5099379c5b97f12
// - Gravity source file headers were modified to use relative paths for includes.
// - Besides the above, no source changes were made to any GravityC source code.

import PackageDescription

let package = Package(
    name: "GravityC",
    products: [
        .library(name: "GravityC", type: .dynamic, targets: ["GravityC"]),
    ],
    targets: [
        .target(name: "GravityC", cSettings: [
            .define("BUILD_GRAVITY_API"),
            // WASI doesn't have umask
            .define("umask(x)", to: "022", .when(platforms: [.wasi]))
        ], linkerSettings: [
            // For path functions
            .linkedLibrary("shlwapi", .when(platforms: [.windows])),
            // For math functions
            .linkedLibrary("m", .when(platforms: [.macOS, .macCatalyst, .iOS, .tvOS, .watchOS, .linux, .android, .wasi])),
        ]),
    ],
    swiftLanguageVersions: [.v5],
    cLanguageStandard: .gnu99
)
