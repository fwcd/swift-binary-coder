import XCTest
@testable import BinaryCoder

final class FixedSizeArrayTests: XCTestCase {
    func testFixedSizeArray() throws {
        XCTAssertEqual(FixedSizeArray<TypeLevelZero, Int>().values, [])
        XCTAssertEqual(FixedSizeArray<TypeLevelZero.I, Int>().values, [0])
        XCTAssertEqual(FixedSizeArray<TypeLevelZero.I.O.I, Int>(repeating: 2).values, [2, 2, 2, 2, 2])
        XCTAssertEqual(Array(FixedSizeArray<TypeLevelZero.I.O.I, Int>([1, 2, 3, 4, 5])!), [1, 2, 3, 4, 5])
        XCTAssertNil(FixedSizeArray<TypeLevelZero.I.O.I, Int>([1, 2, 3]))

        @FixedSizeArray<TypeLevelZero.I.O.O, Int> var wrapped = [1, 2, 3, 4]
        wrapped = [0, 0, 1, 3]
        XCTAssertEqual(wrapped, [0, 0, 1, 3])
    }
}
