// swift-tools-version: 5.5

import PackageDescription

let package = Package(
	name: "ICMPPing",
	platforms: [
		.macOS(.v11),
		.iOS(.v14),
		.watchOS(.v6),
		.tvOS(.v12),
	],
	products: [
		.library(
			name: "ICMPPing",
			targets: ["ICMPPing"]
		),
	],
	dependencies: [],
	targets: [
		.target(name: "ICMPLib"),
		.target(
			name: "ICMPPing",
			dependencies: ["ICMPLib"]
		),
		.testTarget(
			name: "ICMPPingTests",
			dependencies: ["ICMPPing"]
		),
	],
	cLanguageStandard: .c99,
	cxxLanguageStandard: .cxx14
)

#if swift(>=5.6) && !os(Windows)
	package.dependencies.append(
		.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
	)
#endif
