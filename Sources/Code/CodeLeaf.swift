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
