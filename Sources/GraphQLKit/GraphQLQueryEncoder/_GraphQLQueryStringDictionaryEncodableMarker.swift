//
//  File.swift
//  
//
//  Created by fnord on 4/22/20.
//

import Foundation

protocol _GraphQLQueryStringDictionaryEncodableMarker { }

extension Dictionary : _GraphQLQueryStringDictionaryEncodableMarker where Key == String, Value: Encodable { }
