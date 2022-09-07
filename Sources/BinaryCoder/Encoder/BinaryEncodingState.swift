import Foundation

/// The internal state used by the encoders.
class BinaryEncodingState {
    private let config: BinaryCodingConfiguration
    private(set) var data: Data = Data()

    init(config: BinaryCodingConfiguration, data: Data = .init()) {
        self.config = config
        self.data = data
    }

    func encodeNil() throws {
        // Skip nils
    }

    func encodeInteger<Integer>(_ value: Integer) where Integer: FixedWidthInteger {
        withUnsafeBytes(of: config.endianness.apply(value)) { data += $0 }
    }

    func encode(_ value: Bool) throws {
        encodeInteger(value ? 1 as UInt8 : 0)
    }

    func encode(_ value: String) throws {
        guard let encoded = value.data(using: .utf8) else {
            throw BinaryEncodingError.couldNotEncodeString(value)
        }
        data += encoded
    }

    func encode(_ value: Double) throws {
        encodeInteger(value.bitPattern)
    }

    func encode(_ value: Float) throws {
        encodeInteger(value.bitPattern)
    }

    func encode(_ value: Int) throws {
        encodeInteger(value)
    }

    func encode(_ value: Int8) throws {
        encodeInteger(value)
    }

    func encode(_ value: Int16) throws {
        encodeInteger(value)
    }

    func encode(_ value: Int32) throws {
        encodeInteger(value)
    }

    func encode(_ value: Int64) throws {
        encodeInteger(value)
    }

    func encode(_ value: UInt) throws {
        encodeInteger(value)
    }

    func encode(_ value: UInt8) throws {
        encodeInteger(value)
    }

    func encode(_ value: UInt16) throws {
        encodeInteger(value)
    }

    func encode(_ value: UInt32) throws {
        encodeInteger(value)
    }

    func encode(_ value: UInt64) throws {
        encodeInteger(value)
    }

    func encode<T>(_ value: T) throws where T: Encodable {
        throw BinaryEncodingError.unsupportedType(value)
    }
}
