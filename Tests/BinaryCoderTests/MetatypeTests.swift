import XCTest
@testable import BinaryCoder

final class MetatypeTests: XCTestCase {
    func testMetatype() throws {
        XCTAssertEqual(Metatype(Int.self), .base("Swift.Int"))
        XCTAssertEqual(Metatype(Simple.self), .base("BinaryCoderTests.Simple"))
        XCTAssertEqual(Metatype(Generic<String>.self), .apply("BinaryCoderTests.Generic", ["Swift.String"]))
        XCTAssertEqual(Metatype(parsing: "Either<Left, Right>"), .apply("Either", ["Left", "Right"]))
    }
}
