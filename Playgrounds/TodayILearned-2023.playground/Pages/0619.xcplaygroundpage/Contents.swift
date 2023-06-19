//: [Previous](@previous)

import Foundation

final class MinPriorityQueue<T> {
    var values = [Elem]()
    typealias Elem = (val: T, priority: Int)
    var isEmpty: Bool { values.isEmpty }
    
    func peek() -> Elem? {
        return values.first
    }
    
    func enqueue(_ val: T, _ priority: Int) {
        values.append((val, priority))
        bubbleUp()
    }
    
    private func bubbleUp() {
        var currentIdx = values.count - 1
        
        while(currentIdx > 0) {
            let parentIdx = (currentIdx-1)/2
            if values[currentIdx].priority >= values[parentIdx].priority {
                break
            }
            values.swapAt(currentIdx, parentIdx)
            currentIdx = parentIdx
        }
    }
    
    func dequeue() -> Elem? {
        guard let minValue = values.first else {
            return nil
        }
        let last = values.removeLast()
        if values.count == 0 { return last }
        values[0] = last
        sinkDown()
        return minValue
    }
    
    private func sinkDown() {
        var currentIdx = 0
        let length = values.count
        
        while(true) {
            let leftChildIdx = (currentIdx*2) + 1
            let rightChildIdx = (currentIdx*2) + 2
            let currentPriority = values[currentIdx].priority
            var swapIdx: Int?
            
            if leftChildIdx < length {
                if values[leftChildIdx].priority < currentPriority {
                    swapIdx = leftChildIdx
                }
            }
            
            if rightChildIdx < length {
                if (swapIdx == nil && values[rightChildIdx].priority < currentPriority)
                    || (swapIdx != nil && values[rightChildIdx].priority < values[swapIdx!].priority) {
                    swapIdx = rightChildIdx
                }
            }
            
            guard let swapIdx = swapIdx else { break }
            values.swapAt(currentIdx, swapIdx)
            currentIdx = swapIdx
        }
    }
}


// (Priority Queue) 더맵게
// 테스트 케이스 더 추가하여 검증 필요
func solution(k: Int, _ input: [Int]) -> Int {
    var answer = 0
    var pQ = MinPriorityQueue<Int>()
    
    for elem in input {
        pQ.enqueue(elem, elem)
    }
    
    while(!pQ.isEmpty && pQ.peek()!.priority < k) {
        guard let s1 = pQ.dequeue()?.priority, let s2 = pQ.dequeue()?.priority else {
            return -1
        }
        let newScovil = s1 + (s2 * 2)
        pQ.enqueue(newScovil, newScovil)
        answer += 1
    }
    return answer
}

// answer = 2
solution(k: 7, [1, 2, 3, 9, 10, 12])


//: [Next](@next)
