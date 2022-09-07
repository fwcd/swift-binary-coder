# Binary Coder for Swift

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
```
