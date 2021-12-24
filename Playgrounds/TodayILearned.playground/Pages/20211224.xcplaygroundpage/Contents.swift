//: [Previous](@previous)

import Foundation
import XCTest

//:# 복습
struct Stack<T> {
    private var elements = [T]()
    
    func peek() -> T? {
        return elements.last
    }
    
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
}

var stack = Stack<Int>()
stack.push(1)
stack.peek()


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

/**
 배열 리터럴 방식으로 큐 생성
 - var queue: Queue<Int> = [1,2,3]
 */
extension Queue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
    
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        self.elements.append(contentsOf: elements)
    }
}

/**
 반복문 사용하기
 Array 구조체처럼 for 문을 사용하기 위해서는 Sequence 프로토콜을 채택해야 한다.
 */
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


/**
 Collection 프로토콜을 채택해 서브스크립트 문법 사용하기
 //TODO: 동작하는지 확인 필요
 */
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



//var queue = Queue<Int>()
//queue.enqueue(1)
//queue.enqueue(2)
//print(queue.dequeue())

var queue: Queue<Int> = [1,2,3,4,5]
for q in queue {
    print(q)
}
print(queue.count())

/*:
 ## 올바른 괄호
 괄호가 바르게 짝지어졌다는 것은 '(' 문자로 열렸으면 반드시 짝지어서 ')' 문자로 닫혀야 한다는 뜻입니다. 예를 들어

 - "()()" 또는 "(())()" 는 올바른 괄호입니다.
 - ")()(" 또는 "(()(" 는 올바르지 않은 괄호입니다.
 - '(' 또는 ')' 로만 이루어진 문자열 s가 주어졌을 때, 문자열 s가 올바른 괄호이면 true를 return 하고, 올바르지 않은 괄호이면 false를 return 하는 solution 함수를 완성해 주세요.
 */

// NOTE:- 효율성 테스트에서 실패, 스택 개선 필요할듯?
func solution(_ str: String) -> Bool {
    var stack = Stack<Character>()
    
    for char in str {
        if let prev = stack.peek(),
           char == ")" && prev == "(" {
            stack.pop()
            continue
        }
        stack.push(char)
    }
    return stack.isEmpty()
}

solution("(())()") // true







//: # 학습
/*:
 ### 다리를 지나는 트럭
 트럭 여러 대가 강을 가로지르는 일차선 다리를 정해진 순으로 건너려 합니다. 모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지 알아내야 합니다. 다리에는 트럭이 최대 bridge_length대 올라갈 수 있으며, 다리는 weight 이하까지의 무게를 견딜 수 있습니다. 단, 다리에 완전히 오르지 않은 트럭의 무게는 무시합니다.

 예를 들어, 트럭 2대가 올라갈 수 있고 무게를 10kg까지 견디는 다리가 있습니다. 무게가 [7, 4, 5, 6]kg인 트럭이 순서대로 최단 시간 안에 다리를 건너려면 다음과 같이 건너야 합니다.
 
 bridge_length    weight    truck_weights    return
 - 2    10    [7,4,5,6]    8
 - 100    100    [10]    101
 - 100    100    [10,10,10,10,10,10,10,10,10,10]    110
 */
struct Truct {
    let kg: Int
    
    /// 경과시간
    var time: Int
}

func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    var waitQueue = Queue<Truct>()
    var ingQueue = Queue<Truct>()
    var time = 1
    
    // 대기큐에 트럭 넣기
    for truct in truck_weights {
        waitQueue.enqueue(Truct(kg: truct, time: bridge_length))
    }
    
    while(!waitQueue.isEmpty() || !ingQueue.isEmpty()) {
        //1. 다리에 트럭을 올릴수 있다면, 트럭을 큐에 올린다
        // 다리건너는 트럭들의 무게 합
//        let weightOnBridgeTrucks = ingQueue.elements.map({ $0.kg }).reduce(0, { $0 + $1 })
        let weightOnBridgeTrucks = ingQueue.map({ $0.kg }).reduce(0, { $0 + $1 })
        
        if let waitTruct = waitQueue.peek(),
            ingQueue.count() < bridge_length
                && (weightOnBridgeTrucks + waitTruct.kg) <= weight {
            ingQueue.enqueue(waitQueue.dequeue()!)
        }
        
        //2. 다리위큐에 트럭이 있으면 1씩 증가
        if !ingQueue.isEmpty() {
            for i in 0..<ingQueue.count() {
                ingQueue.elements[i].time -= 1
            }
        }
        
        //3. 다리를 건너의 트럭의 사간이 0 이면, 다리건너는 큐에서 제거
        if let ingTruct = ingQueue.peek(), ingTruct.time <= 0 {
            ingQueue.dequeue()
        }
        
        time += 1
    }
    return time
}



class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTruck() {
        let s1 = solution(2, 10, [7,4,5,6]) // 8
        let s2 = solution(100,100,[10])//    101
        let s3 = solution(100,100,[10,10,10,10,10,10,10,10,10,10])//    110
        XCTAssertEqual(s1, 8)
        XCTAssertEqual(s2, 101)
        XCTAssertEqual(s3, 110)
    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
