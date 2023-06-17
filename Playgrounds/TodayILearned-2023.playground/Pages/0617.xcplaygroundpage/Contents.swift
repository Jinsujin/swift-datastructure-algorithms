//: [Previous](@previous)

import Foundation

// 최대 부분 증가 수열: 배열 구현
func solution3(n: Int, _ input: [Int]) -> Int {
    var count = 0 // 수열 최대 개수
    
    for i in 0..<input.count {
        var prevSelect = input[i]
        var selectCount = 1
        
        for j in i..<input.count {
            // 이전에 선택한 수보다 큰 수를 하나씩 선택
            if input[j] > prevSelect {
                prevSelect = input[j]
                selectCount += 1
            }
        }
        count = max(count, selectCount)
    }
    return count
}
// answer = 4
solution3(n: 8, [5,3,7,8,6,2,9,4])

// 최대 부분 증가 수열: DP 구현
func solution3_2(n: Int, _ input: [Int]) -> Int {
    var answer = 0
    // input 이 하나씩 늘어갈때마다 기록할 최대 증가수열의 길이
    var dy = Array(repeating: 0, count: n)
    dy[0] = 1 // 숫자1개로 만들 수 있는 최대 길이는 무조건 1이다
    
    // i 번째 수가 추가되었을때, 최대 수열이 얼마인지 dy 를 채워나간다
    for i in 1..<input.count {
        var count = 1
        // 뒤에서 부터 숫자를 탐색
        for j in stride(from: i-1, through: 0, by: -1) {
            if input[j] < input[i] {
                count = max(count, dy[j] + 1)
            }
        }
        answer = max(answer, count)
        dy[i] = count
    }
    //dy: [1, 1, 2, 3, 2, 1, 4, 2]
    return answer
}

// answer = 4
solution3_2(n: 8, [5,3,7,8,6,2,9,4])

// 가장 높은 탑 쌓기
func solution4(_ input: [[Int]]) -> Int {
    typealias Brick = (s: Int, h: Int, w: Int)     // (밑넓이, 높이, 무게)
    var arr: [Brick] = input
        .map{ Brick(s: $0[0], h: $0[1], w: $0[2]) }
        .sorted(by: { $0.s > $1.s })
    var dy = Array(repeating: 0, count: input.count)
    dy[0] = arr.first?.h ?? 0
    var answer = dy[0]
    
    for i in 1..<input.count {
        var height = arr[i].h
        for j in stride(from: i-1, through: 0, by: -1) {
            if arr[j].w < arr[i].w { continue }
            height = max(height, dy[j] + arr[i].h)
        }
        dy[i] = height
        answer = max(height, answer)
    }
    //dy: [3, 2, 5, 4, 10]
    return answer
}

// answer = 10
solution4([[25,3,4],
[4,4,6],
[9,2,3],
[16,2,5],
[1,5,2]])

//: [Next](@next)
