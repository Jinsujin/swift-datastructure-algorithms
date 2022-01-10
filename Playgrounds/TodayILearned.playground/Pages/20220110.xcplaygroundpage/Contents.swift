//: [Previous](@previous)

import Foundation

/*:
 ## 링크드 리스트
 
 참고 자료
 https://visualgo.net/en/list
 https://opentutorials.org/module/1335/8821
 https://babbab2.tistory.com/86
 */


class Node<T> {
    var data: T?
    var next: Node?
    
    init(_ data: T?, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

/**
 isEmpty()
 size()
 indexOf(n)
 get(index)
 insert(index)
 delete(index)
 addFirst()
 addLast()
 
 */

struct SingleLinkedList<T> {
    var head: Node<T>?
    private var size = 0
    
    var isEmpty: Bool {
        self.head == nil
    }
    
    //    func insert(at index: Int) {}
    //    func get(at index: Int) {}
    //    func delete(at index: Int) {}
    //    func addFirst()
    //    func addLast()
    
//    mutating func insert(at index: Int, data: T) {}
    mutating func addFirst(_ data: T) {
        let node = Node(data)
        node.next = head
        head = node
        size += 1
    }
    
    mutating func deleteFirst() {
        if isEmpty { return }
        let deleteNode = head
        head = head?.next
        deleteNode?.next = nil
        self.size -= 1
    }

    func printList() {
        if isEmpty { return }
        var node = head
        var elements: [T?] = [node?.data]
        
        for _ in 0..<size {
            if node?.next == nil { break }
            node = node?.next
            elements.append(node?.data)
        }
        elements.compactMap({ $0 }).forEach({ print($0) })
    }
}

var linkedList = SingleLinkedList<Int>()
linkedList.addFirst(1)
linkedList.addFirst(2)
linkedList.addFirst(3)
linkedList.printList()

print("delete first---")
linkedList.deleteFirst()
linkedList.printList()




//: [Next](@next)
