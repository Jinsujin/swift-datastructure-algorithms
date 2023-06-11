//: [Previous](@previous)

import Foundation

// 좌표 정렬
func solution(_ input: [[Int]]) -> [[Int]] {
    func sortPoint(pointA: [Int], pointB: [Int]) -> Bool {
        let x = pointA[0] - pointB[0]
        let y = pointA[1] - pointB[1]
        
        if x < 0 || x == 0 {
            if y < 0 || y == 0 { return true }
            if y > 0 { return false }
            return true
        }
        return false
    }
    return input.sorted(by: sortPoint)
}

let points = [[2, 7],
[1, 3],
[1, 2],
[2, 5],
[2, 6],
[3, 6]]
solution(points)

// 이분 탐색
func solution2(_ target: Int, _ arr: [Int]) -> Int {
    var arr = arr.sorted(by: <)
    var lt = 0
    var rt = arr.count - 1
    
    while(lt <= rt) { // 조건 주의!
        let mid = (lt + rt) / 2
        if arr[mid] == target { return mid + 1 }
        if arr[mid] < target { lt = mid + 1 }
        if arr[mid] > target { rt = mid - 1 }
    }
    return -1
}
// 3
solution2(32, [23, 87, 65, 12, 57, 32, 99, 81])


//: [Next](@next)
