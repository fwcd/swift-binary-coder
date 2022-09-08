import XCTest
@testable import BinaryCoder

final class BinaryEncoderTests: XCTestCase {
    func testDefaultBinaryEncoder() throws {
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

        // Recursive types whose values don't contain a recursive instance at runtime are currently allowed
        // TODO: Figure out how to better deal with optional properties
        XCTAssertEqual(
            Array(try encoder.encode(Mutual.A(b: .init()))),
            []
        )
        XCTAssertEqual(
            Array(try encoder.encode(Recursive(value: 1))),
            [1]
        )

        // Recursive values are not allowed (unless the strategy is .untaggedAndAmbiguous)
        XCTAssertThrowsError(try encoder.encode(Recursive(value: 8, recursive: .init(value: 2)))) { error in
            XCTAssertEqual(error as! BinaryEncodingError, BinaryEncodingError.recursiveTypeDisallowed)
        }
        XCTAssertThrowsError(try encoder.encode(Mutual.A(b: .init(a: .init())))) { error in
            XCTAssertEqual(error as! BinaryEncodingError, BinaryEncodingError.recursiveTypeDisallowed)
        }
    }

    func testUntaggedAmbiguousBinaryEncoder() throws {
        let encoder = BinaryEncoder(config: .init(
            variableSizedTypeStrategy: .untaggedAndAmbiguous
        ))

        XCTAssertEqual(
            Array(try encoder.encode(Mutual.A(b: .init(a: .init(b: .init(value: 4)), value: 2)))),
            [4, 2]
        )
    }
}
