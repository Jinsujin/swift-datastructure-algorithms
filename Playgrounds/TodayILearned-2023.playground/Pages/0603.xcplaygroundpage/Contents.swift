//: [Previous](@previous)

import Foundation

// 선택정렬
func selectionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    for i in 0..<arr.count-1 {
        var minIdx = i
        for j in i+1..<arr.count {
            if arr[minIdx] > arr[j] {
                minIdx = j
            }
        }
        arr.swapAt(minIdx, i)
    }
    return arr
}

selectionSort([4,7,2,5,2,1])


// 버블정렬:  한번 루프가 돌때마다 인접한 두개의 요소를 비교=> 가장 뒤의 요소가 먼저 정렬됨
func bubbleSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    
    for i in 0..<arr.count-1 {
        for j in 0..<arr.count-i-1 {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
            }
        }
    }
    return arr
}

bubbleSort([4,7,2,5,2,1])

// 삽입 정렬
func solution(_ arr: [Int]) -> [Int] {
    var arr = arr
    
    for i in 1..<arr.count {
        let cur = arr[i]
        var compareIdx = i-1
        while(compareIdx >= 0 && cur < arr[compareIdx]) {
            arr[compareIdx+1] = arr[compareIdx]
            compareIdx -= 1
        }
        arr[compareIdx + 1] = cur
    }
    
    return arr
}

solution([4,7,2,5,2,1])

//: [Next](@next)
