public enum BinaryEncodingError: Error {
    case couldNotEncodeString(String)
    case unsupportedType(Any)
}
