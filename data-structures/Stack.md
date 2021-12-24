# Stack

> LIFO:
>
> 나중에 들어간 것이 먼저 나온다.

```swift
public struct Stack<T> {
    private var elements = [T]()

    public init() {}

    // 삭제후 반환
    public mutating func pop() -> T? {
        return self.elements.popLast()
    }

    public mutating func push(_ element: T) {
        self.elements.append(element)
    }

    // 삭제하지 않고 반환
    public func peek() -> T? {
        return self.elements.last
    }

    public var isEmpty: Bool {
        return self.elements.isEmpty
    }

    public var count: Int {
        return self.elements.count
    }
}
```

<br/>
<br/>

## 📝 프로토콜을 사용한 개선

### 1. 타입값을 출력할때 이름 변경

```swift
extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }

    public var debugDescription: String {
        return self.elements.debugDescription
    }
}
// Point(x: 0, y: 0) => (0, 0)
```

### 2. 배열 리터럴 방식을 이용한 초기화

```swift
extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        self.init()
        elements.forEach{ push($0) }
    }
}

var myStack: Stack = [1,2,3,4]
```

<br/>

### 3. Array 처럼 요소 반복

- **IteratorProtocol** 은 요소를 추가하거나 반복할때 사용
- 다음 원소를 반환하는 next() 를 구현해야 한다.
  (스택에 포함된 요소의 타입에 따라 값을 반환하는 반복기를 반환)

```swift
public struct ArrayIterator<T>: IteratorProtocol {
    var currentElements: [T]

    init(elements: [T]) {
        self.currentElements = elements
    }

    /// 시퀸스의 다음 요소를 반환
    mutating public func next() -> T? {
        if(!self.currentElements.isEmpty) {
            return self.currentElements.popLast()
        }
        // 순회할 요소가 없다면 nil을 반환
        return nil
    }
}


extension Stack: Sequence {
    // swift runtime은 for in 루프를 초기화할때 이 메서드를 호출.
    public func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator<T>(elements: self.elements)
    }

    // 기존의 스택을 통해 새로운 스택을 초기화
    // 배열 복사시 reversed() 를 통해 입력되는 데이터 순서를 바꿔야 Stack구조에 맞는 값이 된다.
    public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
        self.elements = Array(s.reversed())
    }
}
```

<br/>

### 스택 사용해 보기

```swift
var myStack: Stack = [1,2,3,4] // [1, 2, 3, 4]

var stackFromMyStack = Stack<Int>(myStack) //[1, 2, 3, 4]

stackFromMyStack.push(20) // [1, 2, 3, 4, 20]

myStack.push(100) // [1, 2, 3, 4, 100]

stackFromMyStack // [1, 2, 3, 4, 20]
```

<br/>

---

### 참고자료

- `책` 스위프트 고급 데이터 구조의 활용
