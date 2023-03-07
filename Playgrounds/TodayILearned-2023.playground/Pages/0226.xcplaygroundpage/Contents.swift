//: [Previous](@previous)

import Foundation

/*: ## 삽입 정렬: Insertion Sort
 - index 1 부터 탐색 시작
 - 앞의 요소들은 정렬된 요소, 뒤의 요소들은 정렬안된 요소
 - 대부분의 요소가 정렬된 경우에, N^2 알고리즘 중 가장 효율적
 */

func insertionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    
    for i in 1..<arr.count {
        let element = arr[i]
        var compareIdx = i - 1
        
        while(compareIdx >= 0 && element < arr[compareIdx]) {
            arr[compareIdx+1] = arr[compareIdx]
            compareIdx -= 1
        }
        
        arr[compareIdx+1] = element
    }
    return arr
}

let array = [5,8,2,1,7,2]
//insertionSort(array)


/*: ## 선택 정렬: Selection Sort
   - 탐색 범위중 가장 작은 요소를 찾고, 탐색범위 가장 앞의 요소와 swap
   - 필요할때만 swap
 */
func selectionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    var minIdx = 0
    
    for i in 0..<arr.count {
        var min = 9999
        for j in i..<arr.count {
            if min > arr[j] {
                min = arr[j]
                minIdx = j
            }
        }
        arr.swapAt(minIdx, i)
    }
    
    return arr
}

//selectionSort(array)

/*: ## 버블 정렬: Bubble Sort
 - N^2 알고리즘 중 가장 효율이 나쁜 알고리즘
 - 한번 탐색할때 매번 swap 하기 때문
 
 */

func bubbleSort(_ arr: [Int]) -> [Int] {
    var arr = arr

    for i in 0..<arr.count {
        for j in 0..<arr.count - i - 1 {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
            }
        }
    }
    return arr
}

bubbleSort(array)

/*: ## Merge Sort
 - 퀵정렬과 달리 최악일때도 (NLogN) 을 보장
 */

func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 { return arr }
    let middle = arr.count / 2
    
    let leftArray = mergeSort(Array(arr[0..<middle]))
    let rightArray = mergeSort(Array(arr[middle..<arr.count]))
    return merge(leftArray, rightArray)
}

func merge(_ leftArr: [Int], _ rightArr: [Int]) -> [Int] {
    var result = [Int]()
    result.reserveCapacity(leftArr.count + rightArr.count)
    var li = 0
    var ri = 0
    
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
        result.append(rightArr[li])
        ri += 1
    }
    
    return result
}

mergeSort(array)

//: [Next](@next)
