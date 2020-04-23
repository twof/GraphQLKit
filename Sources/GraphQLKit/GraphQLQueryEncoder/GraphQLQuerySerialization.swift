//
//  File.swift
//  
//
//  Created by fnord on 4/22/20.
//

import Foundation

struct GraphQLQuerySerialization {
    static func string(from dict: [String: Any], level: Int = 1) -> String {
        var result = "{"
        
        for (key, value) in dict {
            if let value = value as? Dictionary<String, Any> {
                if value.count == 0 {
                    result += "\n\(tabs(level))\(key)"
                } else {
                    result += "\n\(tabs(level))\(key) \(string(from: value, level: level + 1))"
                }
            } else if let value = value as? Array<Dictionary<String, Any>> {
                if let element = value.first {
                    if element.isEmpty {
                        result += "\n\(tabs(level))\(key)"
                    } else {
                        result += "\n\(tabs(level))\(key) \(string(from: element, level: level + 1))"
                    }
                }
            } else {
                fatalError()
            }
        }
        
        return result + "\n\(tabs(level-1))}"
    }
    
    static private func tabs(_ num: Int) -> String {
        return (0..<num).map { _ in "  "}.joined()
    }
}

protocol PrimitiveMarker {  }
extension Int: PrimitiveMarker { }
extension Double: PrimitiveMarker { }
extension String: PrimitiveMarker { }
extension Bool: PrimitiveMarker {  }
