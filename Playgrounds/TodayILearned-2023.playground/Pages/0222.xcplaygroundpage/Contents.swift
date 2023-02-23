//: [Previous](@previous)

import Foundation

/*: # 삽입 정렬
 
 - index [1] 부터 N(요소개수)-1 까지 차례대로 요소를 살핀다
 - (시작인덱스 -1) 부터 index 0 까지 반복하며
 - (현재 선택한 요소 < 비교한 요소들) 이라면:
 - 비교한 요소의 인덱스를 현재위치에서 +1 한다
 */

func insertionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    
    // 1번 인덱스 부터 시작
    for i in (1..<arr.count) {
        let current = arr[i]
        var compareIdx = i - 1
        
        while(compareIdx >= 0 && current < arr[compareIdx]) {
            arr[compareIdx+1] = arr[compareIdx]
            compareIdx -= 1
        }
        arr[compareIdx+1] = current
    }
    return arr
}

let array = [6,1,4,9,1,7]
//insertionSort(array)


/*: # 버블 정렬
 
 */
func bubbleSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    
    for i in 0..<arr.count {
        for j in 0..<arr.count-1-i {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
            }
        }
    }
    return arr
}

//print(bubbleSort(array))


/*: # 선택 정렬
- 탐색범위중 가장 작은 요소를 찾아서, 정렬안된 범위의 가장 앞으로 swap
 */

func selectionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    var minIdx = 0
    
    for i in 0..<arr.count {
        var min = 999
        for j in i..<arr.count {
            if min > arr[j] {
                min = arr[j]
                minIdx = j
            }
        }
        arr.swapAt(i, minIdx)
    }
    return arr
}

selectionSort(array)

//[6,1,4,9,1,7]
// 0:  [1, 6,4,9,1,7]
// 1: [1,1, 4,9,6,7]
// 2: [1,1,4, 9,6,7]
// 3: [1,1,4,6, 9,7]
// 4: [1,1,4,6,7, 9]
// 5: [1,1,4,6,7,9]

//: [Next](@next)
