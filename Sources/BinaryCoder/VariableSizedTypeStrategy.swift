/// The strategy used to encode types of non-fixed size (e.g. arrays).
public enum VariableSizedTypeStrategy {
    /// Disables encoding of variable-sized types (i.e. throws an error).
    case none
    /// Allows (at most) a single variable-sized type at the end.
    case untagged
    /// Allows encoding of arbitrary many variable-sized types, this might
    /// however make decoding (with this library) impossible.
    case untaggedAndAmbiguous

    // TODO: Investigate how a tagged strategy could be implemented.
    // E.g. recursive structures could be handled by tagging each
    // struct with a type identifier and arrays with a length. Alternatively,
    // JSON-style beginning/end markers for objects/arrays could be used.
}
