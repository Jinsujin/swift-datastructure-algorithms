//: [Previous](@previous)

import Foundation
import Combine

//: # 복습: merge sort
func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 { return arr }
    let middle = arr.count / 2
    let leftArr = mergeSort(Array(arr[0..<middle]))
    let rightArr = mergeSort(Array(arr[middle..<arr.count]))
    return merge(leftArr, rightArr)
}

func merge(_ leftArr: [Int], _ rightArr: [Int]) -> [Int] {
    var li = 0
    var ri = 0
    var result = [Int]()
    result.reserveCapacity(leftArr.count + rightArr.count)
    
    while(li < leftArr.count && ri < rightArr.count) {
        let leftElem = leftArr[li]
        let rightElem = rightArr[ri]
        if leftElem < rightElem {
            result.append(leftElem)
            li += 1
        } else if leftElem > rightElem {
            result.append(rightElem)
            ri += 1
        } else {
            result.append(leftElem)
            li += 1
            result.append(rightElem)
            ri += 1
        }
    }
    while(li < leftArr.count) {
        result.append(leftArr[li])
        li += 1
    }
    
    while(ri < rightArr.count) {
        result.append(rightArr[ri])
        ri += 1
    }
    return result
}

let arr = [4,6,1,2,9,3]
mergeSort(arr)


/*: ### 복습: 최대 공약수
 a > b 일때, a 를 b 로 나눈 나머지를 r
 => a, b 의 최대 공약수는 b, r 의 최대 공약수와 같다
 */

func gcd(_ a: Int, _ b: Int) -> Int {
    if (a % b) == 0 { return b }
    return gcd(b, a % b)
}

gcd(192, 162)

/*: ### 음료수 얼려먹기(DFS)
 
 * Input:
 00000111100000
 11111101111110
 11011101101110
 11011101100000
 11011111111111
 11011111111100
 11000000011111
 01111111111111
 00000000011111
 01111111111000
 00011111111000
 00000001111000
 11111111110011
 11100011111111
 11100011111111
 
 * Output:
 8
 */

// result = 3
let input = [[0,0,1,1,0],
            [0,0,0,1,1],
            [1,1,1,1,1],
            [0,0,0,0,0]]

let N = 4
let M = 5


func solution(_ input: [[Int]]) -> Int {
    var result = 0
    var grid = input
    for y in 0..<N {
        for x in 0..<M {
            if (dfs(y,x)) {
                result += 1
                print("--1 UP!--")
            }
        }
    }
    
    func dfs(_ x: Int, _ y: Int) -> Bool {
//        print("visit=", start)
        print("🙋🏻‍♀️ 현재 위치 =", y, x)
        
        if (x <= -1 || x >= N || y <= -1 || y >= M) {
            print("범위를 벗어남", y, x)
            return false
        }
        
        if (grid[x][y] != 0) {
            print("지나갈수 없는곳 = ", y, x)
            return false
        }
        grid[x][y] = 1
        print("☑ 방문 체크 = ", y, x)
        dfs(x + 1, y)
        dfs(x - 1, y)
        dfs(x, y + 1)
        dfs(x, y - 1)
        print("return true")
        return true
    }
    return result
}

solution(input) // 3




//: [Next](@next)
