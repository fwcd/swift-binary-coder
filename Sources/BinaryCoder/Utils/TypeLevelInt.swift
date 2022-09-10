/// A type-level integer literal to work around Swift's lack of const generics.
public protocol TypeLevelInt {
    static var value: Int { get }
}

public struct TypeLevelZero: TypeLevelInt {
    public static var value: Int {
        0
    }
}

public struct TypeLevelOneBit<Tail>: TypeLevelInt where Tail: TypeLevelInt {
    public static var value: Int {
        (Tail.value << 1) | 1
    }
}

public struct TypeLevelZeroBit<Tail>: TypeLevelInt where Tail: TypeLevelInt {
    public static var value: Int {
        (Tail.value << 1) | 0
    }
}

extension TypeLevelInt {
    typealias I = TypeLevelOneBit<Self>;
    typealias O = TypeLevelZeroBit<Self>;
}
