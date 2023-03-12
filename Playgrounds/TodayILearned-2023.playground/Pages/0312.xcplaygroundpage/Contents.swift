//: [Previous](@previous)

import Foundation

/*: ## (복습)단어변환
 
 */
struct WordItem {
    let word: String
    let depth: Int
}

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
    if !words.contains(target) {
        return 0
    }
    
    func canChange(from str1: String, to str2: String) -> Bool {
        var diff = 0
    
        for i in 0..<str1.count {
            if str1[i] != str2[i] {
                diff += 1
            }
        }
        return diff == 1
    }
    
    func bfs(_ begin: String, _ depth: Int) -> Int {
        var queue = [WordItem]()
        queue.append(WordItem(word: begin, depth: depth))
        
        // 1개만 다를때만 큐에 넣는다
        while(!queue.isEmpty) {
            let current = queue.removeFirst()
            
            for w in words {
                if !canChange(from: current.word, to: w) {
                    continue
                }
                
                if target == w {
                    return current.depth + 1
                }
                
                queue.append(WordItem(word: w, depth: current.depth+1))
                
            }
        }

        return 0
    }
    
    return bfs(begin, 0)
}

extension String {
    subscript(_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

// 4
solution("hit","cog",["hot", "dot", "dog", "lot", "log", "cog"])

// 0: 변환불가
solution("hit","cog",["hot", "dot", "dog", "lot", "log"])

/*: ## (복습) 네트워크
 
 - 음료수 얼려먹기와 똑같이 풀 수있다
 - 시간복잡도 O(노드수 + 간선수)
 */


//
//func solution(_ n: Int, _ computers: [[Int]]) -> Int {
//    var visited = Array(repeating: false, count: n)
//    var count = 0
//
//    func dfs(_ start: Int) {
//        visited[start] = true
//
//        for j in 0..<n {
//            if !visited[j] && computers[start][j] == 1 {
//                dfs(j)
//            }
//        }
//    }
//
//    for i in 0..<n {
//        if !visited[i] {
//            dfs(i)
//            count += 1
//        }
//    }
//    return count
//}


func solution(_ n: Int, _ computers: [[Int]]) -> Int {
    var count = 0
    var grid = computers
    
    func dfs(_ x: Int, _ y: Int) {
        
        if !(x >= 0 && x < n && y >= 0 && y < n) {
//            print("범위를 벗어남", x, y)
            return
        }
        
        // 1일때만 이동가능
        if grid[x][y] != 1 {
            return
        }
        // 방문체크
        grid[x][y] = 0

        dfs(x+1, y)
        dfs(x-1, y)
        dfs(x, y+1)
        dfs(x, y-1)
    }
    
    for i in 0..<n {
        for j in 0..<n {
            if grid[i][j] == 1 {
                dfs(i, j)
                count += 1
            }
        }
    }
    return count
}

// 결과: 2
solution(3, [[1, 1, 0], [1, 1, 0], [0, 0, 1]])

// 결과: 1
solution(3, [[1, 1, 0], [1, 1, 1], [0, 1, 1]])

/*: (복습) 음료수 얼려먹기
 몇개의 음료수를 얼려먹을수있나?
 - 0 일때 이동가능
 - 1: 칸막이
 - 이동가능한 범위: 상하좌우
 */
// result = 3
let input = [[0,0,1,1,0],
            [0,0,0,1,1],
            [1,1,1,1,1],
            [0,0,0,0,0]]

let N = 4
let M = 5

func solution(_ input: [[Int]]) -> Int {
    var result = 0
    var grid = input
    
    func dfs(_ x: Int, _ y: Int) -> Bool {
        
//        if (x <= -1 || x >= N || y <= -1 || y >= M) {
        if !(x >= 0 && x < N && y >= 0 && y < M) {
//            print("범위를 벗어남", x, y)
            return false
        }
 
        if grid[x][y] != 0 {
            return false
        }
        // 방문체크
        grid[x][y] = 1
        
        dfs(x+1, y)
        dfs(x-1, y)
        dfs(x, y+1)
        dfs(x, y-1)
        return true
    }
    
    
    for y in 0..<N {
        for x in 0..<M {
            if grid[y][x] == 0 {
                dfs(y, x)
                result += 1
            }
        }
    }
    
    return result
}

solution(input) // 3

/*: 덧칠하기(프로그래머스)
 테스트20번째 실패: 런타임 에러
 */

//func solution(_ n:Int, _ m:Int, _ section:[Int]) -> Int {
//    // 1. 칠할 벽배열을 만든다
//    var wall = Array(repeating: false, count: n+1)
//    var result = 0
//
//    for s in section {
//        wall[s] = true
//    }
//
//    // 2. 벽 칠하기
//    // 칠할 벽을 처음부터 탐색 -> 칠할곳을 찾았다!
//    var paintCount = m
//    var isPainting = false // 칠하는 도중인가
//    for i in 1..<wall.count {
//        if isPainting && paintCount <= 0 {
//            isPainting = false
//            paintCount = m
//        }
//
//        if wall[i] == true { // 칠하기 시작할 부분을 찾음
//            if !isPainting {
//                isPainting = true
//                result += 1
//            }
//            wall[i] = false
//        }
//
//        if isPainting {
//            paintCount -= 1
//        }
//    }
//
//    return result
//}


func solution(_ n:Int, _ m:Int, _ section:[Int]) -> Int {
    var count = 0
    var paintingArea = 0
    
    for i in 0..<section.count {
        if paintingArea < section[i] {
            paintingArea = (section[i] + m) - 1
            count += 1
        }
    }
    return count
}

// 2
solution(8,4,[2,3,6])

// 1
solution(5,4,[1,3])

// 4
solution(4,1,[1,2,3,4])


//: [Next](@next)
