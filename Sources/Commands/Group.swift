import Consoles

public typealias ConsoleClosure = (Console) throws -> ()

public struct Group {
    public var runnable: [String: Runnable]
    public var options: [String: ConsoleClosure]

    public init(_ runnable: [String: Runnable], options: [String: ConsoleClosure] = [:]) {
        self.runnable = runnable
        self.options = options
    }
}
