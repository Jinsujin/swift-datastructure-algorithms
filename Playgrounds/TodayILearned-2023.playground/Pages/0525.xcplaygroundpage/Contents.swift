//: [Previous](@previous)

import Foundation


// 멘토-멘티
func solution(_ students: [[Int]]) -> Int {
    let examCount = students.count
    var dic = [Int: [Int]]()
    for i in 1...4 {
        dic[i] = []
    }
    
    for i in 0..<examCount { // 0
        for j in 0..<students[i].count { // 0,1,2,3
            let cur = students[i][j]

            var compIndex = j+1
            while(compIndex < students[i].count) {
                let menti = students[i][compIndex]
                dic[cur]?.append(menti)
                compIndex += 1
            }
        }
        
    }
    print(dic)
    
    // 3번 이상 같은 번호가 있다면, 멘토-멘티 관계가 될 수 있는 것
    var result = 0
    for (key, value) in dic {
        for i in 0..<value.count {
            var count = 0
            let cur = value[i]
            var k = i+1
            while(k < value.count) {
                // 현재 선택한 숫자가3번 이상 나왔나?
                if value[k] == cur {
                    count += 1
                }
                k += 1
            }
            if count >= examCount-1 {
                result += 1
            }
        }
    }
    return result
}

let exams =
[[3, 4, 1, 2],
[4, 3, 2, 1],
[3, 1, 4, 2]]

// 3
//solution(exams)

func solution2(_ exams: [[Int]]) -> Int {
    let studentMaxID = 4
    var result = 0
    
    for i in 1...studentMaxID { // 1~4
        for j in 1...studentMaxID { // 1~4
            // i, j 번 학생 비교
            var count = 0
            for k in 0..<exams.count {
                var pi = 0
                var pj = 0
                for s in 0..<4 {
                    if exams[k][s] == i {
                        pi = s
                        print("\(i)번 학생-\(k)시험", exams[k][s], i, "s = \(s)")
                    }
                    if exams[k][s] == j {
                        pj = s
                        print("비교 \(j)학생-\(k)시험", exams[k][s], k, "s = \(s)")
                    }
                 }
                // i 가 j 의 멘토가 될 수 있나
                if pi < pj { count += 1 }
            }
            print("-----")
            if count == exams.count {
                result += 1
            }
        }
    }
    return result
}

//3
//solution2(exams)

// 섬나라 아일랜드
// 몇개의 섬이 있는지 구하라
struct MapPoint {
    var x: Int
    var y: Int
}
func solution(N: Int, _ map: [[Int]]) -> Int {
    
    let dirX = [-1,1,0,0,1,-1,-1,1]
    let dirY = [0,0,-1,1,1,1,-1,-1]
    
    var map = map
    var answer = 0
    
    for i in 0..<N {
        for j in 0..<N {
            if map[i][j] == 1 {
                map[i][j] = 2
                dfs(start: MapPoint(x: i, y: j))
                answer += 1
            }
        }
    }
    
    func dfs(start: MapPoint) {
        // 탈출 조건?
        for i in 0..<dirX.count {
            let nx = start.x + dirX[i]
            let ny = start.y + dirY[i]
            
            if nx < 0 || nx >= N || ny < 0 || ny >= N {
                continue
            }
            if map[nx][ny] != 1 { continue }
            map[nx][ny] = 2
            print("start:  \(start.x), \(start.y)-> ", nx, ny)
            dfs(start: MapPoint(x: nx, y: ny))
        }
    }
    return answer
}

let map = [
[1,1,0,0,0,1,0],
[0,1,1,0,1,1,0],
[0,1,0,0,0,0,0],
[0,0,0,1,0,1,1],
[1,1,0,1,1,0,0],
[1,0,0,0,1,0,0],
[1,0,1,0,1,0,0]]
// 5
solution(N: 7, map)

//: [Next](@next)
