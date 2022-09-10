/// An array with a statically known length whose length is enforced at runtime.
public struct FixedLengthArray<Value, Length>: Sequence where Length: TypeLevelInt {
    let values: [Value]

    var count: Int { values.count }

    public init(repeating value: Value) {
        values = Array(repeating: value, count: Length.value)
    }

    public init?(_ values: [Value]) {
        guard values.count == Length.value else { return nil }
        self.values = values
    }

    public func makeIterator() -> Array<Value>.Iterator {
        values.makeIterator()
    }
}

extension FixedLengthArray where Value: AdditiveArithmetic {
    public init() {
        self.init(repeating: .zero)
    }
}
