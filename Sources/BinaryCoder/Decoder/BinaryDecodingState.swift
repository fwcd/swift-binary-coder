import Foundation

/// The internal state used by the decoders.
class BinaryDecodingState {
    private let config: BinaryCodingConfiguration
    private let data: Data

    init(config: BinaryCodingConfiguration, data: Data) {
        self.config = config
        self.data = data
    }
}
