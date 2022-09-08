import Foundation

/// A decoder that decodes Swift structures from a flat binary representation.
public struct BinaryDecoder {
    private let config: BinaryCodingConfiguration

    public init(config: BinaryCodingConfiguration = .init()) {
        self.config = config
    }

    /// Decodes a value from a flat binary representation.
    public func decode<Value>(_ type: Value.Type, from data: Data) throws -> Value where Value: Decodable {
        let state = BinaryDecodingState(config: config, data: data)
        return try Value(from: BinaryDecoderImpl(state: state, codingPath: []))
    }
}
