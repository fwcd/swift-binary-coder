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
    let value: Int64
    let recursive: Recursive

    init(value: Int64, recursive: Recursive) {
        self.value = value
        self.recursive = recursive
    }
}
