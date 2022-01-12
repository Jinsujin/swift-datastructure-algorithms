# Tail 을 추가한 단방향 링크드 리스트

> Head 만 존재했던 링크드 리스트에서
> Tail 을 추가해서 양방향의 추가, 삭제가 되도록 만들어 본다.

<br/>
<br/>

Node 클래스 정의 부분이다. 제네릭 타입 다양한 타입을 넣을 수 있도록 했다:

```swift
class Node<T> {
    var data: T?
    var next: Node<T>?

    init(_ data: T, _ node: Node<T>? = nil) {
        self.data = data
        self.next = node
    }

    deinit {
        // 소멸자. 여기서 참조가 끊어졌는지 확인 가능하다
    }
}
```

위의 Node를 사용할 구조체를 정의한다.

`head`, `tail` 그리고 리스트의 사이즈를 편하게 가져오기 위해 `size` 변수를 추가했다.

```swift
struct LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private(set) var size = 0
...
```

<br/>

## 1-1. head 에 요소 추가

head 만 처리할때와 비교해서 처리해 줘야할 분기가 늘어났다:

```swift
mutating func addFirst(_ element: T) {
    let newNode = Node(element)
    size += 1

    if head == nil && tail == nil { // 새로 만드는 경우(현재 노드갯수 0)
        head = newNode
        tail = newNode
        return
    }

    // 노드가 1개인 상황: head, tail 이 같은 노드를 가르킨다
    if head === tail { // 참조값이 같은지 확인
        newNode.next = tail
        head = newNode
        return
    }

    // node가 2개 이상
    newNode.next = head
    head = newNode
}
```

<br/>

## 1-2. head 에서 삭제

```swift
mutating func deleteFirst() {
	if head == nil && tail == nil {
	    return
	}

	size -= 1

	// 같은 참조인 경우, 노드가 1개다
	if (head === tail) {
	    head = nil
	    tail = nil
	    return
	}

	// node 2개 일때
	if head?.next === tail {
	    head?.next = nil
	    head = tail
	    return
	}

	// 3개 이상
	var temp = head
	head = temp?.next
	temp = nil
}
```

<br/>

## **🕰 시간 복잡도**

- 리스트 앞에서의 요소 추가, 삭제: $O(1)$
- 리스트 끝에서의 요소 추가, 삭제: $O(1)$
- 리스트 중간에서의 요소 추가, 삭제: $O(1)$ 이 지만, 특정 Node 를 탐색하기 위해서는 순차적으로 접근 해야 하므로 최종적으로는 $O(n)$

<br/>

## ⏰  성능 테스트: 시간 측정

**Array** 와 **Linked List** 의 앞에서 요소의 추가, 삭제시 수행 시간을 측정해 보았다.

`measure` 메서드의 클로저 안에 측정하고자 하는 코드를 넣으면 성능 테스트가 가능하다. 10번 실행하여 평균 수행시간과 실행하는 표준 편차를 수집한다고 한다. 측정값의 평균은 테스트 실행에 대한 값을 형성한 다음 기준선(base line) 과 비교해 성공과 실패를 평가할 수 있다.

기준선(base line) 은 테스트의 합격과 불합격 평가를 하기위해 사용하는 값이다. 이 값은 사용자가 설정할 수 있다.

```swift
func testArrayAddFirst() {
    var array = [Int]()
    measure {
        for i in 0...1000 {
            array.insert(i, at: 0)
        }
    }
}

func testLinkedListAddFirst() {
    var list = LinkedList<Int>()
    measure {
        for i in 0...1000 {
            list.addFirst(i)
        }
    }
}
```

배열일때 측정한 결과값이다.

평균 `4.295` 그리고 `values` 에 10번 실행된 각각의 수행시간이 배열값으로 나타난 것을 확인할 수 있었다:

```swift
testArrayAddFirst]' measured [Time, seconds]
average: 4.295, relative standard deviation: 49.296%,
values: [0.982662, 1.694601, 2.357336, 3.333752, 3.854786, 4.823659, 5.694039, 7.777042, 6.707048, 5.721547]
```

다음으로 직접 만든 링크드 리스트로 측정한 값이다.

평균 `1.602` 으로 배열과 비교했을때 절반 이상 시간을 단축할 수 있다는 것을 확인할 수 있었다.

```swift
testLinkedListAddFirst]' measured [Time, seconds]
average: 1.602, relative standard deviation: 4.830%,
values: [1.798811, 1.565739, 1.568823, 1.562664, 1.538348, 1.529186, 1.620931, 1.598231, 1.559673, 1.677128]
```

<br/>

## 🖍 결론

- 링크드 리스트를 구현해 O(1) 시간에 삽입, 삭제를 구현해 보았다.
- 테스트를 통해 배열과 링크드 리스트의 수행시간을 직접 눈으로 확인 했다.

대용량의 데이터를 다뤄보지 않아 컬렉션 사용에 있어 효율성을 고민하지 않았다. 성능 테스트를 통해 눈으로 직접 확인해 보니, O(1) 과 O(n) 의 차이를 실감할 수 있었다.

Swift 에서 제공하는 기본 데이터 구조에 만족하지 말고, 필요하다면 직접 만들어 사용할 수 있도록 해야겠다.

<br/>

---

### 참고자료

- [Xcode 퍼포먼스 테스트](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/04-writing_tests.html#//apple_ref/doc/uid/TP40014132-CH4-SW8)
