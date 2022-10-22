// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import ICMPLib

/// Send [ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol) Echo requests.
///
/// ```swift
/// import ICMPPing
///
/// // Google IP Address
/// let address = try ICMPPing.IPAddress("8.8.8.8", type: .ipv4)
///
/// let result = ICMPPing.ping(address: address, timeout: 10 /* seconds */)
///
/// print(result)
///
/// // ICMPPing.Response(
/// //     address: 8.8.8.8,
/// //     code: 0,
/// //     timeToLive: 116,
/// //     interval: 23.011,
/// //     responseType: ICMPPing.Response.ResponseType.success
/// // )
/// ```
public enum ICMPPing {
	/// Send an ICMP Echo request to `address`.
	/// - Parameters:
	///     - address: IP address to send the request to.
	///     - timeout: Timeout in seconds.
	///     - sequence: Sequence number to be sent.
	///     - timeToLive: Time-to-live to be set for packet.
	///
	/// - Note: The underlying [C++ library](https://github.com/markondej/cpp-icmplib) requires administator priviledges to
	/// send ICMP packets.
	///
	/// Make sure you run your code with `sudo` or something similar.
	///
	/// Documentation comments for the last three parameters comes from [this section](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L14-L16)
	/// of the README of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
	public static func ping(
		address: IPAddress,
		timeout: UInt32 = 60,
		sequence: UInt16 = 1,
		timeToLive: UInt8 = 255
	) -> Self.Response {
		Response(icmpPing(address.addressPointer, timeout, sequence, timeToLive))
	}
}

public extension ICMPPing {
	/// The response returned from an ICMP Echo request.
	struct Response {
		/// Address of responding host
		///
		/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L37)
		/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
		public let address: IPAddress

		/// ICMP Code parameter
		///
		/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L38)
		/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
		public let code: UInt8

		/// Received IPv4 header TTL parameter
		///
		/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L39)
		/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
		public let timeToLive: UInt8

		/// Time in miliseconds between sending request and receiving response
		///
		/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L36)
		/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
		public let interval: Double

		/// Type of received response
		///
		/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L40)
		/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
		public let responseType: ResponseType

		init(_ cPingResponse: CPingResponse) {
			self.address = IPAddress(cPingResponse.address)
			self.code = cPingResponse.code
			self.timeToLive = cPingResponse.ttl
			self.interval = cPingResponse.interval
			self.responseType = ResponseType(cPingResponse.responseType)
		}

		public enum ResponseType {
			/// ICMP Echo Response successfully received
			///
			/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L45)
			/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
			case success

			/// ICMP Destination Unreachable message received (eg. target host does not exist)
			///
			/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L46)
			/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
			case unreachable

			/// ICMP Time Exceeded message received (eg. TTL meet zero value on some host)
			///
			/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L47)
			/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
			case timeExceeded

			/// No message received in given time (see "timeout" parameter)
			///
			/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L48)
			/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
			case timeout

			/// Received unsupported ICMP packet
			///
			/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L49)
			/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
			case unsupported

			/// Failed to send ICMP Echo Request to given target host
			///
			/// This documentation comment is from the [README](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/README.md?plain=1#L50)
			/// of [cpp-icmplib](https://github.com/markondej/cpp-icmplib).
			case failure

			init(_ cResultType: CPingResultResponseType) {
				switch cResultType {
					case .Success: self = .success
					case .Unreachable: self = .unreachable
					case .TimeExceeded: self = .timeExceeded
					case .Timeout: self = .timeout
					case .Unsupported: self = .unsupported
					case .Failure: self = .failure
				}
			}
		}
	}
}
