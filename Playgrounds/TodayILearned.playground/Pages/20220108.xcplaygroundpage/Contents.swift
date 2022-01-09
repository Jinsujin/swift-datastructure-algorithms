//: [Previous](@previous)

import Foundation



//: # 복습

/// 선택 정렬
func selectionSort(_ arr: [Int]) -> [Int] {
    var result = arr

    for i in 0..<arr.count {
        // i 는 가장 작은 원소의 인덱스
        // 정렬되지 않은 데이터 중 가장 작은 값이 올 위치
        var minIdx = i
        
        // i번째와 나머지 값들을 비교해 가장 작은 원소를 찾는다
        for j in i+1..<arr.count {
            if (result[minIdx] > result[j]) {
                minIdx = j
            }
        }
        // 작은 원소를 찾았으면 가장 앞(i) 으로 위치를 바꾼다
        result.swapAt(i, minIdx)
    }
    return result
}

selectionSort([5,8,0,7])






/// 삽입 정렬 -
func insertionSort(_ array: [Int]) -> [Int] {
    var arr = array
    
    // 0번째 원소는 정리 되었다고 보고, 1번째 원소부터 정렬시작
    for i in 1..<arr.count {
        // 기준원소(i) 에서 왼쪽에 위치한 원소들을 비교해 나간다
        // i 부터 1까지 1씩 감소
        // j 는 삽입하고자 하는 그 원소의 위치
        for j in stride(from: i, through: 1, by: -1) {
            // 크거나 같다면, 교체할 필요 없다(= 현재 있는 위치가 정렬된 위치다)
            if (arr[j] >= arr[j-1]) {
                break
            }
            
            // 왼쪽에 있는 데이터와 비교를 했을때, 값이 더 작다면 한칸씩 위치 이동
//            if (array[j] < array[j-1]) {
                // 현재값(j)이 왼쪽(j-1) 보다 더 작다면, 위치를 바꾼다
            arr.swapAt(j, j-1)
//            }
        }
    }
    return arr
}
let datas = [7,5,9,0,3,1,6,2,4,8]
//let datas = [2,4,5,6,1,3]
insertionSort(datas)





//: [Next](@next)
