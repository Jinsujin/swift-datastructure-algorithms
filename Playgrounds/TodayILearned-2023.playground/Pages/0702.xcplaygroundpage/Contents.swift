//: [Previous](@previous)

import Foundation

// 
func solution(c: Int, r: Int, k: Int) -> [Int] {
    var dirs = [(0,1), (1,0), (0,-1), (-1,0)] // 위, 오른쪽, 아래, 왼쪽
    var dIdx = 0 // 위로 먼저 이동
    var currentPos = (x: 1, y: 1)
    let max = c * r

    // ⭐️ 시작좌표에 방문체크하고, count 도 1로 초기화
    var map = Array(repeating: Array(repeating: 0, count: r+1), count: c+1)
    map[currentPos.x][currentPos.y] = 1
    var count = 1
    
    while(count < max) {
        let nextPos = (x: currentPos.x + dirs[dIdx].0, y: currentPos.y + dirs[dIdx].1)
        // 이동가능한지 체크
        if (nextPos.x < 1 || nextPos.x > c || nextPos.y < 1 || nextPos.y > r)
            || map[nextPos.x][nextPos.y] != 0 {
            // 회전하고 이동해야 함
            dIdx = (dIdx + 1) % 4
            continue
        }
        count += 1
        map[nextPos.x][nextPos.y] = count
        currentPos = nextPos
        if count == k {
            print(count, map)
            return [nextPos.x, nextPos.y]
        }
    }
    return [0, 0]
}

// answer: [6, 3]
solution(c: 6, r: 5, k: 12)

// answer: [2, 3]
solution(c: 6, r: 5, k: 20)

// answer: [4, 3]
solution(c: 6, r: 5, k: 30)

// answer: [0, 0]
solution(c: 6, r: 5, k: 31)

//: [Next](@next)
