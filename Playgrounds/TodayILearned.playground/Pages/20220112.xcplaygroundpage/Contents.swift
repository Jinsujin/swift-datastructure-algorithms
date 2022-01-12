//: [Previous](@previous)

import Foundation
import XCTest


/*:
 ## reverse
 https://leetcode.com/problems/reverse-integer/
 */

func reverse(_ x: Int) -> Int {
    
    // int 타입의 min, max 검사: -2^31 ~ (2^31 - 1)
    if (x > Int32.max || x < Int32.min) {
        return 0
    }
    
    let minus = x  < 0 ? true : false
    
    let xArr = Array(String(x))
    var result = [Character]()
    for i in stride(from: xArr.count - 1, through: 0, by: -1) { // 3,2,1,0
        let val = xArr[i]
        if Int(String(val)) == nil {
            continue
        }
        result.append(xArr[i])
    }
    
    var reversedNum = Int(String(result)) ?? 0
    reversedNum = minus ? -reversedNum : reversedNum
    
    if (minus && reversedNum < Int32.min)
        || (!minus && reversedNum > Int32.max ){
        return 0
    }

    return reversedNum
}



/*:
 ## Remove duplicates from sorted list
 https://leetcode.com/problems/remove-duplicates-from-sorted-list/
 */

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() {
        self.val = 0
        self.next = nil
    }
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
        
    }
}


struct MyNodeList {
    private var head: ListNode?
    private var size = 0
    
    mutating func addFirst(_ val: Int) {
        let newNode = ListNode(val)
        //1. head와 head가 가르키고 있는 노드를 찾는다
        //2. head 가 nil이면 head 에 새로만든 노드를 넣는다
        
        if (head == nil) {
            head = newNode
            return
        }

        newNode.next = head
        head = newNode
    }
    
    func count() -> Int {
        if head == nil { return 0 }
        var node = head
        var count = 1
        while (node?.next != nil) {
            count += 1
            node = node?.next
        }
        return count
    }
    
    func convertArr() -> [Int] {
        var result = [Int]()
        if head == nil { return result }
        var node = head
        while(node != nil) {
            guard let val = node?.val else { break }
            result.append(val)
            node = node?.next
        }
        return result
    }
    
    func printListItems() {
        var current = head
        while current != nil {
            print(current?.val ?? "")
            current = current?.next
        }
    }
    
    mutating func deleteDuplicates() {
        var currentVal = head?.val
        var node = head
        while(node != nil) {
            if (currentVal == node?.next?.val) {
                // 같은 데이터를 가진 노드다! => 노드를 삭제한다
                // 삭제할 노드: node.next
                // 현재 노드: node
                // print("current=", currentVal,"  next=", node?.next?.val)
                var deleteNode = node?.next
                node?.next = deleteNode?.next
                deleteNode?.next = nil
                deleteNode = nil
                continue
            } else {
                // 현재노드와는 값이 다른 노드다
                // print("현재노드와 다음노드의 값이 다르다:", currentVal, node?.next?.val)
                currentVal = node?.next?.val
            }
            node = node?.next
        }
    }
}



class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTwoNum() {
        let r = twoSum([2,7,11,15], 9)
        let expect = [0,1]
        XCTAssertEqual(r, expect)
    }
    
    func testReverse() {
        let r1 = reverse(123) // 321
        let r2 = reverse(-123) // -321
        let r3 = reverse(120) // 21
        let r4 = reverse(1534236469) // 9646324351, 0 이 나와야 함?
        
        XCTAssertEqual(r1, 321)
        XCTAssertEqual(r2, -321)
        XCTAssertEqual(r3, 21)
        XCTAssertEqual(r4, 0)
    }
    
    func testRemoveDuplicateNode() {
        //given
        var list = MyNodeList()
        list.addFirst(1)
        list.addFirst(1)
        list.addFirst(1)
        list.addFirst(2)
        list.addFirst(2)
        //when
        list.deleteDuplicates()
//        list.printListItems()
        let result = list.convertArr()
        let expect = [2,1]
        //then
        XCTAssertEqual(result, expect)
    }
}

Tests.defaultTestSuite.run()


//: [Next](@next)
