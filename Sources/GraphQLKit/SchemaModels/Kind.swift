//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

enum Kind: String, Codable {
  case object = "OBJECT"
  case scalar = "SCALAR"
  case nonNull = "NON_NULL"
  case list = "LIST"
  case `enum` = "ENUM"
}
