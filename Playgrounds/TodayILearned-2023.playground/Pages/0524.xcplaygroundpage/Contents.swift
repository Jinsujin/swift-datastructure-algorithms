//: [Previous](@previous)

import Foundation


// 모든 토마토가 익는데 걸리는 최대일수
func tomato(_ box: [[Int]]) -> Int {
    let N = 4
    let M = 6
    var graph = box
    var queue = [GraphPoint]()
    
    for i in 0..<N {
        for j in 0..<M {
            if graph[i][j] == 1 {
                queue.append(GraphPoint(x: i, y: j))
            }
        }
    }
    
    let dirX = [1, -1, 0, 0]
    let dirY = [0, 0, 1, -1]
    
    while(!queue.isEmpty) {
        let cur = queue.removeFirst()
        
        for i in 0..<4 {
            let nx = cur.x + dirX[i]
            let ny = cur.y + dirY[i]
            if nx < 0 || nx >= N || ny < 0 || ny >= M {
                continue
            }
            if graph[nx][ny] != 0 { continue }
            print(cur.x, cur.y, "(\(graph[cur.x][cur.y])) ->", nx, ny, "(\(graph[nx][ny]))")
            graph[nx][ny] = graph[cur.x][cur.y] + 1
            queue.append(GraphPoint(x: nx, y: ny))
        }
    }
    // 가장 큰 숫자를 찾는다(익는데 소요된 최대일수)
    // 만약0 이 하나라도 있으면, 모두 확산을 못시킨 것이므로-1
    var result = 0
    for i in 0..<N {
        for j in 0..<M {
            let day = graph[i][j]
            if day == 0 {
                return -1
            }
            result = max(result, day)
        }
    }
    return result - 1
}

let box =
[[0,0,-1,0,0,0],
[0,0,1,0,-1,0],
[0,0,-1,0,0,0],
[0,0,0,0,-1,1]]

// 4
tomato(box)

// 임시반장
func solution(_ students: [[Int]]) -> Int {
    var classMatch = Array(repeating: 0, count: students.count)
    let studentNum = students.count
    
    for i in 0..<studentNum { // 현재 학생 index
        for j in 0..<studentNum { // 비교 학생
            for c in 0..<5 { // 학년
                print(i, j, c)
                if students[i][c] == students[j][c] {
                    classMatch[i] += 1
                    break
                }
            }
        }
    }
    var result = 0
    var maxIndex = 0
    for i in 0..<classMatch.count {
        if result < classMatch[i] {
            result = classMatch[i]
            maxIndex = i
        }
    }
    return maxIndex + 1
}
let students = [
[2, 3, 1, 7, 3],
[4, 1, 9, 6, 8],
[5, 5, 2, 4, 4],
[6, 5, 2, 6, 7],
[8, 4, 2, 2, 2]]
solution(students)
//0 0 0
//0 1 0
//0 1 1
//0 1 2
//0 1 3
//0 1 4
//0 2 0
//0 2 1
//0 2 2
//0 2 3
//0 2 4

//: [Next](@next)
