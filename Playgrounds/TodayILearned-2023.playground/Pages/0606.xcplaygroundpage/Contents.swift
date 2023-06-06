//: [Previous](@previous)

import Foundation

// 점수계산
func solution(_ nums: [Int]) -> Int {
    var sum = 0
    var count = 0
    
    for n in nums {
        if n == 1 {
            count += 1
            sum += count
            continue
        }
        count = 0
    }
    return sum
}

// 10
solution([1, 0, 1, 1, 1, 0, 0, 1, 1, 0])

// 등수 구하기
func solution2(_ nums: [Int]) -> [Int] {
    var result = Array(repeating: 1, count: nums.count)
    
    for i in 0..<nums.count {
        for j in 0..<nums.count {
            if nums[i] < nums[j] {
                result[i] += 1
            }
        }
    }
    return result
}

// 4 3 2 1 5
solution2([87, 89, 92, 100, 76])

// 격자판 최대 합
func solution3(_ grid: [[Int]]) -> Int {
    var maxResult = 0
    var sum1 = 0
    var sum2 = 0
    let N = grid.count
    for i in 0..<N {
        sum1 = 0
        sum2 = 0
        for j in 0..<N {
            sum1 += grid[i][j]
            sum2 += grid[j][i]
        }
        maxResult = max(maxResult, sum1)
        maxResult = max(maxResult, sum2)
    }
    sum1 = 0
    sum2 = 0
    for i in 0..<N {
        sum1 += grid[i][i]
        sum2 += grid[i][N-1-i]
    }
    
    maxResult = max(maxResult, sum1)
    maxResult = max(maxResult, sum2)
    return maxResult
}

// 155
let grid = [
    [10, 13, 10, 12, 15],
    [12, 39, 30, 23, 11],
    [11, 25, 50, 53, 15],
    [19, 27, 29, 37, 27],
    [19, 13, 30, 13, 19]

]
solution3(grid)


//: [Next](@next)
