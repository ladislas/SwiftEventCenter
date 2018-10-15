// swift-tools-version:4.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "SimpleEventCenter",

    dependencies: [
    	.package(path: "../../../SwiftEventCenter")
    ],
    
    targets: [
        .target(name: "SimpleEventCenter", dependencies: ["EventCenter"]),
    ]
)
