import Foundation

/// The internal state used by the encoders.
class BinaryEncodingState {
    private let config: BinaryCodingConfiguration
    private(set) var data: Data = Data()

    /// Whether the encoder has already encountered a variable-sized type.
    /// Depending on the strategy, types after variable-sized types may be
    /// disallowed.
    private var hasVariableSizedType: Bool = false
    /// The current coding path on the type level. Used to detect cycles
    /// (i.e. recursive or mutually recursive types), which are essentially
    /// recursive types.
    private var codingTypePath: [String] = []

    init(config: BinaryCodingConfiguration, data: Data = .init()) {
        self.config = config
        self.data = data
    }

    func encodeNil() throws {
        throw BinaryEncodingError.couldNotEncodeNil
    }

    func encodeInteger<Integer>(_ value: Integer) throws where Integer: FixedWidthInteger {
        try ensureNotAfterVariableSizedType()
        withUnsafeBytes(of: config.endianness.apply(value)) {
            data += $0
        }
    }

    func encode(_ value: String) throws {
        try ensureNotAfterVariableSizedType()
        try ensureVariableSizedTypeAllowed()

        guard let encoded = value.data(using: .utf8) else {
            throw BinaryEncodingError.couldNotEncodeString(value)
        }

        data += encoded
        if config.nullTerminateStrings {
            data.append(0)
        }

        hasVariableSizedType = true
    }

    func encode(_ value: Bool) throws {
        try encodeInteger(value ? 1 as UInt8 : 0)
    }

    func encode(_ value: Double) throws {
        try encodeInteger(value.bitPattern)
    }

    func encode(_ value: Float) throws {
        try encodeInteger(value.bitPattern)
    }

    func encode(_ value: Int) throws {
        try encodeInteger(value)
    }

    func encode(_ value: Int8) throws {
        try encodeInteger(value)
    }

    func encode(_ value: Int16) throws {
        try encodeInteger(value)
    }

    func encode(_ value: Int32) throws {
        try encodeInteger(value)
    }

    func encode(_ value: Int64) throws {
        try encodeInteger(value)
    }

    func encode(_ value: UInt) throws {
        try encodeInteger(value)
    }

    func encode(_ value: UInt8) throws {
        try encodeInteger(value)
    }

    func encode(_ value: UInt16) throws {
        try encodeInteger(value)
    }

    func encode(_ value: UInt32) throws {
        try encodeInteger(value)
    }

    func encode(_ value: UInt64) throws {
        try encodeInteger(value)
    }

    func encode<T>(_ value: T) throws where T: Encodable {
        try ensureNotAfterVariableSizedType()

        let isVariableSizedType = value is [Any] || value is Data
        if isVariableSizedType {
            try ensureVariableSizedTypeAllowed()
        }

        switch value {
        case let data as Data:
            self.data += data
        default:
            try withCodingTypePath(appending: [String(describing: type(of: value))]) {
                try value.encode(to: BinaryEncoderImpl(state: self))
            }
        }

        if isVariableSizedType {
            hasVariableSizedType = true
        }
    }

    private func withCodingTypePath(appending delta: [String], action: () throws -> Void) throws {
        codingTypePath += delta
        try ensureNonRecursiveCodingTypePath()
        try action()
        codingTypePath.removeLast(delta.count)
    }

    private func ensureVariableSizedTypeAllowed() throws {
        let strategy = config.variableSizedTypeStrategy
        guard strategy.allowsSingleVariableSizedType else {
            throw BinaryEncodingError.variableSizedTypeDisallowed
        }
    }

    private func ensureNotAfterVariableSizedType() throws {
        let strategy = config.variableSizedTypeStrategy
        guard strategy.allowsValuesAfterVariableSizedTypes
          || (strategy.allowsSingleVariableSizedType && !hasVariableSizedType) else {
            throw BinaryEncodingError.valueAfterVariableSizedTypeDisallowed
        }
    }

    private func ensureNonRecursiveCodingTypePath() throws {
        let strategy = config.variableSizedTypeStrategy
        guard strategy.allowsRecursiveTypes || Set(codingTypePath).count == codingTypePath.count else {
            throw BinaryEncodingError.recursiveTypeDisallowed
        }
    }

    func ensureOptionalAllowed() throws {
        let strategy = config.variableSizedTypeStrategy
        guard strategy.allowsOptionalTypes else {
            throw BinaryEncodingError.optionalTypeDisallowed
        }
    }
}
