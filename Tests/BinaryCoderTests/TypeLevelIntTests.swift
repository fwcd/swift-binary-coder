import XCTest
@testable import BinaryCoder

final class TypeLevelIntTests: XCTestCase {
    func testTypeLevelInt() throws {
        XCTAssertEqual(TypeLevelZero.O.value, 0)
        XCTAssertEqual(TypeLevelZero.I.value, 1)
        XCTAssertEqual(TypeLevelZero.O.O.I.value, 1)
        XCTAssertEqual(TypeLevelZero.I.O.value, 2)
        XCTAssertEqual(TypeLevelZero.I.O.I.value, 5)
        XCTAssertEqual(TypeLevelZero.I.O.O.O.O.O.value, 32)
        XCTAssertEqual(TypeLevelZero.I.I.O.O.O.O.value, 48)
    }
}
