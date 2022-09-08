import Foundation

/// The internal state used by the encoders.
class BinaryEncodingState {
    private let config: BinaryCodingConfiguration
    private(set) var data: Data = Data()
    private var hasVariableSizedType: Bool = false

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
        try beginVariableSizedType()
        guard let encoded = value.data(using: .utf8) else {
            throw BinaryEncodingError.couldNotEncodeString(value)
        }
        data += encoded
        if config.nullTerminateStrings {
            data.append(0)
        }
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
        switch value {
        case let data as Data:
            try beginVariableSizedType()
            self.data += data
        default:
            if value is [Any] {
                try beginVariableSizedType()
            }
            try value.encode(to: BinaryEncoderImpl(state: self))
        }
    }

    private func beginVariableSizedType() throws {
        let strategy = config.variableSizedTypeStrategy
        guard strategy != .none else {
            throw BinaryEncodingError.variableSizedTypeDisallowed
        }
        hasVariableSizedType = true
    }

    private func ensureNotAfterVariableSizedType() throws {
        let strategy = config.variableSizedTypeStrategy
        guard strategy == .untaggedAndAmbiguous || (strategy == .untagged && !hasVariableSizedType) else {
            throw BinaryEncodingError.valueAfterVariableSizedTypeDisallowed
        }
    }
}
