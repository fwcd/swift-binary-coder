import XCTest
@testable import BinaryCoder

final class BinaryEncoderTests: XCTestCase {
    func testDefaultBinaryEncoder() throws {
        let encoder = BinaryEncoder()

        try assertThat(encoder, encodes: Simple(x: 1, y: 2, z: 3), to: [1, 0, 2, 3])
        try assertThat(encoder, encodes: Composite(
            before: 2,
            inner: .init(value: 120),
            after: 4
        ), to: [0, 0, 0, 2, 120, 0, 0, 0, 0, 0, 0, 0, 4])

        // Recursive types whose values don't contain a recursive instance at runtime are currently allowed
        // TODO: Figure out how to better deal with optional properties
        try assertThat(encoder, encodes: Mutual.A(b: .init()), to: [])
        try assertThat(encoder, encodes: Recursive(value: 1), to: [1])

        // Recursive values are not allowed (unless the strategy is .untaggedAndAmbiguous)
        try assertThat(encoder, whileEncoding: Recursive(value: 8, recursive: .init(value: 2)), throws: .recursiveTypeDisallowed)
        try assertThat(encoder, whileEncoding: Mutual.A(b: .init(a: .init())), throws: .recursiveTypeDisallowed)
    }

    func testUntaggedAmbiguousBinaryEncoder() throws {
        let encoder = BinaryEncoder(config: .init(
            variableSizedTypeStrategy: .untaggedAndAmbiguous
        ))

        try assertThat(encoder, encodes: Mutual.A(b: .init(a: .init(b: .init(value: 4)), value: 2)), to: [4, 2])
    }

    private func assertThat<Value>(
        _ encoder: BinaryEncoder,
        encodes value: Value,
        to expectedArray: [UInt8],
        line: UInt = #line
    ) throws where Value: Encodable {
        XCTAssertEqual(Array(try encoder.encode(value)), expectedArray, line: line)
    }

    private func assertThat<Value>(
        _ encoder: BinaryEncoder,
        whileEncoding value: Value,
        throws expectedError: BinaryEncodingError,
        line: UInt = #line
    ) throws where Value: Encodable {
        XCTAssertThrowsError(try encoder.encode(value), line: line) { error in
            XCTAssertEqual(error as! BinaryEncodingError, expectedError, line: line)
        }
    }
}
