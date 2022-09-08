/// An error that occurred during binary encoding.
public enum BinaryEncodingError: Error {
    case couldNotEncodeNil
    case couldNotEncodeString(String)
    case unsupportedType(Any)
    case variableSizedTypeDisallowed
    case valueAfterVariableSizedTypeDisallowed
}
