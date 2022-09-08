struct KeyedBinaryDecodingContainer<Key>: KeyedDecodingContainerProtocol where Key: CodingKey {
    var codingPath: [CodingKey]
    var allKeys: [Key]

    func contains(_ key: Key) -> Bool {
        <#code#>
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        <#code#>
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        <#code#>
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        <#code#>
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        <#code#>
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        <#code#>
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        <#code#>
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        <#code#>
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        <#code#>
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        <#code#>
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        <#code#>
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        <#code#>
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        <#code#>
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        <#code#>
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        <#code#>
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        <#code#>
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        <#code#>
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        <#code#>
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        <#code#>
    }

    func superDecoder() throws -> Decoder {
        <#code#>
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        <#code#>
    }
}
