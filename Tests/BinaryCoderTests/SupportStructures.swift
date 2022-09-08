struct Simple: Codable, Hashable {
    let x: UInt8
    let y: UInt16
    let z: Int8
}

struct Composite: Codable, Hashable {
    let before: Int32
    let inner: Inner
    let after: Int64

    struct Inner: Codable, Hashable {
        let value: Int8
    }
}

final class Recursive: Codable, Equatable {
    let value: UInt8
    let recursive: Recursive?

    init(value: UInt8, recursive: Recursive? = nil) {
        self.value = value
        self.recursive = recursive
    }

    static func ==(lhs: Recursive, rhs: Recursive) -> Bool {
        lhs.value == rhs.value && lhs.recursive == rhs.recursive
    }
}

enum Mutual {
    final class A: Codable, Equatable {
        let b: B?

        init(b: B? = nil) {
            self.b = b
        }

        static func ==(lhs: A, rhs: A) -> Bool {
            lhs.b == rhs.b
        }
    }

    final class B: Codable, Equatable {
        let a: A?
        let value: UInt8?

        init(a: A? = nil, value: UInt8? = nil) {
            self.a = a
            self.value = value
        }

        static func ==(lhs: B, rhs: B) -> Bool {
            lhs.a == rhs.a && lhs.value == rhs.value
        }
    }
}

struct VariablePrefix: Codable, Hashable {
    let prefix: [UInt8]
    let value: UInt8
}

struct VariableSuffix: Codable, Hashable {
    let value: UInt8
    let suffix: [UInt8]
}

struct Generic<Value> {
    let value: Value
    let additional: UInt8
}

extension Generic: Equatable where Value: Equatable {}
extension Generic: Hashable where Value: Hashable {}
extension Generic: Encodable where Value: Encodable {}
extension Generic: Decodable where Value: Decodable {}

enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

extension Either: Equatable where Left: Equatable, Right: Equatable {}
extension Either: Hashable where Left: Hashable, Right: Hashable {}
extension Either: Encodable where Left: Encodable, Right: Encodable {}
extension Either: Decodable where Left: Decodable, Right: Decodable {}
