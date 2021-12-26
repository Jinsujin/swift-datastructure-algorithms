//: [Previous](@previous)

import Foundation
import XCTest


class Node<T> {
    var data: T
    var next: Node<T>?
    init(data: T) {
        self.data = data
        next = nil
    }
}

struct StackList<T> {
    private var head: Node<T>? = nil
    private(set) var count = 0
    
    mutating func pop() -> T? {
        if isEmpty {
            return nil
        }
        let data = head?.data
        head = head?.next
        count -= 1
        return data
    }
    
    mutating func push(_ element: T) {
        let newNode = Node<T>(data: element)
        newNode.next = head
        head = newNode
        count += 1
    }
    
    func peek() -> T? {
        return head?.data
    }
    
    var isEmpty: Bool {
        return count == 0
    }
}

struct NodeIterator<T>: IteratorProtocol {
    typealias Element = T
    private var head: Node<Element>?
    init(head: Node<T>?) {
        self.head = head
    }
    
    mutating func next() -> Element? {
        if (head != nil) {
            let data = head!.data
            head = head!.next
            return data
        }
        return nil
    }
}

extension StackList: Sequence {
    func makeIterator() -> NodeIterator<T> {
        return NodeIterator<T>(head: self.head)
    }
}





/*:
 ### 큰 수 만들기
 어떤 숫자에서 k개의 수를 제거했을 때 얻을 수 있는 가장 큰 숫자를 구하려 합니다.

 예를 들어, 숫자 1924에서 수 두 개를 제거하면 [19, 12, 14, 92, 94, 24] 를 만들 수 있습니다. 이 중 가장 큰 숫자는 94 입니다.

 문자열 형식으로 숫자 number와 제거할 수의 개수 k가 solution 함수의 매개변수로 주어집니다. number에서 k 개의 수를 제거했을 때 만들 수 있는 수 중 가장 큰 숫자를 문자열 형태로 return 하도록 solution 함수를 완성하세요.
 
 number    k    return
 "1924"    2    "94"
 "1231234"    3    "3234"
 "4177252841"    4    "775841"
 
 */
func solutionBigestNum(_ number:String, _ k:Int) -> String {
    var stack = [Character]()
    var count: Int = k

    for char in number {
        // 현재 숫자와 스택에서 가장 나중에 들어간 문자 비교
        // 만약, 스택에 있는 문자의 숫자가 더 작으면 스택.pop
        while (!stack.isEmpty && stack.last! < char) {
            if count <= 0 { break }
            stack.popLast()
            count -= 1
        }
        stack.append(char)
    }

    let result = String(stack).dropLast(count)
    return String(result)
}




/*:
 ### 활동 선택(그리디)
 N개의 활동이 있고 각 활동에는 시작 시간 및 종료 시간이 있을 때, 한 사람이 최대한 많이 할 수 있는 활동(Activity)의 수를 구하는 문제
 */

func solutionClass(_ classList: [String: [Int]]) -> String {
    // 끝나는 시간을 기준으로 먼저 정렬한다.
    let sortedClassList = classList.sorted(by: { $0.value[1] < $1.value[1] })
    
    var lastEndTime = 0
    var results = [String]()
    
    for c in sortedClassList {
        if lastEndTime < c.value[0] {
            results.append(c.key)
            lastEndTime = c.value[1]
        }
    }
    return results.joined(separator: ",")
}

/*:
 ### 강의실 배정(백준11000)
 Si에 시작해서 Ti에 끝나는 N개의 수업이 주어지는데, 최소의 강의실을 사용해서 모든 수업을 가능하게 해야 한다.
 */
func solutionClass(_ classList: [[Int]]) -> Int {
    let sortedClassList = classList.sorted(by: { $0[1] < $1[1] })
    var result = [Int]()
    var lastEndTime = 0
    for (idx, c) in sortedClassList.enumerated() {
        // c[0]: 시작시간,  c[1]: 끝나는 시간
        if lastEndTime <= c[0] {
            result.append(idx)
            lastEndTime = c[1]
        }
    }
    
    return result.count
}



class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBigNum() {
        let s = solutionBigestNum("1924", 2)
        XCTAssertEqual(s, "94")
    }
    
//    func testActiveSelect() {
//        let classData = ["A": [7,8], "B": [5,7], "C": [3,6], "D": [1,2], "E": [6,9], "F": [10,11]]
//        let s = solutionClass(classData)
//        XCTAssertEqual(s, "D,C,A,F", "활동 선택 문제")
//    }
//
//    func testClass() {
//        let data = [[1,3], [2,4], [3,5]]
//        let s  = solutionClass(data)
//        XCTAssertEqual(s, 2, "강의실 배정")
//    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
