// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import ICMPLib

public extension ICMPPing {
	/// An IPV4 or IPV6 [IP Address](https://en.wikipedia.org/wiki/IP_address).
	class IPAddress: Equatable, CustomStringConvertible {
		let addressPointer: OpaquePointer

		public var description: String {
			(try? self.string) ?? ""
		}

		public var string: String? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CIPError>.allocate(capacity: 1)

				guard let str = ipAddressToString(self.addressPointer, errorPointer) else {
					if let message = errorPointer.pointee.message {
						throw IPAddressError(message: message.string)
					} else {
						throw IPAddressError(message: "unknown error")
					}
				}

				return str.string
			}
		}

		public var port: UInt16 {
			get {
				ipAddressGetPort(self.addressPointer)
			}
			set {
				ipAddressSetPort(self.addressPointer, newValue)
			}
		}

		public var type: AddressType {
			AddressType(ipAddressGetType(self.addressPointer))
		}

		init(_ addressPointer: OpaquePointer) {
			self.addressPointer = addressPointer
		}

		///
		public init(_ address: String, port: UInt16? = nil, type: AddressType = .unknown) throws {
			let errorPointer = UnsafeMutablePointer<CIPError>.allocate(capacity: 1)

			guard let addressPointer = ipAddressCreate(address, type.cIPAddressType, errorPointer) else {
				if let message = errorPointer.pointee.message {
					throw IPAddressError(message: message.string)
				} else {
					throw IPAddressError(message: "unknown")
				}
			}

			self.addressPointer = addressPointer

			if let port = port {
				ipAddressSetPort(self.addressPointer, port)
			}
		}

		public init(_ address: UInt) {
			self.addressPointer = ipAddressCreateLong(address)
		}

		public static func == (lhs: ICMPPing.IPAddress, rhs: ICMPPing.IPAddress) -> Bool {
			lhs.port == rhs.port && (try? lhs.string) == (try? rhs.string)
		}

		/// The type of IP address.
		public enum AddressType {
			/// [IPV4](https://en.wikipedia.org/wiki/IPv4)
			case ipv4

			/// [IPV6](https://en.wikipedia.org/wiki/IPv6)
			case ipv6

			///
			case unknown

			init(_ cAddressType: CIPAddressType) {
				switch cAddressType {
					case .IPv4: self = .ipv4
					case .IPv6: self = .ipv6
					case .Unknown: self = .unknown
				}
			}

			var cIPAddressType: CIPAddressType {
				switch self {
					case .ipv4: return .IPv4
					case .ipv6: return .IPv6
					case .unknown: return .Unknown
				}
			}
		}

		public struct IPAddressError: Error {
			let message: String
		}
	}
}
