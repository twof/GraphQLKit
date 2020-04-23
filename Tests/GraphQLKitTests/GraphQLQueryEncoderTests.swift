import XCTest
import GraphQLKit

protocol GraphQLQueryable {
    static var key: String { get }
}

protocol GraphQLQueryableField { }

protocol GraphQLField: Codable {
    associatedtype QueryField: GraphQLQueryableField
}

final class GraphQLQueryEncoderTests: XCTestCase {
  func testEncodeQuery() {
    enum API {
        struct LaunchConnection: GraphQLQueryable, GraphQLQueryableField {
            static let key = "launches"
            typealias Cursor = String
            typealias HasMore = Bool
            typealias Launches = [Launch]
        }
        
        struct Launch: GraphQLQueryable, GraphQLQueryableField {
            static let key = "launch"
            typealias ID = String
            typealias Site = String?
            typealias Mission = API.Mission?
            typealias Rocket = API.Rocket?
            typealias IsBooked = Bool
        }
        
        struct Mission: GraphQLQueryableField {
            
        }
        
        struct Rocket: GraphQLQueryableField {
            
        }
    }

    struct LaunchListQuery: Codable {
        struct LaunchConnection: GraphQLField {
            struct Launch: GraphQLField {
                typealias QueryField = API.Launch
                let id: QueryField.ID
                let site: QueryField.Site
            }
            typealias QueryField = API.LaunchConnection
            let cursor: QueryField.Cursor
            let hasMore: QueryField.HasMore
            let launches: [Launch]
        }
        
        let launches: LaunchConnection
        let launchTimes: [Double]
    }

    let fakeLauchListQuery = LaunchListQuery(
        launches: LaunchListQuery.LaunchConnection(
            cursor: "",
            hasMore: true,
            launches: [
                LaunchListQuery.LaunchConnection.Launch(id: "", site: "")
            ]
        ),
        launchTimes: [1, 2, 3]
    )

    let encoder = GraphQLQueryEncoder()
    print(try! encoder.encode(fakeLauchListQuery))

  }
  
  static var allTests = [
    ("testEncodeQuery", testEncodeQuery),
  ]
}
