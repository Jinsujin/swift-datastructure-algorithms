# Queue

> FIFO
>
> 먼저 들어간 것이 먼저 나온다

```swift
struct Queue<T> {
    var elements = [T]()

    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }

    mutating func dequeue() -> T? {
        return self.elements.removeFirst()
    }

    func peek() -> T? {
        return self.elements.first
    }

    func isEmpty() -> Bool {
        return elements.isEmpty
    }

    func count() -> Int {
        return elements.count
    }

}
```

<br/>
<br/>

## 📝 프로토콜을 사용한 개선

### 1. 타입값을 출력할때 이름 변경

```swift
extension Queue: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }

    public var debugDescription: String {
        return self.elements.debugDescription
    }
}
```

<br/>

### 2. 배열 리터럴 방식을 이용한 초기화

```swift
extension Queue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        self.elements.append(contentsOf: elements)
    }
}

var queue: Queue<Int> = [1,2,3]
```

<br/>

### 3. Array 처럼 요소 반복

```swift
struct QueueIterator<T>: IteratorProtocol {
    var currentElement: [T]
    mutating func next() -> T? {
        if !self.currentElement.isEmpty {
            // 큐는 첫번째 부터 반환해야 하기에 removeFirst() 사용
            // 스택은 popLast()
            return currentElement.removeFirst()
        } else {
            return nil
        }
    }
}

extension Queue: Sequence {
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator(currentElement: self.elements)
    }
}

var queue: Queue<Int> = [1,2,3,4,5]
for q in queue {
    print(q)
}
```

<br/>

### 4. 서브스크립트 문법 사용(확인필요🚨)

```swift
extension Queue {
    private func checkIndex(index: Int) {
        if index < 0 || index > count {
            fatalError("Index out of range")
        }
    }
}

extension Queue: MutableCollection {
    var startIndex: Int {
        return 0
    }

    var endIndex: Int {
        return count - 1
    }

    func index(after i: Int) -> Int {
        return elements.index(after: i)
    }

    subscript(index: Int) -> T {
        get {
            checkIndex(index: index)
            return self.elements[index]
        }
        set {
            checkIndex(index: index)
            elements[index] = newValue
        }
    }
}
```

<br/>

---

### 참고자료

- `책` 스위프트 고급 데이터 구조의 활용
- [프로토콜 지향 큐 구현하기-씩이](https://the-brain-of-sic2.tistory.com/39)
