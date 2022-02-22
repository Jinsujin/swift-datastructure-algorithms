//: [Previous](@previous)

import Foundation


/**
 Linked List
 
 */

class Node {
    let value: Int
    var next: Node?
    var isRemoved: Bool = false
    
    init(value: Int, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList {

    private var head: Node?
    private var previous: Node?
    
    

    mutating func append(_ value: Int) {
        let newNode = Node(value: value)
        if head == nil {
            self.head = newNode
            return
        }
        
        // 노드의 가장 마지막에 새로운 노드 추가
         var current = head
        
//        while current?.next != nil {
//            current = current?.next
//        }
        
        while current?.next != nil {
            current = current?.next
            if current?.next?.value == head?.value {
                break
            }
        }
        print("break current value=", current?.value)
        
        // 환형 리스트: 가장 마지막 노드는 head를 가르킨다
        newNode.next = head
        
        current?.next = newNode
    }
    
    func printItems() {
        var current = head
        while current != nil {
            if !current!.isRemoved {
                print(current?.value ?? "")
            }
            current = current?.next
            if current?.value == head?.value  { break }
        }
    }
    
    // N번째 위치를 제거한다
    mutating func remove(_ n: Int) -> Int {
        // 만약 prev 노드가 nil이면, 처음 삭제 하는것
        // => head에서 부터 n 번째를 삭제하면 된다
        // prev 노드가 nil이 아님 => prev 노드에서 부터 n 번째를 센다
        
        if previous == nil {
            // head에서 부터 3번째
            
            var current = head
            var index = n-1
            while(index > 0) {
                current = current?.next
                print("remove value=", current?.value)
                index -= 1
            }
//            for i in 0..<n-1 { // 0,1,2
//                current = current?.next
//            }
            current?.isRemoved = true
            previous = current
            return current?.value ?? -1
        }
        
        // prev 가 있다면, prev부터 n번째
        var current = previous
        var index = n
        while(index > 0) {
            current = current?.next
            if current!.isRemoved { // 이미 지워졌으면 건너뜀
                continue
            }
            print("remove value=", current?.value)
            index -= 1
        }
        current?.isRemoved = true
        previous = current
        return current?.value ?? -1
        
//        var current = previous
//        for i in 0..<n-1 { // 0,1,2
//            current = current?.next
//        }
//        current?.isRemoved = true
//        previous = current
//        return current?.value ?? -1
        
    }
}

//var linkedList = LinkedList()
//linkedList.append(1)
//linkedList.append(2)
//linkedList.append(3)
//linkedList.append(4)
//linkedList.append(5)
//linkedList.append(6)
//linkedList.append(7)
//linkedList.printItems()



// head에서 3번째 요소를 가져온다

func solution(_ N:Int, _ K:Int) -> [Int] {
    var result: [Int] = []
    var linkedList = LinkedList()
    
    //1. 링크드 리스트에 1~N 을 넣는다
    for i in 1...N {
        linkedList.append(i)
    }
    
    // result 가 N 이 될때까지 반복
    while (result.count < N) {
        let removedValue = linkedList.remove(K)
        result.append(removedValue)
    }
    return result
}

// 3,6,2,7,5,1,4
print(solution(7, 3))




//: [Next](@next)
