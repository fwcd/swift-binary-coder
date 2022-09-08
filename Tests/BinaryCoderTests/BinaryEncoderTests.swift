import XCTest
@testable import BinaryCoder

final class BinaryEncoderTests: XCTestCase {
    func testDefaultBinaryEncoder() throws {
        let encoder = BinaryEncoder()

        try assertThat(encoder, encodes: UInt8(4), to: [4])
        try assertThat(encoder, encodes: UInt16(4), to: [0, 4])
        try assertThat(encoder, encodes: UInt32(4), to: [0, 0, 0, 4])
        try assertThat(encoder, encodes: UInt64(4), to: [0, 0, 0, 0, 0, 0, 0, 4])
        try assertThat(encoder, encodes: Int8(-1), to: [255])
        try assertThat(encoder, encodes: Int8(4), to: [4])
        try assertThat(encoder, encodes: Int16(4), to: [0, 4])
        try assertThat(encoder, encodes: Int32(4), to: [0, 0, 0, 4])
        try assertThat(encoder, encodes: Int64(4), to: [0, 0, 0, 0, 0, 0, 0, 4])

        try assertThat(encoder, encodes: Simple(x: 1, y: 2, z: 3), to: [1, 0, 2, 3])
        try assertThat(encoder, encodes: Composite(
            before: 2,
            inner: .init(value: 120),
            after: 4
        ), to: [0, 0, 0, 2, 120, 0, 0, 0, 0, 0, 0, 0, 4])

        try assertThat(encoder, whileEncoding: VariablePrefix(prefix: [1, 2], value: 2), throws: .valueAfterVariableSizedTypeDisallowed)
        try assertThat(encoder, encodes: VariableSuffix(value: 1, suffix: [9, 7]), to: [1, 9, 7])
        try assertThat(encoder, encodes: Generic(value: Simple(x: 9, y: 3, z: 3), additional: 20), to: [9, 0, 3, 3, 20])
        try assertThat(encoder, encodes: "abc", to: [97, 98, 99, 0])
        try assertThat(encoder, encodes: Generic(value: "abc", additional: 3), to: [97, 98, 99, 0, 3])

        try assertThat(encoder, whileEncoding: Mutual.A(b: .init()), throws: .optionalTypeDisallowed)
        try assertThat(encoder, whileEncoding: Recursive(value: 1), throws: .optionalTypeDisallowed)
        try assertThat(encoder, whileEncoding: Recursive(value: 8, recursive: .init(value: 2)), throws: .optionalTypeDisallowed)
        try assertThat(encoder, whileEncoding: Mutual.A(b: .init(a: .init())), throws: .optionalTypeDisallowed)

        // TODO: Since the synthesized Encodable implementation for enums is externally tagged by key,
        //       we currently get the same result in both cases. For non-.untaggedAndAmbiguous strategies
        //       should we throw an error, even though there may be a runtime cost to detect whether a
        //       type is an enum (e.g. through reflection)?
        try assertThat(encoder, encodes: Either<Int, Int>.left(3), to: [0, 0, 0, 0, 0, 0, 0, 3])
        try assertThat(encoder, encodes: Either<Int, Int>.right(3), to: [0, 0, 0, 0, 0, 0, 0, 3])
    }

    func testUntaggedAmbiguousBinaryEncoder() throws {
        let encoder = BinaryEncoder(config: .init(
            variableSizedTypeStrategy: .untaggedAndAmbiguous
        ))

        try assertThat(encoder, encodes: Recursive(value: 1), to: [1])
        try assertThat(encoder, encodes: Recursive(value: 3, recursive: .init(value: 4)), to: [3, 4])
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
