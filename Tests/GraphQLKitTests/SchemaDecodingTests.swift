import XCTest
@testable import GraphQLKit

final class SchemaDecodingTests: XCTestCase {
  func testDecodeSchema() {
    let jsonData = json.data(using: .utf8)!
    
    do {
      _ = try JSONDecoder().decode(TopSchema.self, from: jsonData)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  static var allTests = [
    ("testDecodeSchema", testDecodeSchema),
  ]
}
