/// An error that occurred during binary encoding.
public enum BinaryEncodingError: Error, Hashable {
    case couldNotEncodeNil
    case couldNotEncodeString(String)
    case unsupportedType(String)
    case variableSizedTypeDisallowed
    case recursiveTypeDisallowed
    case optionalTypeDisallowed
    case valueAfterVariableSizedTypeDisallowed
}
