//: [Previous](@previous)

import Foundation


// Union&Find: 친구인가
func solution(n: Int, m: Int, _ arr: [[Int]]) -> Bool {
    // 1. 그래프 초기화
    var graph = Array(repeating: 0, count: n+1)
    for i in 1...9 {
        graph[i] = i
    }
    // 2. 친구연결
    for i in 0..<m {
        union(a: arr[i][0], b: arr[i][1])
    }
    // 3. 친구인지 판별
    let fa = find(arr[m][0])
    let fb = find(arr[m][1])
    return fa == fb
    
    // node 가 속한 집합 노드번호를 반환
    func find(_ node: Int) -> Int {
        if graph[node] == node { return node }
        
        // 일렬로 노드를 연결하므로 탐색횟수가 크다
        // [0, 2, 3, 4, 5, 5, 7, 8, 9, 9]
//        return find(graph[node])
        
        // 반환값을 배열에 저장해 경로를 압축=> 시간복잡도 감소
        // [0, 4, 4, 5, 5, 5, 7, 8, 9, 9]
        graph[node] = find(graph[node])
        return graph[node]
    }
    
    // a, b 노드를 한 집합으로 만든다
    func union(a: Int, b: Int) {
        // 1. 두 노드가 하나의 집합인지 판별한다
        let fa = find(a)
        let fb = find(b)
        if fa != fb { graph[fa] = fb }
    }
}

solution(n: 9, m:7,
         [[1,2],[2,3], [3,4], [1,5], [6,7], [7,8], [8,9], [3,8]])

// 최소 스패닝트리. Union&Find: 원더랜드
func solution2(v: Int, e: Int, _ input: [[Int]]) -> Int {
    var answer = 0
    // Union&Find 준비
    var graph = Array(repeating: 0, count: v+1)
    for i in 1...v { graph[i] = i }
    
    //1. 비용을 기준으로 오름차순 정렬: 최소비용을 먼저 선택해야하므로(그리디)
    let sortedArr = input.sorted(by: { $0[2] < $1[2] } )
    
    for elem in sortedArr {
        let aNode = elem[0]
        let bNode = elem[1]
        // 1. 같은 집합인지 검사.
        // 이미 한 집합이라면 연결을 건너뛴다(비용을 오름차순 정렬했기 떄문에, 이미 최적의 해를 찾았다
        let fa = find(aNode)
        let fb = find(bNode)
        if fa == fb { continue }
        
        // 2. 같은 집합이 아니라면 노드를 연결하고, 가중치를 정답에 더한다
        union(a: aNode, b: bNode)
        answer += elem[2]
    }
    return answer
    
    func find(_ node: Int) -> Int {
        if graph[node] == node { return node }
//        return find(graph[node])
        graph[node] = find(graph[node])
        return graph[node]
    }
    func union(a: Int, b: Int) {
        let fa = find(a)
        let fb = find(b)
        if fa != fb { graph[fa] = fb }
    }
}

// 정답: 196
// 도시수(node), 도로수(edge), (노드a, 노드b, 가중치)
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
