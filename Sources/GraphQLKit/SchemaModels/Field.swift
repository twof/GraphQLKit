//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

struct Field: Codable {
  let name: String
  let description: String?
  let args: [Argument]
  let type: Type
  let isDeprecated: Bool
  let deprecationReason: String?
}
