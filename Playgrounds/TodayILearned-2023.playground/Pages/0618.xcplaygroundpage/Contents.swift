//: [Previous](@previous)

import Foundation

// (DP) 동전 교환
func solution(_ input: [Int], _ money: Int) -> Int {
    var dy = Array(repeating: Int.max, count: 15+1)
    dy[0] = 0 // 0원은 동전으로 맞출 수 없다=> 0개
    
    // 동전 종류가1개씩 추가될때마다 dy 를 갱신한다
    for coin in input {
        for j in coin..<dy.count {
            // 예) 5원을 맞추기 위해 현재 dy[j] 기록된값과, dy[j현재기록된값-5] 에서 동전1(5원)을 더한값중 작은값을 갱신
            dy[j] = min(dy[j], dy[j-coin]+1)
        }
    }
    // dy: [0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 3, 3, 4, 4, 3]
    return dy[money]
}
// answer: 3
solution([1,2,5], 15)


// (DP)최대 점수 구하기
// n: 문제개수, m: 제한시간, input: [(획득점수, 걸리는시간)]
func solution2(n: Int, m: Int, _ input: [[Int]]) -> Int {
    var dy = Array(repeating: 0, count: m+1)
    
    for elem in input {
        let current: (score: Int, time: Int) = (elem[0], elem[1])
        // ✅ 사용할 수 있는 아이템의 갯수가 정해져 있다면 뒤에서부터 for문을 돈다
        for j in stride(from: m, through: current.time, by: -1) {
            dy[j] = max(dy[j], dy[j-current.time] + current.score)
        }
    }
    // dy: [0, 0, 0, 6, 7, 10, 10, 13, 16, 17, 17, 21, 25, 25, 25, 31, 32, 35, 35, 38, 41]
    return dy[m]
}


// 41
solution2(n: 5, m: 20, [[10, 5],
                        [25, 12],
                        [15, 8],
                        [6,3],
                        [7,4]])

//: [Next](@next)
