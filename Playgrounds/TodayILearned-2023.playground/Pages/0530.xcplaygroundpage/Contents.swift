//: [Previous](@previous)

import Foundation

// 후위연산
func solution(_ input: String) -> Int {
    var arr: [String] = input.split(separator: "").map({ String($0) })
    var stack = [Int]()
    
    for char in arr {
        if let curValue = Int(char) { // 숫자인 경우 스택에 넣는다
            stack.append(curValue)
            continue
        }
        // 연산자인 경우
        let v1 = stack.removeLast()
        let v2 = stack.removeLast()
        
        if char == "+" {
            stack.append(v2 + v1)
        } else if char == "*" {
            stack.append(v2 * v1)
        } else if char == "-" {
            stack.append(v2 - v1)
        } else if char == "/" {
            stack.append(v2 / v1)
        }
    }
    return stack.first ?? -1
}
// 12
solution("352+*9-")

// 막대기 자르기
func solution2(_ input: String) -> Int {
    var answer = 0
    var arr: [String] = input.split(separator: "").map({ String($0) })
    var stack = [String]()
    
    for i in 0..<arr.count {
        let char = arr[i]
        if char == "(" {
            stack.append(char)
            continue
        }
        // 닫는괄호라면 레이저인지 막대기인지 판별한다
        if arr[i-1] == "(" { // 바로 직전이 여는괄호라면, 레이저
            stack.removeLast()
            answer += stack.count
            continue
        }
        // 아니면 막대기
        stack.removeLast()
        answer += 1
    }
    return answer
}
// 17
solution2("()(((()())(())()))(())")

// 24
solution2("(((()(()()))(())()))(()())")

//: [Next](@next)
