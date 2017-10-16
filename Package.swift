// swift-tools-version:3.1


import PackageDescription

let package = Package(
    name: "RaspberrySwift",
    targets: [
        Target(
            name: "RaspberrySwift",
            dependencies: ["Home"]
        ),
        Target(name: "Home")
    ],
    dependencies: [
        .Package(url: "https://github.com/uraimo/SwiftyGPIO.git", majorVersion: 0),
    ]
)
