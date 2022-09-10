import XCTest
@testable import BinaryCoder

final class FixedLengthArrayTests: XCTestCase {
    func testFixedLengthArray() throws {
        XCTAssertEqual(FixedLengthArray<Int, TypeLevelZero>().values, [])
        XCTAssertEqual(FixedLengthArray<Int, TypeLevelZero.I>().values, [0])
        XCTAssertEqual(FixedLengthArray<Int, TypeLevelZero.I.O.I>(repeating: 2).values, [2, 2, 2, 2, 2])
        XCTAssertEqual(Array(FixedLengthArray<Int, TypeLevelZero.I.O.I>([1, 2, 3, 4, 5])!), [1, 2, 3, 4, 5])
        XCTAssertNil(FixedLengthArray<Int, TypeLevelZero.I.O.I>([1, 2, 3]))
    }
}
