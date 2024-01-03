# ICMPPing

**Send [ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol) Ping requests in Swift! Powered by [cpp-icmplib](https://github.com/markondej/cpp-icmplib).**

[![Swift 5.5](https://img.shields.io/badge/Swift-5.5-brightgreen?logo=swift)](https://swift.org)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![](https://img.shields.io/github/v/tag/LebJe/ICMPPing)](https://github.com/LebJe/ICMPPing/releases)
[![Build and Test](https://github.com/LebJe/ICMPPing/workflows/Build%20and%20Test/badge.svg)](https://github.com/LebJe/ICMPPing/actions?query=workflow%3A%22Build+and+Test%22)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FLebJe%2FICMPPing%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/LebJe/ICMPPing)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FLebJe%2FICMPPing%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/LebJe/ICMPPing)

<!--ts-->

-   [ICMPPing](#icmpping)
    -   [Installation](#installation)
        -   [Swift Package Manager](#swift-package-manager)
        -   [Full Documentation](#full-documentation)
    -   [Quick Start](#quick-start)
    -   [Dependencies](#dependencies)
    -   [Licenses](#licenses)
    -   [Contributing](#contributing)

<!-- Added by: lebje, at: Sun Oct 23 21:44:53 EDT 2022 -->

<!--te-->

## Installation

### Swift Package Manager

Add this to the `dependencies` array in `Package.swift`:

```swift
.package(url: "https://github.com/LebJe/ICMPPing.git", from: "0.0.1")
```

Also add this to the `targets` array in the aforementioned file:

```swift
.product(name: "ICMPPing", package: "ICMPPing")
```

### Full Documentation

Full documentation is available [here](https://lebje.github.io/ICMPPing/documentation/icmpping/).

## Quick Start

```swift
import ICMPPing

// Google's IP Address
let address = try ICMPPing.IPAddress("8.8.8.8", type: .ipv4)

let result = ICMPPing.ping(address: address, timeout: 10 /* seconds */)

print(result)

// ICMPPing.Response(
//     address: 8.8.8.8,
//     code: 0,
//     timeToLive: 116,
//     interval: 23.011,
//     responseType: ICMPPing.Response.ResponseType.success
// )
```

## Dependencies

-   [cpp-icmplib](https://github.com/markondej/cpp-icmplib/)

## Licenses

The [cpp-icmplib](https://github.com/markondej/cpp-icmplib/) license is available at [https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/LICENSE](https://github.com/markondej/cpp-icmplib/blob/c1e04b53923eec57efb898a4fdf94fea5b856c1d/LICENSE).

## Contributing

Before committing, please install [pre-commit](https://pre-commit.com), [swift-format](https://github.com/nicklockwood/SwiftFormat), [clang-format](https://clang.llvm.org/docs/ClangFormat.html), and [Prettier](https://prettier.io), then install the pre-commit hook:

```bash
$ brew bundle # install the packages specified in Brewfile
$ pre-commit install

# Commit your changes.
```

To install pre-commit on other platforms, refer to the [documentation](https://pre-commit.com/#install).
