// MARK: Leaf

import Leaf

extension Enum: Leaf.DataRepresentable {
    public func makeLeafData() throws -> Data {
        return .dictionary([
            "name": .string(name),
            "kind": .string("enum")
        ])
    }
}

extension Struct: Leaf.DataRepresentable {
    public func makeLeafData() throws -> Data {
        return .dictionary([
            "name": .string(name),
            "kind": .string("struct")
        ])
    }
}

extension Class: Leaf.DataRepresentable {
    public func makeLeafData() throws -> Data {
        return try .dictionary([
            "name": .string(name),
            "kind": .string("class"),
            "inheritedTypes": .array(inheritedTypes.map { .string($0) }),
            "properties": .array(properties.map { try $0.makeLeafData() }),
            "comment": comment?.makeLeafData() ?? .null
        ])
    }
}

extension Property: Leaf.DataRepresentable {
    public func makeLeafData() throws -> Data {
        return try .dictionary([
            "name": .string(name),
            "typeName": .string(typeName),
            "isInstance": .bool(isInstance),
            "comment": comment?.makeLeafData() ?? .null
        ])
    }
}

extension Type: Leaf.DataRepresentable {
    public func makeLeafData() throws -> Data {
        switch self {
        case .`class`(let `class`):
            return try `class`.makeLeafData()
        case .`struct`(let `struct`):
            return try `struct`.makeLeafData()
        case .`enum`(let `enum`):
            return try `enum`.makeLeafData()
        }
    }
}

extension Comment: Leaf.DataRepresentable {
    public func makeLeafData() throws -> Data {
        return .dictionary([
            "lines": .array(lines.map { .string($0) }),
            "attributes": .dictionary(attributes.mapValues { .string($0) })
        ])
    }
}


public final class Contains: Leaf.Tag {
    public func render(parameters: [Data], context: inout Data, body: [Syntax]?, renderer: Renderer) throws -> Data? {
        guard parameters.count == 2 else {
            throw "invalid param count"
        }

        guard let array = parameters[0].array else {
            return .bool(false)
        }
        let compare = parameters[1]

        return .bool(array.contains(compare))
    }
}

public final class Lowercase: Leaf.Tag {
    public func render(parameters: [Data], context: inout Data, body: [Syntax]?, renderer: Renderer) throws -> Data? {
        guard parameters.count == 1 else {
            throw "invalid param count"
        }

        return .string(parameters[0].string?.lowercased() ?? "")
    }
}

extension Data: Equatable {
    public static func ==(lhs: Data, rhs: Data) -> Bool {
        switch (lhs, rhs) {
        case (.array(let a), .array(let b)):
            guard a.count == b.count else {
                return false
            }
            for i in 0..<a.count {
                if a[i] != b[i] {
                    return false
                }
            }
            return true
        default:
            return lhs.string == rhs.string
        }
    }
}
