/// A configuration for the binary encoder/decoder.
public struct BinaryCodingConfiguration {
    /// The endianness to use for fixed-width integers.
    let endianness: Endianness
    /// The encoding to use for strings.
    let stringEncoding: String.Encoding
    /// Whether to add a NUL byte to encoded strings. This makes them exempt
    /// from the variable length rules since they are properly delimited.
    let nullTerminateStrings: Bool

    public init(
        endianness: Endianness = .bigEndian,
        stringEncoding: String.Encoding = .utf8,
        nullTerminateStrings: Bool = true
    ) {
        self.endianness = endianness
        self.stringEncoding = stringEncoding
        self.nullTerminateStrings = nullTerminateStrings
    }
}
