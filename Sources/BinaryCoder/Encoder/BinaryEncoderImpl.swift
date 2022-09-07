/// A (stateful) binary encoder.
struct BinaryEncoderImpl: Encoder {
    private let state: BinaryEncodingState

    var codingPath: [CodingKey] { [] }
    var userInfo: [CodingUserInfoKey: Any] { [:] }

    init(state: BinaryEncodingState) {
        self.state = state
    }

    /// Encodes a value to a flat binary representation.
    func encode<Value>(value: Value) throws where Value: Encodable {
        try value.encode(to: self)
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        .init(KeyedBinaryEncodingContainer(state: state))
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        UnkeyedBinaryEncodingContainer(state: state)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        SingleValueBinaryEncodingContainer(state: state)
    }
}
