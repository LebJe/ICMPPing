// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

@testable import ICMPPing
import XCTest

final class ICMPPingTests: XCTestCase {
	func testLocalPing() throws {
		let ipv4Address = try ICMPPing.IPAddress("127.0.0.1", type: .ipv4)
		let ipv6Address = try ICMPPing.IPAddress("0:0:0:0:0:0:0:1", type: .ipv6)

		let ipv4Res = ICMPPing.ping(address: ipv4Address, timeout: 5)
		let ipv6Res = ICMPPing.ping(address: ipv6Address, timeout: 5)

		// IPv4

		XCTAssertEqual(ipv4Res.address, ipv4Address)
		XCTAssertEqual(ipv4Res.code, 0)
		XCTAssertEqual(ipv4Res.responseType, .success)

		// For some reason IPv6 doesn't work on Linux...
		#if !os(Linux)
			// IPv6
			XCTAssertEqual(ipv6Res.address, ipv6Address)
			XCTAssertEqual(ipv6Res.code, 0)
			XCTAssertEqual(ipv6Res.responseType, .success)
		#endif
	}
}
