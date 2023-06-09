//: [Previous](@previous)

import Foundation

// 중복확인
func solution(_ input: [Int]) -> String {
    var answer = "U"
    var arr = input.sorted(by: <)

    for i in 0..<arr.count-1 {
        if arr[i] == arr[i+1] { return "D" }
    }
    return answer
}
// D
solution([20, 25, 52, 30, 39, 33, 43, 33])

// 장난 꾸러기
func solution2(_ input: [Int]) -> [Int] {
    var answer = [Int]()
    let sortedArr = input.sorted(by: <)
    
    for i in 0..<input.count {
        if input[i] != sortedArr[i] {
            answer.append(i+1)
        }
    }
    return answer
}
solution2([120, 125, 152, 130, 135, 135, 143, 127, 160])


//: [Next](@next)
