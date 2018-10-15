// swift-tools-version:4.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "ExternalEventCenter",

    dependencies: [
    	.package(path: "../../../SwiftEventCenter")
    ],

    targets: [
        .target(name: "ExternalEventCenter", dependencies: ["EventCenter"]),
    ]
)
