#include "Conversion.hpp"
#include "icmplib.h"
#include <ICMPLib/ICMPLib.h>
#include <cstring>
#include <string>

#ifdef __cplusplus
CIPAddress * _Nullable ipAddressCreate(
	const char * _Nonnull address, CIPAddressType type, CIPError * _Nonnull errorPointer) {
	try {
		auto ipaddr = new icmplib::IPAddress(address, CIPAddressTypeToICMPIPAddressType(type));
		return reinterpret_cast<CIPAddress *>(ipaddr);
	} catch (std::runtime_error & e) {
		errorPointer->message = strdup(e.what());
		return NULL;
	}
};

CIPAddress * _Nonnull ipAddressCreateLong(unsigned long address) {
	auto ipaddr = new icmplib::IPAddress(address);
	return reinterpret_cast<CIPAddress *>(ipaddr);
}

void ipAddressSetPort(CIPAddress * _Nonnull address, uint16_t port) {
	reinterpret_cast<icmplib::IPAddress *>(address)->SetPort(port);
};

uint16_t ipAddressGetPort(CIPAddress * _Nonnull address) {
	return reinterpret_cast<icmplib::IPAddress *>(address)->GetPort();
};

CIPAddressType ipAddressGetType(CIPAddress * _Nonnull address) {
	return icmpIPAddressTypeToCIPAddressType(
		reinterpret_cast<icmplib::IPAddress *>(address)->GetType());
}

const char * _Nullable ipAddressToString(
	CIPAddress * _Nonnull address, CIPError * _Nonnull errorPointer) {
	try {
		return strdup(std::string(*reinterpret_cast<icmplib::IPAddress *>(address)).c_str());
	} catch (std::runtime_error & e) {
		errorPointer->message = strdup(e.what());
		return NULL;
	}
}

#endif
