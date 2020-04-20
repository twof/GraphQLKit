//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

struct TopSchema: Codable {
  let schema: Schema
  
  enum CodingKeys: String, CodingKey {
    case schema = "__schema"
  }
}
