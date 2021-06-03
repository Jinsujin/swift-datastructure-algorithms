//: [Previous](@previous)

import Foundation

/**
 다음 큰 수
 
 자연수 n이 주어졌을 때, n의 다음 큰 숫자는 다음과 같이 정의 합니다.
     •    조건 1. n의 다음 큰 숫자는 n보다 큰 자연수 입니다.
     •    조건 2. n의 다음 큰 숫자와 n은 2진수로 변환했을 때 1의 갯수가 같습니다.
     •    조건 3. n의 다음 큰 숫자는 조건 1, 2를 만족하는 수 중 가장 작은 수 입니다.
 예를 들어서 78(1001110)의 다음 큰 숫자는 83(1010011)입니다.
 자연수 n이 매개변수로 주어질 때, n의 다음 큰 숫자를 return 하는 solution 함수를 완성해주세요.
 */

let n = 15

/// 10진수 숫자를 받아서 2진수의 1의 갯수 반환
func countBinary(_ decimal: Int) -> Int{
    // 2진수 변환
    let binary: String = String(decimal, radix: 2)
    //let decimal: Int = Int(binary, radix: 2)! // 2진수 10진수 변환
    var binaryCount = 0
    for b in binary {
        if b == "1" {
            binaryCount+=1
        }
    }
    
    return binaryCount
}


func solution(_ n: Int) -> Int {
    let n_binaryCount = countBinary(n)
    var result = n
    
    while(result < 1000000) {
        result += 1
        let result_binaryCount = countBinary(result)
        if (n_binaryCount == result_binaryCount) { break }
    }
    
    return result
}

print(solution(n))


//: [Next](@next)
