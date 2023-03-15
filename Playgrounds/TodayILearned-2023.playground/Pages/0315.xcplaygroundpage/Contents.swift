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
        arr[compareIdx + 1] = current
        
    }
    return arr
}

let array = [5,2,1,6,2,4]
insertionSort(array)



/*: ## 선택 정렬: Selection Sort
 
 
 */

func selectionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    var minIdx = 0
    
    for i in 0..<arr.count {
        var min = 9999
        
        for j in i..<arr.count {
            // 제일 작은 요소를 찾아서 가장앞(i) 과 swap
            if arr[j] < min {
                min = arr[j]
                minIdx = j
            }
        }
        arr.swapAt(minIdx, i)
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
        result.append(rightArr[ri])
        ri += 1
    }
    return result
}

mergeSort([5,2,1,6,2,4])

/*: ## 이진검색(binary search)
 
 */

func binarySearch(_ arr: [Int], _ target: Int) -> Int {
    var start = 0
    var end = arr.count - 1
    
    while (start <= end) {
        let middle = (start + end) / 2
        if arr[middle] == target {
            return middle
        }
        if arr[middle] < target {
            start = middle + 1
        } else {
            end = middle - 1
        }
    }
    return -1
}

binarySearch([1,2,3,4,5,6,7], 6)

//: [Next](@next)
