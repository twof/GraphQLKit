//
//  File.swift
//  
//
//  Created by fnord on 4/22/20.
//

import Foundation

extension __GraphQLQueryEncoder {
    /// Returns the given value boxed in a container appropriate for pushing onto the container stack.
    func box(_ value: Bool)   -> NSObject { return NSDictionary() }
    func box(_ value: Int)    -> NSObject { return NSDictionary() }
    func box(_ value: Int8)   -> NSObject { return NSDictionary() }
    func box(_ value: Int16)  -> NSObject { return NSDictionary() }
    func box(_ value: Int32)  -> NSObject { return NSDictionary() }
    func box(_ value: Int64)  -> NSObject { return NSDictionary() }
    func box(_ value: UInt)   -> NSObject { return NSDictionary() }
    func box(_ value: UInt8)  -> NSObject { return NSDictionary() }
    func box(_ value: UInt16) -> NSObject { return NSDictionary() }
    func box(_ value: UInt32) -> NSObject { return NSDictionary() }
    func box(_ value: UInt64) -> NSObject { return NSDictionary() }
    func box(_ value: String) -> NSObject { return NSDictionary() }

    func box(_ float: Float) throws -> NSObject {
        return NSDictionary()
    }

    func box(_ double: Double) throws -> NSObject {
        return NSDictionary()
    }

    func box(_ date: Date) throws -> NSObject {
        return NSDictionary()
    }

    func box(_ data: Data) throws -> NSObject {
        return NSDictionary()
    }

    func box(_ dict: [String : Encodable]) throws -> NSObject? {
        let depth = self.storage.count
        let result = self.storage.pushKeyedContainer()
        do {
            for (key, value) in dict {
                self.codingPath.append(_GraphQLQueryKey(stringValue: key, intValue: nil))
                defer { self.codingPath.removeLast() }
                result[key] = try box(value)
            }
        } catch {
            // If the value pushed a container before throwing, pop it back off to restore state.
            if self.storage.count > depth {
                let _ = self.storage.popContainer()
            }

            throw error
        }

        // The top container should be a new container.
        guard self.storage.count > depth else {
            return nil
        }

        return self.storage.popContainer()
    }

    func box(_ value: Encodable) throws -> NSObject {
        return try self.box_(value) ?? NSDictionary()
    }

    // This method is called "box_" instead of "box" to disambiguate it from the overloads. Because the return type here is different from all of the "box" overloads (and is more general), any "box" calls in here would call back into "box" recursively instead of calling the appropriate overload, which is not what we want.
    func box_(_ value: Encodable) throws -> NSObject? {
        // Disambiguation between variable and function is required due to
        // issue tracked at: https://bugs.swift.org/browse/SR-1846
        let type = Swift.type(of: value)
        if type == Date.self || type == NSDate.self {
            // Respect Date encoding strategy
            return try self.box((value as! Date))
        } else if type == Data.self || type == NSData.self {
            // Respect Data encoding strategy
            return try self.box((value as! Data))
        } else if type == URL.self || type == NSURL.self {
            // Encode URLs as single strings.
            return self.box((value as! URL).absoluteString)
        } else if type == Decimal.self || type == NSDecimalNumber.self {
            // JSONSerialization can natively handle NSDecimalNumber.
            return (value as! NSDecimalNumber)
        } else if value is _GraphQLQueryStringDictionaryEncodableMarker {
            return try self.box(value as! [String : Encodable])
        }

        // The value should request a container from the __JSONEncoder.
        let depth = self.storage.count
        do {
            try value.encode(to: self)
        } catch {
            // If the value pushed a container before throwing, pop it back off to restore state.
            if self.storage.count > depth {
                let _ = self.storage.popContainer()
            }

            throw error
        }

        // The top container should be a new container.
        guard self.storage.count > depth else {
            return nil
        }

        return self.storage.popContainer()
    }
}
