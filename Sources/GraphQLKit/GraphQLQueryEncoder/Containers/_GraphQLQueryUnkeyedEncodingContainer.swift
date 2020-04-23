//
//  File.swift
//  
//
//  Created by fnord on 4/22/20.
//

import Foundation

struct _GraphQLQueryUnkeyedEncodingContainer : UnkeyedEncodingContainer {
    // MARK: Properties

    /// A reference to the encoder we're writing to.
    private let encoder: __GraphQLQueryEncoder

    /// A reference to the container we're writing to.
    private let container: NSMutableArray

    /// The path of coding keys taken to get to this point in encoding.
    private(set) public var codingPath: [CodingKey]

    /// The number of elements encoded into the container.
    public var count: Int {
        return self.container.count
    }

    // MARK: - Initialization

    /// Initializes `self` with the given references.
    init(referencing encoder: __GraphQLQueryEncoder, codingPath: [CodingKey], wrapping container: NSMutableArray) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.container = container
    }

    // MARK: - UnkeyedEncodingContainer Methods

    public mutating func encodeNil() throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: Bool) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: Int) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: Int8) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: Int16) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: Int32) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: Int64) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: UInt) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: UInt8) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: UInt16) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: UInt32) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: UInt64) throws {
        self.container.add([:])
    }
    public mutating func encode(_ value: String) throws {
        self.container.add([:])
    }

    public mutating func encode(_ value: Float)  throws {
        // Since the float may be invalid and throw, the coding path needs to contain this key.
        self.encoder.codingPath.append(_GraphQLQueryKey(index: self.count))
        defer { self.encoder.codingPath.removeLast() }
        self.container.add([:])
    }

    public mutating func encode(_ value: Double) throws {
        // Since the double may be invalid and throw, the coding path needs to contain this key.
        self.encoder.codingPath.append(_GraphQLQueryKey(index: self.count))
        defer { self.encoder.codingPath.removeLast() }
        self.container.add([:])
    }

    public mutating func encode<T : Encodable>(_ value: T) throws {
        self.encoder.codingPath.append(_GraphQLQueryKey(index: self.count))
        defer { self.encoder.codingPath.removeLast() }
        self.container.add(try self.encoder.box(value))
    }

    public mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> {
        self.codingPath.append(_GraphQLQueryKey(index: self.count))
        defer { self.codingPath.removeLast() }

        let dictionary = NSMutableDictionary()
        self.container.add(dictionary)

        let container = _GraphQLQueryKeyedEncodingContainer<NestedKey>(referencing: self.encoder, codingPath: self.codingPath, wrapping: dictionary)
        return KeyedEncodingContainer(container)
    }

    public mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        self.codingPath.append(_GraphQLQueryKey(index: self.count))
        defer { self.codingPath.removeLast() }

        let array = NSMutableArray()
        self.container.add(array)
        return _GraphQLQueryUnkeyedEncodingContainer(referencing: self.encoder, codingPath: self.codingPath, wrapping: array)
    }

    public mutating func superEncoder() -> Encoder {
        return __GraphQLQueryReferencingEncoder(referencing: self.encoder, at: self.container.count, wrapping: self.container)
    }
    
    private func isPrimitive<T>(_ type: T.Type) -> Bool {
        return [String.self, Int.self, Float.self, Double.self, Bool.self].contains { $0 == T.self }
    }
}
