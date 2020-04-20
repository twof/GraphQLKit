//
//  File.swift
//  
//
//  Created by Alex Reilly on 4/20/20.
//

import Foundation

struct Schema: Codable {
  let queryType: QueryType
  let mutationType: MutationType
  let subscriptionType: SubscriptionType?
  let types: [Type]
  let directives: [Directive]
}
