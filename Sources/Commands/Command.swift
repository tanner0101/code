import Consoles

public protocol Command {
    var signature: [Signature] { get }
    func run(using console: Console, with arguments: [String]) throws
}
