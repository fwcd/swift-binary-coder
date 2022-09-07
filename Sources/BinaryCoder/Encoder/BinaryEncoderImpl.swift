/// A (stateful) binary encoder.
public struct BinaryEncoderImpl: Encoder {
    private let state: BinaryEncodingState

    public var codingPath: [CodingKey] { [] }
    public var userInfo: [CodingUserInfoKey: Any] { [:] }

    init(state: BinaryEncodingState) {
        self.state = state
    }

    /// Encodes a value to a flat binary representation.
    public func encode<Value>(value: Value) throws where Value: Encodable {
        try value.encode(to: self)
    }

    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        .init(KeyedBinaryEncodingContainer(state: state))
    }

    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        UnkeyedBinaryEncodingContainer(state: state)
    }

    public func singleValueContainer() -> SingleValueEncodingContainer {
        SingleValueBinaryEncodingContainer(state: state)
    }
}
