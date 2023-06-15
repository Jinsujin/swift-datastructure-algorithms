//: [Previous](@previous)

import Foundation

// 계단 오르기
func solution(_ n: Int) -> Int {
    var dy = Array(repeating: 0, count: n+1)
    // 1 계단까지 오르는 방법: 1가지
    dy[1] = 1
    //2 계단까지 오르는 방법: 1+1, 2 => 2가지
    dy[2] = 2
    // 3계단부터 구하고자 하는 목표인 7계단 까지 구한다
    for i in 3...n {
        dy[i] = dy[i-1] + dy[i-2]
    }
    return dy[n]
}
// 21 가지 방법
solution(7)


// 돌다리 건너기
func solution2(_ n: Int) -> Int {
    // 도착지점까지 계산해야 하므로 n+2
    var dy = Array(repeating: 0, count: n+2)
    dy[1] = 1
    dy[2] = 2
    for i in 3...n+1 {
        dy[i] = dy[i-1] + dy[i-2]
    }
    return dy[n+1]
}
// 34 가지 방법
solution2(7)

//: [Next](@next)
