//: [Previous](@previous)

import Foundation

// Keys and Rooms [Leetcode]
// 모든 방에 방문할 수 있으면true
func solution(_ rooms: [[Int]]) -> Bool {
    
    var check = Array(repeating: false, count: rooms.count)
    var queue = [Int]()
    queue.append(0)
    check[0] = true
    
    while(!queue.isEmpty) {
        let current = queue.removeFirst()
        
        for next in rooms[current] {
            if check[next] { continue }
            queue.append(next)
            check[next] = true
        }
    }
    return !(check.filter({ $0 == false} ).count > 0)
}
solution([[1],[2],[3],[]]) //true
solution([[1,3],[3,0,1],[2],[0]])//false

// Keys and Rooms- DFS 풀이
func solution1_2(_ rooms: [[Int]]) -> Bool {
    var check = Array(repeating: false, count: rooms.count)
    check[0] = true
    dfs(0)
    
    func dfs(_ roomNum: Int) {
        check[roomNum] = true
        
        for key in rooms[roomNum] {
            if check[key] { continue }
            dfs(key)
        }
    }
    return !(check.filter({$0==false}).count > 0)
}

//solution1_2([[1],[2],[3],[]]) //true
//solution1_2([[1,3],[3,0,1],[2],[0]])//false

// Keys and Rooms- Union&Find 풀이
// ❌ Union&Find 는 양방향으로 방을 연결하므로 실패
func solution1_3(_ rooms: [[Int]]) -> Bool {
    var graph = Array(repeating: 0, count: rooms.count)
    
    for i in 0..<rooms.count {
        graph[i] = i
    }
    
    // 1. rooms 를 loop 돌면서 union(연결) 한다
    for i in 0..<rooms.count {
        for key in rooms[i] {
            print(i, "->", key)
            union(a: i, b: key)
        }
    }
    
    //2.모든 노드가 연결되었는지 확인한다.
    for i in 0..<rooms.count-1 {
        let fa = find(i)
        let fb = find(i+1)
        if fa != fb { return false }
    }
    print(graph)
    return true
        
    func find(_ node: Int) -> Int {
        if node == graph[node] { return node }
        graph[node] = find(graph[node])
        return graph[node]
    }
    
    func union(a: Int, b: Int) {
        let fa = find(a)
        let fb = find(b)
        if fa != fb { graph[fa] = fb }
    }
}

//solution1_3([[1],[2],[3],[]]) //true
//solution1_3([[1,3],[3,0,1],[2],[0]])//false

// 정답: false
solution1_3([[1],[],[0,3],[1]]) // true

//: [Next](@next)
