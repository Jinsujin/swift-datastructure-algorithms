//: [Previous](@previous)

import Foundation

// 문자열 압축
func solution(_ input: String) -> String {
    var result = ""
    // i+1 비교를 위해 빈문자 삽입
    var inputArr = "\(input) ".split(separator: "").map{ String($0) }
    var count = 1
    for i in 0..<inputArr.count-1 {
        let current = inputArr[i]
        let next = inputArr[i+1]
        
        if current == next {
            count += 1
        } else {
            result += current
            if count > 1 { result += "\(count)" }
            count = 1
        }
    }
    return result
}

// input: `KKHSSSSSSSE` | output: `K2HS7E`
solution("KKHSSSSSSSE")

// 암호
func solution2(_ input: String, _ inputCount: Int) -> String {
    var result = ""
    var input = input
    
    for _ in 0..<inputCount {
        let temp = input.prefix(7).map { $0 == "#" ? "1" : "0" }.joined()
        if let binary = Int(temp, radix: 2), let scala = UnicodeScalar(binary) {
            print(temp, binary, scala)
            result += String(scala)
        }
        input = String(input.dropFirst(7))
    }
    
    return result
}

//  output: `COOL`
solution2("#****###**#####**#####**##**", 4)

//: [Next](@next)
