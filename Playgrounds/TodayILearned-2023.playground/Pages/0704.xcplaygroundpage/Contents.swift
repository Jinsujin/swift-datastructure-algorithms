//: [Previous](@previous)

import Foundation

// 비밀번호
// ❌(비효율적 코드) password 입력 하나마다 이중 for 문을 돌고있어서 시간초과가 날 수 있다.
func solution(_ keypad: [Int], _ pwd: String) -> Int {
    var grid = [[Int]]()
    var temp = [Int]()
    let n = 3
    for i in 0..<keypad.count {
        if i%n == 0 {
            temp = [keypad[i]]
            continue
        }
        temp.append(keypad[i])
        if i%n == 2 {
            grid.append(temp)
        }
    }
    
    // pwd 를 좌표로 변환
    var points = [(x: Int, y: Int)]()
    let intPwd = pwd.split(separator: "").compactMap({ Int($0) })
    for p in intPwd {
        for x in 0..<n {
            for y in 0..<n{
                if grid[x][y] == p {
                    points.append((x: x, y: y))
                    break
                }
            }
        }
    }
    
    let dirX = [-1,1,0,0, -1,-1,1,1]
    let dirY = [0,0,-1,1, -1,1,-1,1]
    
    // 시작지점은 무조건 거리 0 이므로, 다음 비밀번호부터 탐색
    var totalTime = 0
    for i in 1..<points.count {
        var distMap = Array(repeating: Array(repeating: 2, count: n), count: n)
        
        // 시작지점에서 8방향으로 이동가능하다면 거리 1, 나머지는 2
        let startPos = points[i-1]
        distMap[startPos.x][startPos.y] = 0
        for d in 0..<8 {
            let nextPos = (x: startPos.x + dirX[d], y: startPos.y + dirY[d])
            if nextPos.x < 0 || nextPos.x >= n || nextPos.y < 0 || nextPos.y >= n { continue }
            distMap[nextPos.x][nextPos.y] = 1
        }
        // 계산된 이동할 지점의 거리를 전체시간에 합산
        totalTime += distMap[points[i].x][points[i].y]
    }
    
    return totalTime
}

// ✅ 시간초과 해결
// [시작지점] -> [끝지점] 의 거리를 기록하는 2차원 배열 사용
func solution1_2(_ keypad: [Int], _ pwd: String) -> Int {
    var grid = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    let n = 3
    for i in 0..<n {
        for j in 0..<n {
            grid[i][j] = keypad[i * n + j]
        }
    }
    
    let dirX = [-1,1,0,0, -1,-1,1,1]
    let dirY = [0,0,-1,1, -1,1,-1,1]
    let num = 9
    // dist[i][j]: i -> j 로 가는데 소요되는 시간
    var dist = Array(repeating: Array(repeating: 2, count: num + 1), count: num + 1)
    for i in 0..<n {
        for j in 0..<n {
            let start = grid[i][j]
            dist[start][start] = 0 // 2-> 2 로 가는데는 0 소요
            // 8 방향 탐색
            for k in 0..<8 {
                let nx = i + dirX[k]
                let ny = j + dirY[k]
                if nx < 0 || nx >= n || ny < 0 || ny >= n { continue }
                dist[start][grid[nx][ny]] = 1
            }
        }
    }
    var totalTime = 0
    let intPwd = pwd.split(separator: "").compactMap({ Int($0) })
    for i in 1..<intPwd.count {
        totalTime += dist[intPwd[i-1]][intPwd[i]]
    }
    return totalTime
}

// 8
solution1_2([2, 5, 3, 7, 1, 6, 4, 9, 8], "7596218")

// 12
//solution1_2([1, 5, 7, 3, 2, 8, 9, 4, 6], "63855526592")

// 13
//solution1_2([2, 9, 3, 7, 8, 6, 4, 5, 1], "323254677")

// 8
//solution1_2([1, 6, 7, 3, 8, 9, 4, 5, 2], "3337772122")

//: [Next](@next)
