//: [Previous](@previous)

import Foundation


/*
 우선순위 큐
 (sink and swim methods 기법은 세지웍과 웨인의 저서 Algorithms 4판 2.4 절 내용 참고)
 
 큐와 유사하지만, 각각의 요소가 우선순위 값을 지니고 있다.
 더 높은 우선순위를 지닌 요소가 낮은 순위 요소보다 먼저 큐에서 빠져나와 출력된다.

 큐에 놓인 데이터의 처리 순서를 조절해야 할때 유용.
 응급실 처럼 환자들이 들어오는 순서대로 처리하되, 심한 부상이 있는 환자는 먼저 치료받는 경우 사용됨.
 예)
 - 최선-최초 검색 알고리즘 Best-first search algorithm
    가중치가 적용된 그래프에 있는 두개의 노드 중 최단거리를 찾을때 활용. 우선순위 큐는 미탐험 경로를 추적할때 사용
 - 프림 알고리즘 Prim algorithm
    가중치가 적용된 비지도학습 그래프에서 폭이 최소인 트리를 찾는데 활용
 
 binary Heap(이진 힙)
 enqueue, dequeue 를 실행시 logN의 복잡성
 
 
 참고 블로그
 https://algs4.tistory.com/48
 Binary heap 에서는 부모의 key 는 자식의 key 보다 크거나 같다.
 만약 위의 Binary heap 의 규칙에 위배되는 상황이 생기면 다음의 swim ( ) 과 sink ( ) 메쏘드로 heap 정렬이 되게한다.
 -  swim ( )  : 어떤 자식의 key 가 부모의 key 보다 커지면 자식의 key 를 부모의 key 와 교환한다.
 -  sink ( ) : 부모의 key 가 자식의 key 보다 작아지면 자식의 key 중에서 큰 쪽과 교환한다.
 - insert ( ) : N+1 위치에 새로운 key 를 저장하고 swim ( ) 시켜서 적당한 위치에 오게하다.
 - delMax ( ) : 1 번과 N 번 key를 교환하고 1 번 위치의 key 를 sink ( ) 시켜서 적당한 위치에 오게한다.  N 번위치에 있는 값을 반환하고 크기를 N - 1 로 줄인다.

 
 
 **/

public struct PriorityQueue<T: Comparable> {
    fileprivate var heap = [T]()
    private let ordered: (T, T) -> Bool
    public init(ascending: Bool = false, startingValues: [T] = []) {
        if ascending {
            ordered = { $0 > $1 }
        } else {
            ordered = { $0 < $1 }
        }
        
        heap = startingValues
        var i = heap.count/2 - 1
        while i >= 0 {
            sink(i)
            i -= 1
        }
    }
    
    public var count: Int { return heap.count }
    
    public var isEmpty: Bool { return heap.isEmpty }
    
    /// 새 요소 추가
    public mutating func push(_ element: T) {
        heap.append(element)
        swim(heap.count - 1)
    }
    
    
    /// 최우선순위의 요소를 큐에서 제거하고 반환
    public mutating func pop() -> T? {
        if heap.isEmpty { return nil }
        if heap.count == 1 { return heap.removeFirst() }
        
        // swift 2 호환을 위해, 동일한 위치에 있는 두개의 요소를 swap() 으로 호출하지 않도록 코드 추가
        heap.swapAt(0, heap.count - 1)
        let temp = heap.removeLast()
        sink(0)
        return temp
    }
    
    /// 특정 아이템의 첫번째 반환 내용을 삭제
    public mutating func remove(_ item: T) {
        
        if let index = heap.firstIndex(of: item) {
            heap.swapAt(index, heap.count - 1)
            heap.removeLast()
            swim(index)
            sink(index)
        }
    }
    
    /// 특정 아이템의 모든 반환 내용 삭제
    public mutating func removeAll(_ item: T) {
        var lastCount = heap.count
        remove(item)
        while (heap.count < lastCount) {
            lastCount = heap.count
            remove(item)
        }
    }
    
    public func peek() -> T? {
        return heap.first
    }
    
    // 큐에서 모든 요소를 제거
    public mutating func clear() {
        heap.removeAll(keepingCapacity: false)
    }
    
    private mutating func sink(_ index: Int) {
        var index = index
        while 2 * index + 1 < heap.count {
            var j = 2 * index + 1
            if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) { j += 1 }
            if !ordered(heap[index], heap[j]) { break }
            heap.swapAt(index, j)
            index = j
        }
    }
    
    private mutating func swim(_ index: Int) {
        var index = index
        while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
            heap.swapAt((index - 1) / 2, index)
            index = (index - 1) / 2
        }
    }
}

// 초기화
var priorityQueue = PriorityQueue<String>(ascending: true)

// 시작값으로 초기화
priorityQueue = PriorityQueue<String>(ascending: true, startingValues: ["black", "orange", "red", ""])

var a = priorityQueue.pop()
a = priorityQueue.pop()




//: [Next](@next)
