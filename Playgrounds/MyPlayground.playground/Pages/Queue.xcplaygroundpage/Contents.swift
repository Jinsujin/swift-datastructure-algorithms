//: [Previous](@previous)

import Foundation

/*
 큐
 들어온 순서대로 처리
 예) POS 주문 시스템
 
 
 **/

public struct Queue<T> {
    private var data = [T]()
    
    public init() {}
    
    // 첫번째 요소를 제거후 반환
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    // 첫번째 요소를 제거하지 않고 반환
    public func peek() -> T? {
        return data.first
    }
    
    // 큐의 맨 뒤에 데이터 추가
    public mutating func enqueue(_ element: T)  {
        data.append(element)
    }
   
}



///MARK:- 순환 버퍼를 위한 도우미 메소드
extension Queue {
    // 버퍼를 재설정하여 빈 상태로 만듬
    public mutating func clear() {
        data.removeAll()
    }
    
    public var count: Int {
        return data.count
    }
    
    // 큐의 용량을 반환
    public var capacity: Int {
        get { return data.capacity }
        set { return data.reserveCapacity(newValue) }
    }
    
    // 큐가 꽉찼는지 확인
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
}


var queue = Queue<Int>()
queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)
queue.enqueue(40)

let a = queue.dequeue()
let b = queue.peek()
let c = queue.dequeue()
let d = queue.peek()



//: [Next](@next)
