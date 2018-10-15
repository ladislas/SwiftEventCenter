// swift-tools-version:4.2
// Managed by ice

import PackageDescription

let package = Package(

	name: "SwiftEventCenter",

	products: [

			.library(name: "EventCenter", targets: ["EventCenter"]),

	],

	targets: [

			.target(name: "EventCenter", dependencies: [], path: "Sources"),

			.testTarget(name: "EventCenterTests", dependencies: ["EventCenter"]),
			.testTarget(name: "ObserverStructureTests", dependencies: ["EventCenter"]),

	]
)
