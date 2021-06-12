//: [Previous](@previous)

import Foundation

/**
 초 단위로 기록된 주식가격이 담긴 배열 prices가 매개변수로 주어질 때, 가격이 떨어지지 않은 기간은 몇 초인지를 return 하도록 solution 함수를 완성하세요

 입출력 예
 let prices = [1,2,3,2,3]
 return [4,3,1,1,0]
 
 1초 시점의 ₩1은 끝까지 가격이 떨어지지 않았습니다.
 2초 시점의 ₩2은 끝까지 가격이 떨어지지 않았습니다.
 3초 시점의 ₩3은 1초뒤에 가격이 떨어집니다. 따라서 1초간 가격이 떨어지지 않은 것으로 봅니다.
 4초 시점의 ₩2은 1초간 가격이 떨어지지 않았습니다.
 5초 시점의 ₩3은 0초간 가격이 떨어지지 않았습니다.
 
 */

// return [4,3,1,1,0]
let prices = [1,2,3,2,3]


func solution(_ prices: [Int])-> [Int] {
    var result: [Int] = []
    
    // 배열 초기화
    for _ in 0..<prices.count {
        result.append(0)
    }
    
    // 값이 유지되거나 큰 경우 +=1
    // 값이 내려간 경우 -=1
    for i in 1..<prices.count { // 1,2,3,4
        for before_i in 0..<i { // i = 1, before_i = 0
            // 현재값이 이전값보다 작은경우
            if(prices[i] >= prices[before_i]) { result[before_i]+=1 }
            else if(prices[i] < prices[before_i]) {
                if (result[before_i] > 0) { result[before_i]-=1 }
            }
        }
    }
    return result
}

solution(prices)


//: [Next](@next)
