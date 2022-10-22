#ifndef Conversion_hpp
#define Conversion_hpp

#ifdef __cplusplus

	#include "icmplib.h"
	#include <ICMPLib/ICMPLib.h>

CPingResultResponseType icmpPingResponseTypeToCPingResultResponseType(icmplib::PingResponseType rt);
CPingResponse icmpPingResultToCPingResponse(icmplib::PingResult pr);
icmplib::IPAddress::Type CIPAddressTypeToICMPIPAddressType(CIPAddressType type);
CIPAddressType icmpIPAddressTypeToCIPAddressType(icmplib::IPAddress::Type type);

#endif
#endif
