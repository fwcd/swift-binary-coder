/// A configuration for the binary encoder/decoder.
public struct BinaryCodingConfiguration {
    let endianness: Endianness
    let stringEncoding: String.Encoding

    public init(
        endianness: Endianness = .bigEndian,
        stringEncoding: String.Encoding = .utf8
    ) {
        self.endianness = endianness
        self.stringEncoding = stringEncoding
    }
}
