/// A (stateful) binary encoder.
struct BinaryEncoderImpl: Encoder {
    private let state: BinaryEncodingState

    var codingPath: [CodingKey] { [] }
    var userInfo: [CodingUserInfoKey: Any] { [:] }

    init(state: BinaryEncodingState) {
        self.state = state
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
