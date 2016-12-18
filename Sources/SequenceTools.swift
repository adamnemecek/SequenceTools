

extension Sequence {
    public func scan<T>(_ initial: T, _ combine: (T, Iterator.Element) throws -> T) rethrows -> [T] {
        var accu = initial
        return try map {
            accu = try combine(accu, $0)
            return accu
        }
    }
}

extension Sequence {
    public func any(predicate: (Iterator.Element) -> Bool) -> Bool {
        for e in self where predicate(e) {
            return true
        }
        return false
    }

    public func all(predicate: (Iterator.Element) -> Bool) -> Bool {
        for e in self where !predicate(e) {
            return false
        }
        return true
    }

    public func none(predicate: (Iterator.Element) -> Bool) -> Bool {
        for e in self where predicate(e) {
            return false
        }
        return true
    }
}

extension RangeReplaceableCollection where Iterator.Element: ExpressibleByIntegerLiteral {
    public init(zeros: Int) {
        self.init(repeatElement(0, count: zeros))
    }
}

public extension BidirectionalCollection {
    public var lastIndex: Index {
        return index(before: endIndex)
    }
}

extension RangeReplaceableCollection where Iterator.Element: Equatable, Indices.Iterator.Element == Index {
    public mutating func remove(_ element: Iterator.Element) {
        for (index, e) in zip(indices, self) where element == e {
            remove(at: index)
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    public var unique: [Iterator.Element] {
        var s: Set<Iterator.Element> = []
        return filter { s.insert($0).inserted }
    }

    public var duplicates: [Iterator.Element] {
        var s: Set<Iterator.Element> = []
        return filter { !s.insert($0).inserted }
    }
}

