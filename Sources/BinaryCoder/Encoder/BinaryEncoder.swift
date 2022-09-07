import Foundation

public struct BinaryEncoder: Encoder {
    private let state: BinaryEncodingState

    public var codingPath: [CodingKey] { [] }
    public var userInfo: [CodingUserInfoKey: Any] { [:] }

    init(state: BinaryEncodingState) {
        self.state = state
    }

    init(
        endianness: Endianness = .bigEndian,
        stringEncoding: String.Encoding = .utf8
    ) {
        self.init(state: .init(endianness: endianness, stringEncoding: stringEncoding))
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
