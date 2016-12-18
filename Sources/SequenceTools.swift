import Foundation

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

extension Int {
    static var random: Int {
        return Int(arc4random_uniform(UInt32.max))
    }
}

public protocol RandomizableCollection: Collection {
    var randomIndex: Index { get }
}

extension RandomizableCollection {
    public var random: Iterator.Element? {
        return first.map { _ in self[randomIndex] }
    }
}

extension Collection where IndexDistance == Int {
    /// Return a random element from the array
    public var randomIndex: Index {
        let offset = Int(arc4random_uniform(UInt32(count.toIntMax())))
        return index(startIndex, offsetBy: offset)
    }
}

extension Array: RandomizableCollection { }

extension Collection {
    public func scatter<S: Sequence>(_ indices: S) -> [Iterator.Element] where S.Iterator.Element == Index {
        return indices.map { self[$0] }
    }
}


/*
public func randomShuffle<T>(_ a: [T]) -> [T] {
  var result = a
  for i in (1..<a.count).reversed() {
    // FIXME: 32 bits are not enough in general case!
    let j = Int(rand32(exclusiveUpperBound: UInt32(i + 1)))
    if i != j {
      swap(&result[i], &result[j])
    }
  }
  return result
}

public func gather<C : Collection, IndicesSequence : Sequence>(
  _ collection: C, _ indices: IndicesSequence
) -> [C.Iterator.Element]
  where IndicesSequence.Iterator.Element == C.Index {
  return Array(indices.map { collection[$0] })
}

public func scatter<T>(_ a: [T], _ idx: [Int]) -> [T] {
  var result = a
  for i in 0..<a.count {
    result[idx[i]] = a[i]
  }
  return result
}*/
