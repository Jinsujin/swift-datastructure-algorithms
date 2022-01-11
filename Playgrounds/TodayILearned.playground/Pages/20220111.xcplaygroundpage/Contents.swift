//: [Previous](@previous)

import Foundation
import XCTest

//var str: String? = "Hello World!"

// while let : 반복 횟수를 모를때 사용
// while let x = str {
//    print(x)
//    str = nil
//}


/*:
 ### 단방향 링크드 리스트
 - 꼬리 추가해서 양방향에서 추가, 삭제되도록 함
 
 - 참고자료
 https://zeddios.tistory.com/1244
 https://www.swift.org/blog/swift-collections/
 https://twitter.com/swiftandtips/status/1379620330529042432/photo/2
  */



class Node<T> {
    var data: T?
    var next: Node<T>?
    
    init(_ data: T, _ node: Node<T>? = nil) {
        self.data = data
        self.next = node
    }
    
    deinit {
        print("--- deinit, \(data) ---")
    }
}


struct LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private(set) var size = 0
    
    mutating func deleteFirst() {
        
        if head == nil && tail == nil {
            print("비어있으므로 삭제 불가")
            return
        }
        
        size -= 1
        
        // 같은 참조인 경우, 노드가 1개다
        if (head === tail) {
            print("노드 1개 삭제 => 모든 리스트를 비웠다")
            head = nil
            tail = nil
            return
        }
        
        // node 2개 일때
        if head?.next === tail {
            print("2개에서 삭제")
            head?.next = nil
            head = tail
            return
        }
        
        // 3개 이상
        print("3개 이상에서 삭제")
        var temp = head
        head = temp?.next
        temp = nil
    }
    
    
    mutating func addFirst(_ element: T) {
        let newNode = Node(element)
        size += 1
        
        if head == nil && tail == nil {
            print("새로만든다", element)
            head = newNode
            tail = newNode
            return
        }
        
        // 1개인 상황: head, tail 이 같은 노드를 가르킨다
//        if size == 1 {
        if head === tail { // 참조값이 같은지 확인
            print("같은 참조값", element)
            newNode.next = tail
            head = newNode
            return
        }
        
        // node가 2개 이상
        print("node 2개 이상", element)
        newNode.next = head
        head = newNode
    }
}


var list = LinkedList<Int>()
list.addFirst(1)
list.addFirst(2)
list.addFirst(3)
list.deleteFirst() // 3 삭제되고 1,2 남아야 함
list.deleteFirst() // 2 삭제되고 1 남아야 함
print("linked list size: ", list.size)




class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testQueueDefault() {
//        var queue = [Int]()
//        measure {
//            for i in 0...1000 {
//                queue.push(i)
//            }
//        }
//        while let _ = queue.pop() {}
//    }
}

//Tests.defaultTestSuite.run()




//: [Next](@next)
