import XCTest
@testable import BinaryCoder

final class BinaryEncoderTests: XCTestCase {
    func testBinaryEncoder() throws {
        let encoder = BinaryEncoder()
        XCTAssertEqual(
            Array(try encoder.encode(Simple(x: 1, y: 2, z: 3))),
            [1, 0, 2, 3]
        )
        XCTAssertEqual(
            Array(try encoder.encode(Composite(
                before: 2,
                inner: .init(value: 120),
                after: 4
            ))),
            [0, 0, 0, 2, 120, 0, 0, 0, 0, 0, 0, 0, 4]
        )

        XCTAssertThrowsError(try encoder.encode(Mutual.A(b: .init(a: .init())))) { error in
            XCTAssertEqual(error as! BinaryEncodingError, BinaryEncodingError.recursiveTypeDisallowed)
        }
        XCTAssertEqual(
            Array(try encoder.encode(Mutual.A(b: .init()))),
            []
        )
    }
}
