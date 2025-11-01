// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "EphemeralKeyServer",
    // ✅ macOS만 빌드 대상으로 지정 (iOS 제외)
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.92.0")
    ],
    targets: [
        .executableTarget(
            name: "EphemeralKeyServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ],
            // ✅ iOS 빌드를 완전히 배제
            swiftSettings: [
                .define("VAPOR_NO_IOS")
            ]
        )
    ]
)




