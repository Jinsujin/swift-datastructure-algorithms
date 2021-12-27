//: [Previous](@previous)

import Foundation

//: ### Stack
struct Stack<T> {
    var elements = [T]()
    
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func pop() -> T? {
        if isEmpty {
            return nil
        }
        return self.elements.removeLast()
    }
    
    func peek() -> T? {
        return self.elements.last
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
}


struct StackIterator<T>: IteratorProtocol {
    var currentElement: [T]
    
    mutating func next() -> T? {
        if !self.currentElement.isEmpty {
            return currentElement.removeLast()
        }
        return nil
    }
}

extension Stack: Sequence {
    func makeIterator() -> StackIterator<T> {
        return StackIterator(currentElement: self.elements)
    }
}


//: ### Queue
struct Queue<T> {
    var elements = [T]()
    
    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        return self.elements.removeFirst()
    }
    
    func peek() -> T? {
        return self.elements.first
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
}


struct QueueIterator<T>: IteratorProtocol {
    var currentElement: [T]
    
    mutating func next() -> T? {
        if !self.currentElement.isEmpty {
            return currentElement.removeFirst()
        }
        return nil
    }
}

extension Queue: Sequence {
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator(currentElement: self.elements)
    }
}




/*:
 ## BFS(너비 우선 탐색)
 - 모든 간선(Edge)의 가중치가 같을떄, 최단거리 구하는 알고리즘
 - 시작 정점(Node)을 기준으로 가장 가까운 정점을 먼저 방문 (방문 춘서가 최단거리에 영향)
 - 큐 사용(선입 선출 원리로 탐색)
 
 1. 큐에 시작노드를 넣는다(방문 체크)
 2. 큐에서 시작노드를 뺀다
 3. 시작노드와 연결된 노드들을 차례로 큐에 넣는다.(방문 체크)
 4. 2-3을 반복한다(큐가 빌때까지 == 더이상 갈 곳이 없을때 까지)
 
 - NOTE:
    - 돌아가는지 확인 필요
 */
func bfs() {
    // 방문 체크
    var check = [Bool](repeating: false, count: 100)
    // 인접 리스트
    var v = [Int: [Int]]()
    
    var queue = Queue<Int>()
    // 1. 시작노드 삽입 (방문체크)
    queue.enqueue(1)
    check[1] = true
    
    // 2. 큐가 빌때까지 탐색한다
    while(!queue.isEmpty) {
//        let node = queue.dequeue()
        guard let node = queue.dequeue(),
            let findNode = v[node] else { return }
        for i in 0..<findNode.count {
            let next = findNode[i]
            if (check[next]) { continue } // 이미 방문한 노드인 경우 처리하지 않는다
            check[next] = true
            queue.enqueue(next)
        }
    }
}





/*:
 ### 인접 리스트 만들기
 양방향 연결
 input:
 1,2 : 1과 2는 양방향 연결되어 있다.
 1,3
 1,4
 2,4
 3,4
 
인접 리스트 변환 결과.
 (만약, 정점번호가 작은순 방문이라면 리스트의 정렬이 필요하다)
 [
     1: [ 2,3,4],
     2: [1,4],
     3: [1,4],
     4: [1,2,3]
 ]
 
 */
var nodeList = [Int: [Int]]()

func list(_ list:[[Int]]) {

    for i in 1..<10 {
        nodeList[i] = []
    }
    // 양방향인 경우, 서로 연결해준다.
    for item in list {
        nodeList[item[0]]?.append(item[1])
        nodeList[item[1]]?.append(item[0])
    }
    
    for i in 1...list.count {
        nodeList[i]?.sort()
    }
}

list([[1,2], [1,3], [1,4], [2,4], [3,4]])

/*:
 - NOTE:
    - 돌아가는지 확인 필요
 */
var visited = [Bool](repeating: false, count: 10)

func dfs(_ v: Int) {
    print(v)
    visited[v] = true
    
    guard let node = nodeList[v] else { return }
    
    for i in 0..<node.count {
        let next: Int = node[i]
        if (visited[next] == false) {
            dfs(next)
        }
    }
}



/*:
 ### 강의-동전문제 (Dynamic Programming)
 3원, 5원이 있을때 N을 지불할 수 있는 최소 동전 갯수는?
 - NOTE:
    - 문제 분석 필요
 */
func solutionMoney(_ money: Int) -> Int {
    let X = -1
    let arr = [Int](repeating: 0, count: money)
    var dp = [0, X, X, 1, X, 1]
    dp.append(contentsOf: arr)

    // index 0~5 까지는 이미 값이 있으므로, 6부터 값을 넣는다
    for i in 6...money {
        let dp3 = dp[i-3]
        let dp5 = dp[i-5]
        // 3,5원 모두 지불할 수 없다면, i번째도 지불할 수 없다.
        if(dp3 == X && dp5 == X) {
            dp[i] = X
            continue
        }
        // 3,5원 중 하나가 X일때, X가 아닌 값이 있는 값(max)으로 i번째를 채운다.
        if(dp3 == X || dp5 == X) {
            dp[i] = max(dp3 + 1, dp5 + 1)
            continue
        }
        // 3,5원 중 최소 동전 갯수를 i번째에 넣는다
        dp[i] = min(dp3 + 1, dp5 + 1)
    }
    return dp[money]
}

solutionMoney(20)

/*:
 ### 강의-배낭 (Dynamic Programming)
 - NOTE:
    - 문제 분석 필요
 */
func solutionBag(_ k: Int, jewels:[[Int]]) -> Int {
    // 보석갯수: j.count
    // 배낭무게: k
    var dp: [[Int]] = Array(repeating:Array(repeating:0, count: 100), count: 10)
    
    // index 1 부터 계산하기 위해 0을 값으로 index0 에 채운다
    var jewel_w = [Int](repeating: 0, count: 1) // 보석 무게
    var jewel_p = [Int](repeating: 0, count: 1) // 보석 값어치
    for jewel in jewels {
        jewel_w.append(jewel[0])
        jewel_p.append(jewel[1])
    }
    
    for i in 1...jewels.count { // 보석 갯수
        for j in 1...k { // 배낭 무게
            // 현재 보석보다 배낭 무게가 작다면 =>
            // 현재보석은 배낭에 들어갈 수 없다. == 위에칸에서 값을 가져와 넣어준다
            if(j < jewel_w[i]) {
                dp[i][j] = dp[i - 1][j]
                continue
            }
            dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - jewel_w[i]] + jewel_p[i])
        }
    }
    return dp[jewels.count][k]
}

solutionBag(14, jewels: [[2,40], [5,110], [10,200], [3,50]])






//: [Next](@next)
