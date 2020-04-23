//
//  File.swift
//  
//
//  Created by fnord on 4/22/20.
//

import Foundation

var _iso8601Formatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = .withInternetDateTime
    return formatter
}()
