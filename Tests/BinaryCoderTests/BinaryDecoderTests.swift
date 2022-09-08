import XCTest
@testable import BinaryCoder

final class BinaryDecoderTests: XCTestCase {
    func testDefaultBinaryDecoder() throws {
        let decoder = BinaryDecoder()

        try assertThat(decoder, decodes: [4], to: UInt8(4))
        try assertThat(decoder, decodes: [0, 4], to: UInt16(4))
        try assertThat(decoder, decodes: [0, 0, 0, 4], to: UInt32(4))
        try assertThat(decoder, decodes: [0, 0, 0, 0, 0, 0, 0, 4], to: UInt64(4))
        try assertThat(decoder, decodes: [255], to: Int8(-1))
        try assertThat(decoder, decodes: [4], to: Int8(4))
        try assertThat(decoder, decodes: [0, 4], to: Int16(4))
        try assertThat(decoder, decodes: [0, 0, 0, 4], to: Int32(4))
        try assertThat(decoder, decodes: [0, 0, 0, 0, 0, 0, 0, 4], to: Int64(4))

        try assertThat(decoder, decodes: [1, 0, 2, 3], to: Simple(x: 1, y: 2, z: 3))
        try assertThat(decoder, decodes: [0, 0, 0, 2, 120, 0, 0, 0, 0, 0, 0, 0, 4], to: Composite(
            before: 2,
            inner: .init(value: 120),
            after: 4
        ))

        try assertThat(decoder, decodes: [1, 9, 7], to: VariableSuffix(value: 1, suffix: [9, 7]))
        try assertThat(decoder, decodes: [9, 0, 3, 3, 20], to: Generic(value: Simple(x: 9, y: 3, z: 3), additional: 20))
        try assertThat(decoder, decodes: [97, 98, 99, 0], to: "abc")
        try assertThat(decoder, decodes: [97, 98, 99, 0, 3], to: Generic(value: "abc", additional: 3))
    }

    private func assertThat<Value>(
        _ decoder: BinaryDecoder,
        decodes array: [UInt8],
        to expectedValue: Value,
        line: UInt = #line
    ) throws where Value: Decodable & Equatable {
        XCTAssertEqual(try decoder.decode(Value.self, from: Data(array)), expectedValue, line: line)
    }

    private func assertThat<Value>(
        _ decoder: BinaryDecoder,
        whileDecoding type: Value.Type,
        from array: [UInt8],
        throws expectedError: BinaryDecodingError,
        line: UInt = #line
    ) throws where Value: Decodable {
        XCTAssertThrowsError(try decoder.decode(Value.self, from: Data(array)), line: line) { error in
            XCTAssertEqual(error as! BinaryDecodingError, expectedError, line: line)
        }
    }
}
