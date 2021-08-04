import XCTest
import class Foundation.Bundle

final class ssgTests: XCTestCase {

    // verifies that we can compile the template output and extract the api keys
    func testProjectKeys() throws {

        XCTAssertEqual(ProjectKeys.key1.value, "value1 from file")
        XCTAssertEqual(ProjectKeys.key2.value, "value2 from file")
        XCTAssertEqual(ProjectKeys.key3.value, "this is from the environment")
    }
}
