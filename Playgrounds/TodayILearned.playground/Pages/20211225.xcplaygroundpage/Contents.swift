//: [Previous](@previous)

import Foundation
import XCTest

//: # 복습
struct Stack<T> {
    private var elements = [T]()
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    func peek() -> T? {
        return elements.last
    }
}


struct Queue<T> {
    private var elements = [T]()
    
    var front: T? {
        return elements.first
    }
    
    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    // 삭제후, 나머지 원소들이 모두 한칸씩 이동하므로 O(n)
    mutating func dequeue() -> T? {
        return self.elements.removeFirst()
    }
}


/*:
 ### Linked List 로 스택 구현
 */
class Node<T> {
    var next: Node<T>?
    var data: T
    init(data: T) {
        self.data = data
        next = nil
    }
}

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

//:####  프로토콜을 이용해 StackList 확장. 배열처럼 반복하기
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

//:####  프로토콜을 이용해 StackList 확장- 배열 방식으로 초기화
/// var myStack: StackList = [2,3,4,5]
extension StackList: ExpressibleByArrayLiteral {
    /// 배열 리터럴 을 사용하는 순환 버퍼 구조
    public init(arrayLiteral elements: T...) {
        self.init()
        for el in elements {
            push(el)
        }
    }
}


var myStack = StackList<Int>()
myStack.push(34)
myStack.push(77)
myStack.push(91)
//print(myStack.pop()) // 77
//print(myStack.pop()) // 34
//print(myStack.pop()) // nil

for item in myStack {
    print(item)
}




//: # 학습

/*:
 ## 위장
 스파이들은 매일 다른 옷을 조합하여 입어 자신을 위장합니다.

 예를 들어 스파이가 가진 옷이 아래와 같고 오늘 스파이가 동그란 안경, 긴 코트, 파란색 티셔츠를 입었다면 다음날은 청바지를 추가로 입거나 동그란 안경 대신 검정 선글라스를 착용하거나 해야 합니다.
 
 - 제한사항
    - clothes의 각 행은 [의상의 이름, 의상의 종류]로 이루어져 있습니다.
    - 스파이가 가진 의상의 수는 1개 이상 30개 이하입니다.
    - 같은 이름을 가진 의상은 존재하지 않습니다.
    - clothes의 모든 원소는 문자열로 이루어져 있습니다.
    - 모든 문자열의 길이는 1 이상 20 이하인 자연수이고 알파벳 소문자 또는 '_' 로만 이루어져 있습니다.
    - 스파이는 하루에 최소 한 개의 의상은 입습니다.
 - NOTE:
    - 하루에 최소 한 개의 의상을 주의. (=> 즉, 모두 안입은 경우의 수는 제외해야 한다.)
 */

func solution(_ clothes:[[String]]) -> Int {
    var dic = [String: Int]()
    
    for cloth in clothes {
        let key = cloth[1]
        if dic.keys.contains(key) {
            dic[key] = dic[key]! + 1
            continue
        }
        dic[key] = 1
    }
    
    var count = 1
    for d in dic {
        // +1 : 아무것도 안입은 경우
        count *= d.value + 1
    }
    
    // 아무것도 안입은 경우의 수는 빼야한다
    // 조건: 스파이는 하루에 최소 한 개의 의상은 입습니다.
    return count - 1
}




class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test() {
         let s1 = solution([["yellowhat", "headgear"], ["bluesunglasses", "eyewear"], ["green_turban", "headgear"]])
        let s2 = solution([["crowmask", "face"], ["bluesunglasses", "face"], ["smoky_makeup", "face"]])
        XCTAssertEqual(s1, 5)
        XCTAssertEqual(s2, 3)
    }
    
    func testQueue() {
        
    }
}

//Tests.defaultTestSuite.run()

//: [Next](@next)
