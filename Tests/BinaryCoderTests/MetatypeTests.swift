import XCTest
@testable import BinaryCoder

final class MetatypeTests: XCTestCase {
    func testMetatype() throws {
        XCTAssertEqual(Metatype(Int.self), .base("Int"))
        XCTAssertEqual(Metatype(Simple.self), .base("Simple"))
        XCTAssertEqual(Metatype(Generic<String>.self), .apply("Generic", ["String"]))
        XCTAssertEqual(Metatype(parsing: "Either<Left, Right>"), .apply("Either", ["Left", "Right"]))
    }
}
