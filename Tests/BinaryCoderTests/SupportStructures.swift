struct Simple: Codable {
    let x: UInt8
    let y: UInt16
    let z: Int8
}

struct Composite: Codable {
    let before: Int32
    let inner: Inner
    let after: Int64

    struct Inner: Codable {
        let value: Int8
    }
}

class Recursive: Codable {
    let value: UInt8
    let recursive: Recursive?

    init(value: UInt8, recursive: Recursive? = nil) {
        self.value = value
        self.recursive = recursive
    }
}

enum Mutual {
    class A: Codable {
        let b: B?

        init(b: B? = nil) {
            self.b = b
        }
    }

    class B: Codable {
        let a: A?
        let value: UInt8?

        init(a: A? = nil, value: UInt8? = nil) {
            self.a = a
            self.value = value
        }
    }
}

struct VariablePrefix: Codable {
    let prefix: [UInt8]
    let value: UInt8
}

struct VariableSuffix: Codable {
    let value: UInt8
    let suffix: [UInt8]
}

struct Generic<Value>: Codable where Value: Codable {
    let value: Value
    let additional: UInt8
}
