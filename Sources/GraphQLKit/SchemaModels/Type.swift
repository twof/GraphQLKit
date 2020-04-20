//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

class Type: Codable {
  let kind: Kind
  let name: String?
  let description: String?
  let fields: [Field]?
  let ofType: Type?
  let inputFields: String?
  let interfaces: [String]?
  let enumValues: [EnumValue]?
}
