import XCTest
@testable import SequenceTools

class SequenceToolsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SequenceTools().text, "Hello, World!")
    }


    static var allTests : [(String, (SequenceToolsTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
