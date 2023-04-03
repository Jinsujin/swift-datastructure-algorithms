//: [Previous](@previous)

import Foundation

/**
 https://leetcode.com/problems/daily-temperatures/
 
 - N^2 알고리즘을 사용하면 안됨
 */

struct Temperature {
   let day: Int
   let temp: Int
}

func solution(_ temperatures: [Int]) -> [Int] {
   var answer = Array(repeating: 0, count: temperatures.count)
   var stack = [Temperature]()
   
   // 현재보다 낮은 온도가 있으면 pop 과 동시에 며칠 기다렸는지 계산하여 기록
   for i in 0..<temperatures.count {
       let current = Temperature(day: i, temp: temperatures[i])
      
       while(!stack.isEmpty && stack.last!.temp < current.temp) {
           let elem = stack.removeLast()
           answer[elem.day] = current.day - elem.day
       }
       
       stack.append(current)
   }
   return answer
}
//input: temperatures = [30, 40, 50, 60]
//output: [1,1,1,0]
solution([30, 40, 50, 60])

// input: [73, 74, 75, 71, 69, 72, 76, 73]
// output: [1,1,4,2,1,1,0,0]
solution([73, 74, 75, 71, 69, 72, 76, 73])

//: [Next](@next)
