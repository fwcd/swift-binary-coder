/// An array with a statically known length whose length is enforced at runtime.
@propertyWrapper
public struct FixedSizeArray<Count, Value>: Sequence where Count: TypeLevelInt {
    public var values: [Value]

    public var wrappedValue: [Value] {
        get { values }
        set {
            guard newValue.count == Count.value else {
                fatalError("Cannot assign \(newValue) to a fixed-size array with count \(Self.count)")
            }
            values = newValue
        }
    }

    public static var count: Int { Count.value }

    public init(repeating value: Value) {
        values = Array(repeating: value, count: Count.value)
    }

    public init?(_ values: [Value]) {
        guard values.count == Count.value else { return nil }
        self.values = values
    }

    public init(wrappedValue values: [Value]) {
        guard let array = Self(values) else {
            fatalError("Number of values in \(values) did not match the expected count \(Self.count)")
        }
        self = array
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
