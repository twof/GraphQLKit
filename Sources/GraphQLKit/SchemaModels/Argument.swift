//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

struct Argument: Codable {
  let name: String
  let description: String?
  let type: Type
  let defaultValue: String?
}
