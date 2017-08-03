import Consoles

extension Console {
    public func run(_ group: Group, arguments: [String]) throws {
        var arguments = arguments
        guard let name = arguments.pop() else {
            throw "insufficient arguments"
        }

        guard let chosen = group.runnable[name] else {
            throw "no thing found for \(name)"
        }

        switch chosen {
        case .command(let command):
            try run(command, arguments: arguments)
        case .group(let group):
            try run(group, arguments: arguments)
        }
    }

    public func run(_ command: Command, arguments: [String]) throws {
        // verify signature
        try command.run(using: self, with: arguments)
    }
}

extension Array where Element == String {
    mutating func pop() -> String? {
        guard count > 0 else {
            return nil
        }
        let pop = self[0]
        self = Array(self[1..<count - 1])
        return pop
    }
}
