public struct Method {
    public var name: String
    public var isInstance: Bool

    init(name: String, isInstance: Bool) {
        self.name = name
        self.isInstance = isInstance
    }
}
