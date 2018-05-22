import XCTest
@testable import Tank

class raspberryTankTests: XCTestCase {
    func testMotorsAreCreated() {
        XCTAssertNotNil(Tank().left)
        XCTAssertNotNil(Tank().left)
    }


    static var allTests = [
        ("testMotorsAreCreated", testMotorsAreCreated),
    ]
}
