//: [Previous](@previous)

import Foundation

/*: ## 삽입 정렬: Insertion Sort
 
 */
func insertionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    
    for i in 1..<arr.count {
        let current = arr[i]
        var compareIdx = i - 1
        
        while(compareIdx >= 0 && current < arr[compareIdx]) {
            arr[compareIdx + 1] = arr[compareIdx]
            compareIdx -= 1
        }
        arr[compareIdx+1] = current
    }
    return arr
}

let array = [4,5,9,1,2,5]
insertionSort(array)

/*: ## 선택 정렬: Selection Sort
 
 
 */

func selectionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    var minIdx = 0
    
    for i in 0..<arr.count {
        var min = 9999
        for j in i..<arr.count {
            if arr[j] < min {
                minIdx = j
                min = arr[j]
            }
        }
        arr.swapAt(i, minIdx)
    }
    return arr
}

selectionSort(array)

/*: ## 버블 정렬: Bubble Sort
 
 
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
 
 */

func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 { return arr }
    let middle = arr.count / 2
    let leftArr = mergeSort(Array(arr[0..<middle]))
    let rightArr = mergeSort(Array(arr[middle..<arr.count]))
    return merge(leftArr, rightArr)
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
        result.append(rightArr[ri])
        ri += 1
    }
    return result
}

mergeSort(array)

/*: ## 이진검색
 
 */
func binarySearch(_ arr: [Int], target: Int) -> Int {
    var left = 0
    var right = arr.count - 1
    
    while(left <= right) {
        let mid = (left + right) / 2
        if arr[mid] == target { return mid }
        
        if arr[mid] > target {
            // target 은 mid 보다 이전에 있다 => high 의 범위를 줄인다
            right = mid - 1
        }
        
        if arr[mid] < target {
            // target 은 mid 보다 이후에 있다 => low 범위를 줄인다
            left = mid + 1
        }
    }
    return -1
}

binarySearch([1,2,3,4,5], target: 4)


//: [Next](@next)
