

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
    init(zeros: Int) {
        self.init(repeatElement(0, count: zeros))
    }
}
