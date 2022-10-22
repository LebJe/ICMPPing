// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

extension UnsafeMutablePointer where Self.Pointee == CChar {
	var string: String {
		String(cString: self)
	}
}

extension UnsafePointer where Self.Pointee == CChar {
	var string: String {
		String(cString: self)
	}
}
