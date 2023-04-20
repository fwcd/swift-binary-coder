/// A (stateful) binary decoder.
struct BinaryDecoderImpl: Decoder {
    private let state: BinaryDecodingState

    let codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any] { [:] }

    init(state: BinaryDecodingState, codingPath: [CodingKey]) {
        self.state = state
        self.codingPath = codingPath
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        .init(KeyedBinaryDecodingContainer(state: state, codingPath: codingPath))
    }

    func unkeyedContainer() throws -> any UnkeyedDecodingContainer {
        UnkeyedBinaryDecodingContainer(state: state, codingPath: codingPath)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        SingleValueBinaryDecodingContainer(state: state, codingPath: codingPath)
    }
}
