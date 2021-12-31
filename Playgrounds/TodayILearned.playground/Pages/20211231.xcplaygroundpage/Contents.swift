//: [Previous](@previous)

import Foundation
import XCTest


//: # 복습
struct Queue<T> {
    private var elements = [T]()
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        return self.elements.removeFirst()
    }
    
    func front() -> T? {
        return self.elements.first
    }
}

struct QueueIterator<T>: IteratorProtocol {
    var currentElements: [T]
    
    mutating func next() -> T? {
        if !currentElements.isEmpty {
            return currentElements.removeFirst()
        }
        return nil
    }
}

extension Queue: Sequence {
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator<T>(currentElements: self.elements)
    }
}


//: ### 이진탐색
func binarySearch(_ arr:[Int], find: Int) -> Int {
    
    var first = 0
    var last = arr.count - 1
    
    while (first <= last) {
        let mid = (first + last) / 2
        if arr[mid] == find { return mid }
        if arr[mid] > find {
            last = mid - 1
            continue
        }
        first = mid + 1
    }
    
    return 0
}

binarySearch([1,3,5,7,9], find: 9) // 1


/*:
 ### 삽입 정렬
 */
func insertionSort(_ arr: [Int]) -> [Int] {
    var copyArray = arr
    
    for i in 0..<copyArray.count {
        let v = arr[i]
        var prev = i - 1
        while (prev >= 0 && copyArray[prev] > v) {
            copyArray[prev + 1] = copyArray[prev]
            prev -= 1
        }
        copyArray[prev + 1] = v
    }
    
    return copyArray
}

insertionSort([5,2,4,6,1,3])


/*:
 ### 버블 정렬
 */
func bubbleSort(_ arr: [Int]) -> [Int] {
    var copyArray = arr
    
    for i in stride(from: arr.count-1, through: 1, by: -1) { // 5~1
        for j in 0..<i {
            if (copyArray[i] < copyArray[j]) {
                copyArray.swapAt(i, j)
            }
        }
    }
    return copyArray
}

bubbleSort([5,2,4,6,1,3])


/*:
 ## 프린터
 
 https://programmers.co.kr/learn/courses/30/lessons/42587
 일반적인 프린터는 인쇄 요청이 들어온 순서대로 인쇄합니다. 그렇기 때문에 중요한 문서가 나중에 인쇄될 수 있습니다. 이런 문제를 보완하기 위해 중요도가 높은 문서를 먼저 인쇄하는 프린터를 개발했습니다. 이 새롭게 개발한 프린터는 아래와 같은 방식으로 인쇄 작업을 수행합니다.

 1. 인쇄 대기목록의 가장 앞에 있는 문서(J)를 대기목록에서 꺼냅니다.
 2. 나머지 인쇄 대기목록에서 J보다 중요도가 높은 문서가 한 개라도 존재하면 J를 대기목록의 가장 마지막에 넣습니다.
 3. 그렇지 않으면 J를 인쇄합니다.
 예를 들어, 4개의 문서(A, B, C, D)가 순서대로 인쇄 대기목록에 있고 중요도가 2 1 3 2 라면 C D A B 순으로 인쇄하게 됩니다.
 
 priorities    location    return
 [2, 1, 3, 2]    2    1
 [1, 1, 9, 1, 1, 1]    0    5
 */
func solution(_ priorities:[Int], _ location:Int) -> Int {
    
    // idx, 중요도
    var queue = Queue<(idx: Int, priority: Int)>()
    
    var answer = 0
    
    for (idx, priority) in priorities.enumerated() {
        queue.enqueue((idx: idx, priority: priority))
    }
    
    // 큐에서 첫번째 요소를 가져온다
    // 만약, 첫번째 요소가 큐에 들어있는 다른 요소들 보다 중요도가 낮다면 => 큐의 맨 뒤로 보낸다
    // 중요도가 높다면 프린트할 배열에 넣는다
    while (!queue.isEmpty) {
        guard let current = queue.front() else { continue }
        var flag = false
        
        for i in queue {
            if i.idx == current.idx { continue }
            if i.priority > current.priority {
                flag = true
                break
            }
        }
        
        if flag {
            let c = queue.dequeue()
            queue.enqueue(c!)
        } else {
            answer += 1
            queue.dequeue()
            if(current.idx == location) {
                return answer
            }
        }
    }
    
    return answer
}


class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPrinter() {
        //solution([2,1,3,2], 2) //1
        //solution([1, 1, 9, 1, 1, 1], 2)

        let s2 = solution([1, 1, 9, 1, 1, 1], 0) // 5
        XCTAssertEqual(s2, 5, "프린터")
    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
