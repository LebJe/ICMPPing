#include "Conversion.hpp"
#include "icmplib.h"
#include <ICMPLib/ICMPLib.h>

#ifdef __cplusplus

CPingResponse icmpPingResultToCPingResponse(icmplib::PingResult pr) {
	return CPingResponse {
		.address = reinterpret_cast<CIPAddress *>(new icmplib::IPAddress(pr.address)),
		.code = pr.code,
		.ttl = pr.ttl,
		.interval = pr.interval,
		.responseType = icmpPingResponseTypeToCPingResultResponseType(pr.response),
	};
};

CPingResultResponseType
icmpPingResponseTypeToCPingResultResponseType(icmplib::PingResponseType rt) {
	switch (rt) {
		case icmplib::PingResponseType::Success:
			return CPingResultResponseType::Success;
		case icmplib::ICMPEcho::Result::ResponseType::Unreachable:
			return CPingResultResponseType::Unreachable;
			break;
		case icmplib::ICMPEcho::Result::ResponseType::TimeExceeded:
			return CPingResultResponseType::TimeExceeded;
			break;
		case icmplib::ICMPEcho::Result::ResponseType::Timeout:
			return CPingResultResponseType::Timeout;
			break;
		case icmplib::ICMPEcho::Result::ResponseType::Unsupported:
			return CPingResultResponseType::Unsupported;
			break;
		case icmplib::ICMPEcho::Result::ResponseType::Failure:
			return CPingResultResponseType::Failure;
			break;
	}
}

CIPAddressType icmpIPAddressTypeToCIPAddressType(icmplib::IPAddress::Type type) {
	switch (type) {
		case icmplib::IPAddress::Type::IPv4:
			return CIPAddressType::IPv4;
			break;
		case icmplib::IPAddress::Type::IPv6:
			return CIPAddressType::IPv6;
			break;
		case icmplib::IPAddress::Type::Unknown:
			return CIPAddressType::IPUnknown;
			break;
	}
}

icmplib::IPAddress::Type CIPAddressTypeToICMPIPAddressType(CIPAddressType type) {
	switch (type) {
		case CIPAddressType::IPv4:
			return icmplib::IPAddress::Type::IPv4;
			break;
		case CIPAddressType::IPv6:
			return icmplib::IPAddress::Type::IPv6;
			break;
		case CIPAddressType::IPUnknown:
			return icmplib::IPAddress::Type::Unknown;
			break;
	}
}

#endif
