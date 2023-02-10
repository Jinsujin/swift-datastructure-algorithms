//: [Previous](@previous)

import Foundation


//: # 복습

//: ### merge sort
func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 { return arr }
    
    // 1. 배열을 더 이상 안쪼개질때까지 반으로 나눈다
    let middle = arr.count / 2
    let leftArr = mergeSort(Array(arr[0..<middle]))
    let rightArr = mergeSort(Array(arr[middle..<arr.count]))
    // 2. 쪼갠 2개의 배열을 merge 한다
    return merge(leftArr, rightArr)
}

func merge(_ leftArr: [Int], _ rightArr: [Int]) -> [Int] {
    var result = [Int]()
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

let array = [4,5,8,1,2,4]
print(mergeSort(array))

//: [Next](@next)
