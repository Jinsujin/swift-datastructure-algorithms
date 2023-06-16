//: [Previous](@previous)

import Foundation

// 우선순위 큐(Heap)
final class MaxPriorityQueue<T> {
    var values = [Elem]()
    typealias Elem = (val: T, priority: Int)
    var isEmpty: Bool { values.isEmpty }
    
    func enqueue(_ val: T, _ priority: Int) {
        values.append((val, priority))
        bubbleUp()
    }
    
    private func bubbleUp() {
        var currentIdx = values.count - 1
        
        while(currentIdx > 0) {
            let parentIdx = (currentIdx-1)/2
            if values[currentIdx].priority <= values[parentIdx].priority {
                break
            }
            values.swapAt(currentIdx, parentIdx)
            currentIdx = parentIdx
        }
    }
    
    /**
     1. 빈배열이라 값이 없는경우
     2.last 를 제거했을때 빈배열인 경우
     3. 원소2개 이상인경우
     */
    func dequeue() -> Elem? {
        guard let maxValue = values.first else {
            return nil
        }
        let last = values.removeLast()
        if values.count == 0 { return last }
        
        // 원소2개 이상인경우
        values[0] = last
        sinkDown()
        return maxValue
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
                if values[leftChildIdx].priority > currentPriority {
                    swapIdx = leftChildIdx
                }
            }
            
            if rightChildIdx < length {
                // swapIdx 에 값이 이미 있지만, right 이 더 큰값인 경우
                // swapIdx 에 값이 없고, right 가 더 큰값인 경우
                if (swapIdx == nil && values[rightChildIdx].priority > currentPriority)
                    || (swapIdx != nil && values[rightChildIdx].priority > values[swapIdx!].priority) {
                    swapIdx = rightChildIdx
                }
            }
            
            guard let swapIdx = swapIdx else { break }
            values.swapAt(currentIdx, swapIdx)
            currentIdx = swapIdx
        }
    }
}


final class MinPriorityQueue<T> {
    var values = [Elem]()
    typealias Elem = (val: T, priority: Int)
    var isEmpty: Bool { values.isEmpty }
    
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



let heap = MaxPriorityQueue<Int>()
heap.enqueue(55,55)
heap.enqueue(39,39)
heap.enqueue(41,41)
heap.enqueue(18,18)
heap.enqueue(27,27)
heap.enqueue(33,33)

//print(heap.values) // [55, 39, 41, 18, 27, 33]

heap.dequeue() //55
heap.dequeue() //41
heap.dequeue() //39
heap.dequeue() //33
heap.dequeue() //27
heap.dequeue() //18
heap.dequeue() //nil

// (priority queue) 최대 수입 스케쥴
func solution1_2(_ input: [[Int]]) -> Int {
    var arr = input.sorted(by: { $0[1] > $1[1] })
    let maxDay = arr.first![1] //3
    var answer = 0
    let pQ = MaxPriorityQueue<Int>()
        
    for i in stride(from: maxDay, through: 1, by: -1) {
        for elem in arr {
            if elem[1] < i { break }
            let temp = arr.removeFirst()
            pQ.enqueue(temp[0], temp[0])
        }
        if !pQ.isEmpty { answer += pQ.dequeue()!.val }
    }
    return answer
}


// 150
solution1_2([[50, 2],
[20, 1],
[40, 2],
[60, 3],
[30, 3],
[30, 1]])

// (최소 스패닝트리) 원더랜드: priority queue 사용
func solution2(v: Int, e: Int, _ input: [[Int]]) -> Int {
    var answer = 0
    
    // 트리 노드로 선택했는지 검사할 체크 배열 준비: 사이클을 안만들기 위함
    var check = Array(repeating: false, count: v+1)
    
    // priority queue 준비: 비용이 가장 적은 간선을 선택하기 위함
    var pQ = MinPriorityQueue<Int>()
    
    var graph = [Int: [(vex: Int, cost: Int)]]()
    for i in 1...v { graph[i] = [(vex: Int, cost: Int)]() }
    
    //1. 그래프를 만든다
    for elem in input {
        let a = elem[0]
        let b = elem[1]
        let cost = elem[2]
        graph[a]?.append((b, cost))
        graph[b]?.append((a, cost))
    }
    
    // 2. 1 노드에서 부터 시작. 비용은 0
    pQ.enqueue(1, 0)
    
    // 3. 큐가 빌때까지 반복한다
    while(!pQ.isEmpty) {
        // 비용이 가장 작게드는 원소를 꺼낸다
        guard let current = pQ.dequeue() else { break }
        // 이미 선택했던 노드라면 건너뛴다
        if check[current.val] { continue }
        check[current.val] = true
        answer += current.priority
        
        // 연결된 노드들을 큐에 넣는다
        for elem in graph[current.val]! {
            if check[elem.vex] { continue }
            pQ.enqueue(elem.vex, elem.cost)
        }
    }
    return answer
}

// 196
solution2(v:9, e: 12,
[[1, 2, 12],
[1, 9, 25],
[2, 3, 10],
[2, 8, 17],
[2, 9, 8],
[3, 4, 18],
[3, 7, 55],
[4, 5, 44],
[5, 6, 60],
[5, 7, 38],
[7, 8, 35],
[8, 9, 15]])

//: [Next](@next)
