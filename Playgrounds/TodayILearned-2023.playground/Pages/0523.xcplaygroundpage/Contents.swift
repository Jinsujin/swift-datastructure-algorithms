//: [Previous](@previous)

import Foundation


// 순열 구하기
// N 에서 M 개를 뽑아 일렬로 모두 나열하기
func solution(input: [Int], M: Int) {
    var check = Array(repeating: false, count: input.count)
    var ans = Array(repeating: 0, count: M)
    dfs(0)
    
    func dfs(_ depth: Int) {
        if depth == M {
            var temp = ""
            for i in ans {
                temp += "\(i)"
            }
            print(temp)
            return
        }
        
        for i in 0..<input.count {
            let num = input[i]
            // 이미 선택한 번호라면 건너뜀
            if check[i] { continue }
            ans[depth] = num
            check[i] = true
            dfs(depth + 1)
            check[i] = false
        }
    }
}

//
solution(input: [3,6,9], M: 2)
//36
//39
//63
//69
//93
//96

// 조합구하기
func solution4(n: Int, m: Int) {
    var selectNums = Array(repeating: 0, count: m)
    dfs(0, startIdx: 1)
    
    func dfs(_ depth: Int, startIdx: Int) {
        if depth == m {
            var temp = ""
            for n in selectNums {
                temp += "\(n)"
            }
            print(temp)
            return
        }
        if startIdx > n { return }
        for i in startIdx...n {
            selectNums[depth] = i
            dfs(depth + 1, startIdx: i + 1)
        }
        
    }
}

solution4(n: 4, m: 2)
//12
//13
//14
//23
//24
//34

// 출발점: (1, 1) 도착점은 (7, 7)
func miro(_ grid: [String]) -> Int {
    let M = 7
    var graph = Array(repeating: Array(repeating: 0, count: M), count: M)
    
    for i in 0..<grid.count {
        // nil 일 수 있는 데이터는 compactMap 으로 변환한다!
        let col = grid[i].split(separator: "").compactMap({ Int($0) })
        graph[i] = col
    }
    var count = 0
    let dirX = [1, -1, 0, 0]
    let dirY = [0, 0, 1, -1]
    let goal = 6
    
    // 중요!: 시작할때 시작좌표 체크해줘야 한다
    graph[0][0] = 1
    dfs(x: 0, y: 0)
    
    func dfs(x: Int, y: Int) {
        if x == goal && y == goal {
            count += 1
            return
        }
        
        for i in 0..<4 {
            let nextX = x + dirX[i]
            let nextY = y + dirY[i]
            
            // 벗어난 범위 체크
            if nextX < 0 || nextX >= M || nextY < 0 || nextY >= M {
                continue
            }
            // 이미 지나온 곳인지 체크
            if graph[nextX][nextY] != 0 { continue }
            
            graph[nextX][nextY] = 1
            dfs(x: nextX, y: nextY)
            graph[nextX][nextY] = 0
        }
    }
    return count
}

let grid = ["0000000", "0111110", "0001000", "1101011", "1100001", "1101100", "1000000"]
// 8
miro(grid)

//: [Next](@next)
