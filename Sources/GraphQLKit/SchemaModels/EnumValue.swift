//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

struct EnumValue: Codable {
  let name: String
  let description: String
  let isDeprecated: Bool
  let deprecationReason: String?
}
