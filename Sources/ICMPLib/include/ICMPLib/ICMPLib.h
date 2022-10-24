// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#ifndef ICMPLIB_H
#define ICMPLIB_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

	struct CIPAddress;
	typedef struct CIPAddress CIPAddress;

	enum CIPAddressType { IPv4, IPv6, IPUnknown } __attribute__((enum_extensibility(closed)));

	typedef enum CIPAddressType CIPAddressType;

	struct CIPError {
		const char * _Nullable message;
	};

	typedef struct CIPError CIPError;

	enum CPingResultResponseType {
		Success,
		Unreachable,
		TimeExceeded,
		Timeout,
		Unsupported,
		Failure
	} __attribute__((enum_extensibility(closed)));

	typedef enum CPingResultResponseType CPingResultResponseType;

	struct CPingResponse {
		CIPAddress * _Nonnull address;
		uint8_t code;
		uint8_t ttl;
		double interval;
		CPingResultResponseType responseType;
	};
	typedef struct CPingResponse CPingResponse;

	CIPAddress * _Nullable ipAddressCreate(
		const char * _Nonnull address, CIPAddressType type, CIPError * _Nonnull errorPointer);

	CIPAddress * _Nonnull ipAddressCreateLong(unsigned long address);

	void ipAddressSetPort(CIPAddress * _Nonnull address, uint16_t port);

	uint16_t ipAddressGetPort(CIPAddress * _Nonnull address);

	CIPAddressType ipAddressGetType(CIPAddress * _Nonnull address);

	const char * _Nullable ipAddressToString(
		CIPAddress * _Nonnull address, CIPError * _Nonnull errorPointer);

	CPingResponse
	icmpPing(CIPAddress * _Nonnull address, unsigned timeout, uint16_t sequence, uint8_t ttl);

#ifdef __cplusplus
}
#endif

#endif /* CTOML_H */
