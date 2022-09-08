/// A (stateful) binary decoder.
struct BinaryDecoderImpl: Decoder {
    private let state: BinaryDecodingState

    var codingPath: [CodingKey] { [] }
    var userInfo: [CodingUserInfoKey: Any] { [:] }

    init(state: BinaryDecodingState) {
        self.state = state
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        <#code#>
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        <#code#>
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        <#code#>
    }
}
