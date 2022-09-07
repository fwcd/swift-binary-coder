/// An error that occurred during binary encoding.
public enum BinaryEncodingError: Error {
    case couldNotEncodeString(String)
    case unsupportedType(Any)
}
