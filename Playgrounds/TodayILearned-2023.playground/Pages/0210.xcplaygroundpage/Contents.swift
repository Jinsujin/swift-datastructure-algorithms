//: [Previous](@previous)

import Foundation


//: # 복습

//: ### merge sort
func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 { return arr }
    
    // 1. 배열을 더 이상 안쪼개질때까지 반으로 나눈다
    let middle = arr.count / 2
    let leftArr = mergeSort(Array(arr[0..<middle]))
    let rightArr = mergeSort(Array(arr[middle..<arr.count]))
    // 2. 쪼갠 2개의 배열을 merge 한다
    return merge(leftArr, rightArr)
}

func merge(_ leftArr: [Int], _ rightArr: [Int]) -> [Int] {
    var result = [Int]()
    var li = 0
    var ri = 0
    while(li < leftArr.count && ri < rightArr.count) {
        let leftElem = leftArr[li]
        let rightElem = rightArr[ri]
        
        if leftElem < rightElem {
            result.append(leftElem)
            li += 1
        } else if leftElem > rightElem {
            result.append(rightElem)
            ri += 1
        } else {
            result.append(leftElem)
            li += 1
            result.append(rightElem)
            ri += 1
        }
    }
    
    while(li < leftArr.count) {
        result.append(leftArr[li])
        li += 1
    }
    
    while(ri < rightArr.count) {
        result.append(rightArr[ri])
        ri += 1
    }
    return result
}

//let array = [4,5,8,1,2,4]
//print(mergeSort(array))

//: ### BFS

func bfs(_ start: Int) {
    
    var q = [Int]()
    q.append(start)
    visited[start] = true
    
    while(!q.isEmpty) {
        // 큐에서 꺼낸것은, 해당지점으로 방문한 것
        let elem = q.removeFirst()
        print(elem)
        
        // 꺼낸 노드의 인접노드 반복(갈수있는곳 찾기)
        guard let nodes = graph[elem] else { return }
        
        for i in 0..<nodes.count {
            let currentNode = nodes[i]
            // 이미 방문한 경우
            if visited[currentNode] { continue }
            visited[currentNode] = true
            q.append(currentNode)
        }
    }
}



// 노드 index를 1부터 처리
var graph: [Int: [Int]] = [:]
(1...7).forEach { i in
    graph[i] = [Int]()
}

// 방문처리 체크할 배열.
// 노드는 1부터 index가 시작되므로 (노드 총갯수 + 1) = 8
var visited = Array(repeating: false, count: 8)


// MARK: -  양방향 edge 연결
// 1 <-> 2
graph[1]?.append(2)
graph[2]?.append(1)

// 1 <-> 3
graph[1]?.append(3)
graph[3]?.append(1)

// 2 <-> 3
graph[2]?.append(3)
graph[3]?.append(2)

// 2 <-> 4
graph[2]?.append(4)
graph[4]?.append(2)

// 2 <-> 5
graph[2]?.append(5)
graph[5]?.append(2)

// 3 <-> 6
graph[3]?.append(6)
graph[6]?.append(3)

// 3 <-> 7
graph[3]?.append(7)
graph[7]?.append(3)

// 4 <-> 5
graph[4]?.append(5)
graph[5]?.append(4)

// 7 <-> 6
graph[6]?.append(7)
graph[7]?.append(6)


print(graph)

bfs(1)
// print: 1,2,3,4,5,6,7


//: [Next](@next)
