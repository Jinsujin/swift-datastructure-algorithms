# 단방향 링크드 리스트로 구현하는 Stack

### Linked List

> 원소들이 Link로 연결되어 있다.
> 단방향, 양방향, 원형 연결 리스트가 있다.
> <br/>
> 보통 `data`와 메모리 주소를 가르키는 `pointer` 를 하나로 묶어 `Node` 객체를 구현한다.

- 검색이 느리다. `O(n)`
  - 순차접근(Sequential access): 첫번째 원소부터 하나씩 링크를 따라가며 읽어야 한다.
  - Array 처럼 index로 접근할 수 없다.
- 중간에 삽입, 삭제가 빠르다. `O(1)`
  - 노드만 변경해주면 된다.

<br/>

### Array (배열)

> Array 는 물리적으로 연속된 메모리에 저장된다.

- index를 이용해 찾을 수 있어 빠른 탐색이 가능하다(random access 임의 접근)
  - index를 이용하기에 `O(1)`
- 중간에 삽입이 느리다 `O(n)`
  - 중간에 삽입하는 경우, 그 뒤의 원소들은 한칸씩 밀려나가야 한다.
- 중간에 삭제가 느리다 `O(n)`
  - 원소들을 한칸씩 당겨야 한다.

<br/>
<br/>

## 구현

노드를 Class 로 정의한다.

```swift
class Node<T> {
    var next: Node<T>?
    var data: T
    init(data: T) {
        self.data = data
        next = nil
    }
}
```

🤔 Node 를 구현할때 class 를 사용하는 이유는 뭘까?<br/>
각 Node 인스턴스들은 링크(참조정보)로 연결되어야 한다.
Struct 는 값타입이고, 값을 전달하면 복사해서 전달한다.
Class 는 참조타입이고, 참조값을 전달할 수 있다.<br/>
따라서 올바른 Linked List 를 구현하려면 Node가 참조값을 가르키게 해야 하므로 Class 로 구현하는 것이 올바르다.

<br/>

Node 를 이용해 Stack 를 정의한다.

```swift
struct StackList<T> {
    private var head: Node<T>? = nil
    private(set) var count: Int = 0

    var isEmpty: Bool {
        return count == 0
    }

    mutating func push(_ element: T) {
        let node = Node<T>(data: element)
        node.next = head
        head = node
        count += 1
    }

    mutating func pop() -> T? {
        if isEmpty {
            return nil
        }

        let item = head?.data
        head = head?.next
        count -= 1
        return item
    }

    func peek() -> T? {
        return head?.data
    }
}
```

<br/>
<br/>

## 📝 프로토콜을 사용한 개선

### 1. 배열 리터럴 방식을 이용한 초기화

```swift
extension StackList: ExpressibleByArrayLiteral {
    /// 배열 리터럴 을 사용하는 순환 버퍼 구조
    public init(arrayLiteral elements: T...) {
        self.init()
        for el in elements {
            push(el)
        }
    }
}
var myStack: StackList = [2,3,4,5]
```

<br/>

### 2. Array 처럼 요소 반복

Sequence protocol 을 채택해 반복문을 사용할 수 있도록 한다.

```swift
struct NodeIterator<T>: IteratorProtocol {
    typealias Element = T
    private var head: Node<Element>?
    init(head: Node<T>?) {
        self.head = head
    }

    mutating func next() -> T? {
        if (head != nil) {
            let item = head!.data
            head = head!.next
            return item
        }
        return nil
    }
}

extension StackList: Sequence {
    func makeIterator() -> NodeIterator<T> {
        return NodeIterator<T>(head: self.head)
    }
}
```

<br/>

### 스택 사용해 보기

```swift
var myStack = StackList<Int>()
myStack.push(34)
myStack.push(77)
myStack.push(91)

for item in myStack {
    print(item)
}
//91
//77
//34
```

<br/>

---

### 참고자료

- `책` 스위프트 고급 데이터 구조의 활용
