// swift-tools-version:5.4
import PackageDescription

let package = Package(
  name: "Mavsdk",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15)
  ],
  products: [
    .library(name: "Mavsdk",
             targets: [
              "Mavsdk",
             ]
    ),
    .library(name: "MavsdkServer",
             targets: [
              "MavsdkServer"
             ]
    ),
    .library(name: "mavsdk_server",
             targets: [
              "mavsdk_server"
             ]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/grpc/grpc-swift", from: "1.0.0"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.1")
  ],
  targets: [
    .target(name: "Mavsdk",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxBlocking", package: "RxSwift")
            ],
            exclude: [
              "proto",
              "templates",
              "tools"
            ]
    ),
    .target(name: "MavsdkServer",
            dependencies: [
                "mavsdk_server"
            ]
    ),
    .binaryTarget(name: "mavsdk_server",
                      url: "https://github.com/mavlink/MAVSDK/releases/download/v0.47.5/mavsdk_server.xcframework.zip",
                      checksum: "2786c087badaf35f726ddf39509914000ccebde1d664e572ea8219375628ba4e"),
    .testTarget(name: "MavsdkTests",
                dependencies: [
                  "Mavsdk",
                  .product(name: "RxTest", package: "RxSwift"),
                  .product(name: "RxBlocking", package: "RxSwift")
                ]
    )
  ]
)
