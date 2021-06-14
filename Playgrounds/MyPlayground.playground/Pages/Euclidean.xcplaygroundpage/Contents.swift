//: [Previous](@previous)

import Foundation
/**
 유클리드 알고리즘으로 최대 공약수 구하기

 입력된 정수 a, b가 있을때
 - a를 b로 나눈 나머지를 n 이라고 하면, n == 0 일때, b가 최대공약수 이다.
 
 */

func solution(_ a: Int,_ b: Int) -> Int {
    var temp = 0
    var aa = a
    var bb = b
    
    while(bb > 0) {
        temp = aa % bb
        aa = bb
        bb = temp
    }
    return aa
}

solution(30, 280)

//: [Next](@next)
