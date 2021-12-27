//: [Previous](@previous)

import Foundation

//: 복습
struct Stack<T> {
    private var elements = [T]()
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    mutating func peek() -> T? {
        return elements.last
    }
}

struct StackIterator<T>: IteratorProtocol {
    var currentElements: [T]
    
    mutating func next() -> T? {
        if !currentElements.isEmpty {
            return currentElements.popLast()
        }
        return nil
    }
}

extension Stack: Sequence {
    func makeIterator() -> StackIterator<T> {
        return StackIterator(currentElements: self.elements)
    }
}


//var stack = Stack<Int>()
//stack.push(1)
//stack.push(2)
//
//for i in stack {
//    print(i)
//}


struct Queue<T> {
    var elements = [T]()
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        self.elements.removeFirst()
    }
    
    func peek() -> T? {
        self.elements.first
    }
}

struct QueueIterator<T>: IteratorProtocol {
    var elements: [T]
    
    mutating func next() -> T? {
        if !elements.isEmpty {
            return elements.removeFirst()
        }
        return nil
    }
}


extension Queue: Sequence {
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator<T>(elements: self.elements)
    }
}

var queue = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)
for i in queue {
    print(i)
}



/*:
 ### 이진 탐색
 - 원소들이 정렬되어 있어야 사용 가능
 - O(log N) : 로그시간이 걸린다. 단순탐색 O(N) 보다 빠른 탐색 알고리즘
 - 1208 개의 배열을 탐색하는데 7 번만 검사하면 된다.
 */
func binarySearch(_ find: Int, list: [Int]) -> Int {
    var low = 0
    var high = array.count - 1

    while(low <= high) {
        let mid = (low + high) / 2
        if list[mid] == find { return mid }
        if list[mid] > find {
            high = mid - 1
            continue
        }
        low = mid + 1
    }
    
    
    return -1
}
var array: [Int] = [1,3,5,7,9]
binarySearch(3, list: array)


//: [Next](@next)
