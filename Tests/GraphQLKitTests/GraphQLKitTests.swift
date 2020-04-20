import XCTest
@testable import GraphQLKit

final class GraphQLKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GraphQLKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
