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
            arr[compareIdx+1] = arr[compareIdx]
            compareIdx -= 1
        }
        arr[compareIdx+1] = current
    }
    
    return arr
}

let array = [6,4,7,1,4,2]
//insertionSort(array)


/*: ## 선택 정렬: Selection Sort
 - 작은 요소를 선택해 탐색범위의 가장 앞으로 swap
 - 가장 앞의 요소가 먼저 정렬된다
 
 */
func selectionSort(_ arr: [Int]) -> [Int] {
    var arr = arr
    var minIdx = 0
    
    for i in 0..<arr.count {
        var min = 9999
        
        for j in i..<arr.count {
            if arr[j] < min {
                min = arr[j]
                minIdx = j
            }
        }
        arr.swapAt(i, minIdx)
    }

    return arr
}

//selectionSort(array)



/*: ## 버블 정렬: Bubble Sort
 - 한번 탐색할때마다 매번 swap
 - N^2 정렬중 가장 느리다
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
 - 최악일때도 (NLogN) 을 보장
 - 중앙을 기준으로 왼쪽, 오른쪽 배열로 나눈다음 merge
 - 메모리 공간이 요구된다는 단점
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

//: [Next](@next)
