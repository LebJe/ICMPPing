#include "Conversion.hpp"
#include "icmplib.h"
#include <ICMPLib/ICMPLib.h>

#ifdef __cplusplus

CPingResponse
icmpPing(CIPAddress * _Nonnull address, unsigned timeout, uint16_t sequence, uint8_t ttl) {
	return icmpPingResultToCPingResponse(
		icmplib::Ping(*reinterpret_cast<icmplib::IPAddress *>(address), timeout, sequence, ttl));
};

#endif
