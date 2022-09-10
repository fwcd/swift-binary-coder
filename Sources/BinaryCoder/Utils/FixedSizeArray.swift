/// An array with a statically known length whose length is enforced at runtime.
public struct FixedSizeArray<Count, Value>: Sequence where Count: TypeLevelInt {
    public let values: [Value]

    public static var count: Int { Count.value }

    public init(repeating value: Value) {
        values = Array(repeating: value, count: Count.value)
    }

    public init?(_ values: [Value]) {
        guard values.count == Count.value else { return nil }
        self.values = values
    }

    public func makeIterator() -> Array<Value>.Iterator {
        values.makeIterator()
    }
}

extension FixedSizeArray where Value: AdditiveArithmetic {
    public init() {
        self.init(repeating: .zero)
    }
}
