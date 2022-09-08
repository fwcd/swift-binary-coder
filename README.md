# Binary Coder for Swift

[![Build](https://github.com/fwcd/swift-binary-coder/actions/workflows/build.yml/badge.svg)](https://github.com/fwcd/swift-binary-coder/actions/workflows/build.yml)
[![Docs](https://github.com/fwcd/swift-binary-coder/actions/workflows/docs.yml/badge.svg)](https://fwcd.github.io/swift-binary-coder/documentation/binarycoder)

A simple `Encoder` and `Decoder` that serializes `Codable` Swift types to a flat, untagged binary representation. Note that this usually requires the structures to have a fixed size.

## Example

```swift
struct Point: Codable {
    let x: UInt16
    let y: UInt16
}

let encoder = BinaryEncoder()
try encoder.encode(Point(x: 2, y: 3))
// -> Data([0, 2, 0, 3])

let decoder = BinaryDecoder()
try decoder.decode(Point.self, from: Data([0, 2, 0, 3]))
// -> Point(x: 2, y: 3)
```
