import XCTest
@testable import BinaryCoder

final class BinaryEncoderTests: XCTestCase {
    struct X: Encodable {
        let x: UInt8
        let y: UInt16
        let z: Int8
    }

    func testBinaryEncoder() throws {
        let encoder = BinaryEncoder()
        XCTAssertEqual(
            Array(try encoder.encode(X(x: 1, y: 2, z: 3))),
            [1, 0, 2, 3]
        )
    }
}
