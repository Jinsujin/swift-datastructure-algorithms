//: [Previous](@previous)

import Foundation

/*: ## 트라이(Trie)
 

 */

class Node {
    var key: Character?
    weak var parent: Node?
    var children: [Character: Node] = [:]
    
    // 단어가 완성되었나 표시
    var isFinish = false
    
    init(key: Character? = nil, parent: Node? = nil) {
        self.key = key
        self.parent = parent
    }
}

class TrieTree {
    private let root: Node
    
    init() {
        root = Node(key: nil, parent: nil)
    }
    
    func insert(_ word: String) {
        var currentNode = root
        
        for w in Array(word) {
            if currentNode.children[w] == nil {
                currentNode.children[w] = Node(key: w, parent: currentNode)
            }
            // 다음 노드로 넘어간다
            currentNode = currentNode.children[w]!
        }
        // 단어가 완성되었음을 표시
        currentNode.isFinish = true
    }
    
    // TODO: - 깊이 우선 탐색(DFS) 로 해당 단어로 시작하는 모든 단어를 찾는다
    
    func isContain(_ word: String) -> Bool {
        var currentNode = root
        for w in word {
            guard let childNode = currentNode.children[w] else {
                return false
            }
            currentNode = childNode
        }
        return currentNode.isFinish
    }
}

let text = "가나다"
let aa = Array(text)
//print(aa.self)

let tree = TrieTree()
tree.insert(text)
tree.isContain("가나다라")


/*: ## 문자열 뒤집기
 
 짝수 단어인 경우: Stevoy
 middle = 6/2 = 3
 0 <-> 5 (N-1)
 1 <-> 4 (N-2)
 2 <-> 3 (N-3)
=> [0, 1, 2] middle-1 만큼 반복

 홀수 단어인 경우: Hevio
 middle = 5/2 = 2
 0 <-> 4 (N-1)
 1 <-> 3 (N-2)
 (2 는 바꿀필요 없다)
 => [0, 1] middle -1 만큼 반복
 
 */
func reverse(_ word: String) -> String {
    var result = Array(word)
    let middle = word.count / 2
    var rightIndex = word.count - 1
    
    for leftIndex in 0..<middle {
        result.swapAt(leftIndex, rightIndex)
        rightIndex -= 1
    }
    
    return String(result)
}

reverse("Hello")
reverse("Stevoy")


/*: ## 네트워크(프로그래머스)
 연결된 네트워크 개수 구하기
 
 - 방문한 노드는 건너띄고, 방문하지 않았다면 dfs 탐색
 - bfs 탐색시 연결된 노드들을 모두 방문으로 바꾸고 결과 갯수 + 1
 */

func solution(_ n: Int, _ computers: [[Int]]) -> Int {
    var result = 0
    var visited = Array(repeating: false, count: n)

    func dfs(_ node: Int) {
        visited[node] = true
        for j in 0..<n {
            if computers[node][j] == 1 && !visited[j] {
                dfs(j)
            }
        }
    }
    
    for node in 0..<n {
        if !visited[node] {
            dfs(node)
            result += 1
        }
    }
    
    return result
}


// 결과: 2
solution(3, [[1, 1, 0], [1, 1, 0], [0, 0, 1]])

// 결과: 1
solution(3, [[1, 1, 0], [1, 1, 1], [0, 1, 1]])


//: [Next](@next)
