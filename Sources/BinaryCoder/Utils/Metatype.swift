enum Metatype: Hashable {
    case base(String)
    case apply(String, [Self])

    init?(parsing raw: String) {
        var raw = raw[...]
        guard let metatype = parseMetatype(&raw), raw.isEmpty else {
            return nil
        }
        self = metatype
    }

    init?(_ type: Any.Type) {
        self.init(parsing: String(describing: type))
    }
}

extension Metatype: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self = .base(value)
    }
}

private func parseMetatype(_ raw: inout Substring) -> Metatype? {
    let base = parseIdentifier(&raw)
    if parseOpening(&raw) {
        var childs: [Metatype] = []
        while let child = parseMetatype(&raw) {
            childs.append(child)
            if !parseComma(&raw) {
                break
            }
        }
        parseClosing(&raw)
        return .apply(base, childs)
    } else {
        return .base(base)
    }
}

private func parseIdentifier(_ raw: inout Substring) -> String {
    let value = raw.prefix { $0 != "<" && $0 != ">" && $0 != "," }
    raw = raw[value.endIndex...]
    return String(value)
}

@discardableResult
private func parseOpening(_ raw: inout Substring) -> Bool {
    parseToken("<", &raw)
}

@discardableResult
private func parseClosing(_ raw: inout Substring) -> Bool {
    parseToken(">", &raw)
}

@discardableResult
private func parseComma(_ raw: inout Substring) -> Bool {
    parseToken(",", &raw)
}

private func parseToken(_ token: Character, _ raw: inout Substring) -> Bool {
    guard raw.first == token else { return false }
    repeat {
        raw = raw.dropFirst()
    } while raw.first?.isWhitespace ?? false
    return true
}
