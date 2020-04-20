//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

struct Directive: Codable {
  let name: String
  let description: String
  let locations: [String]
  let args: [Argument]
}
