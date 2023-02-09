//: [Previous](@previous)

import Foundation

//: ## 복습
/*:
 병합정렬
 1. 입력 배열을 left, right 나눈다
 2. 요소가 1개가 될때까지 mergeSort 재귀한다
 3. 요소가 1개가 되었다면 merge 한다
 
 merge
 1. left, right 배열을 인자로 받는다. 반복문을 돌면서 두 배열을 비교해 더 작은값을 result 배열에 넣고 넣은 배열의 index+=1
 2. 반복문이 끝나고 난 후, index 가 인자로 받은 배열 갯수보다 작은경우 남아있는 요소가 있는 것 => result 배열에 넣는다
 */

func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 { return arr }
    let middle = arr.count / 2
    let leftArr = mergeSort(Array(arr[0..<middle]))
    let rightArr = mergeSort(Array(arr[middle..<arr.count]))
    return merge(leftArr, rightArr)
}

func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int] {
    var result = [Int]()
    result.reserveCapacity(leftArray.count + rightArray.count)

    var leftIndex = 0
    var rightIndex = 0

    while(leftIndex < leftArray.count && rightIndex < rightArray.count) {
        let leftElement = leftArray[leftIndex]
        let rightElement = rightArray[rightIndex]

        if leftElement < rightElement {
            result.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            result.append(rightElement)
            rightIndex += 1
        } else {
            result.append(leftElement)
            leftIndex += 1
            result.append(rightIndex)
            rightIndex += 1
        }
    }

    // 남아있는 요소 털기
    while (leftIndex < leftArray.count) {
        result.append(leftArray[leftIndex])
        leftIndex += 1
    }

    while (rightIndex < rightArray.count) {
        result.append(rightArray[rightIndex])
        rightIndex += 1
    }
    return result
}

let array = [3,4,1,7,2]

mergeSort(array)

/*: # BFS: 너비 우선 탐색
 - 시작지점으로부터 가까운 노드(거리 1)를 먼저 방문하고 점차 넓혀나가는 탐색 방식
 - 큐를 사용
 - ex) 미로찾기

 func bfs()
 1. 큐에 시작노드를 넣은채로 시작
 2. 방문을 체크한다
 3. 큐가 빌때까지 반복
    - 1. 큐에서 가장 앞에 노드를 뺀다.
    - 2. 뺀 노드의 인접 노드들중 이동할 수 있는지 확인한다
    - 3. 이동할 수 있다면, 큐에 넣는다.
 */

func bfs(_ start: Int) {
    var q = [Int]()
    q.append(start)
    visited[start] = true // 방문처리

    // 큐가 빌때까지 반복
    while(!q.isEmpty) {
        // 큐에서 꺼냈다 == 해당 지점으로 이동했다
        let current = q.removeFirst()
        print(current)
        
        guard let nodes = graph[current] else {
            continue
        }
        // 꺼낸 노드와 인접한 노드들을 돈다
        for i in 0..<nodes.count {
            let node = nodes[i]
            if visited[node] { // 이미 방문했다면 패스
                continue
            }
            // 아직 방문하지 않았다면
            visited[node] = true
            q.append(node)
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
