//: [Previous](@previous)

import Foundation


/*
 Heap 힙
 최대, 최소 원소를 빠르게 찾아야 할때 사용.
 완전 이진 트리(complete binary tree)에 속하는 자료구조
 완전 이진 트리는 왼쪽 자식 노트부터 노드가 생성 되기 때문에, array를 사용하여 구현할 수 있다.
 
 - 최대힙: 자신의 자식 노드 값이 나보다 작거나 같다 (RootNode == 최대값)
    최대 원소를 빠르게 꺼낼 수 있다
 - 최소힙: 사긴의 자식 노드 값이 나보다 크거나 같다 (RootNode == 최소값)
    최소 원소를 빠르게 꺼낼 수 있다
 
 자신의 자식 노드 인덱스 = (자신의 인덱스 * 2) + 1, (자신의 인덱스 * 2) + 2
 자식의 부모 노드 인덱스 = 자식의 인덱스 / 2
 

 /// 복잡도
-heapify(힙구성): NlogN
 하나의 원소n을 삽입하는데 logN만큼의 시간이 걸리므로, 비어있는 힙에 n개 원소를 차례대로 삽입한다면 NlogN
insert(삽입): logN
    갯수N 의 log에 비례하는 복잡도를 가진다
remove(삭제): logN
 
/// 힙 응용
 - 정렬 heapsort
 - 우선 순위 큐 priority queue
    큐에 들어갈때는 순서없이 들어가지만, 빠져나올때는 우선순위에 따라 빠져나옴
    (예. 더맵게 문제의 스코빌 지수)
 **/


//Comparable: 비교가 가능한 데이터면 담을수 있도록.
struct MaxHeap<T: Comparable> {
    var heap: Array<T> = []
    
    init(_ data: T) {
        heap.append(data)
    }
    
    var isEmpty: Bool {
        return heap.isEmpty
    }
    
    private func parentIndex(_ child: Int) -> Int {
        return child/2
    }
    
    private func leftChildIndex(_ parent: Int) -> Int {
        return parent * 2 + 1
    }
    
    private func rightChildIndex(_ parent: Int) -> Int {
        return parent * 2 + 2
    }
    
    private func isMoveUp(_ insertIndex: Int) -> Bool {
        if insertIndex <= 0 { // root node
            return false
        }
        return heap[insertIndex] > heap[parentIndex(insertIndex)]
    }
    
    mutating func insert(_ data: T) {
        if heap.count == 0 {
            heap.append(data)
            return
        }
        
        heap.append(data)
        
        // 자신의 현재 인덱스
        var insertIndex = heap.count - 1
        
        while isMoveUp(insertIndex) {
            let pIndex = parentIndex(insertIndex)
            heap.swapAt(insertIndex, pIndex)
            insertIndex = pIndex
        }
    }
}

var heap = MaxHeap(20)
heap.insert(5)
heap.insert(60)
heap.insert(10)

print(heap)

//: [Next](@next)
