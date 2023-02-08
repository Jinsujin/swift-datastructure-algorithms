//: [Previous](@previous)

import Foundation

/*: 병합정렬 복습
 
 1. 전체배열을 mergeSort 한다
   - 1. 배열을 반으로 나눠 left, right 2개로 만든다
   - 2. left, right 배열 각각 mergeSort 하여 원소가 1개가 될때까지 재귀반복한다
   - 3. 나눈 원소들을 역으로 올라가며 merge 정렬한다
 2. merge 정렬
   - 1. left, right 배열과 결과배열을 준비한다.
   - left 배열의 index: 0..<middle / right 배열의 index 시작: middle..< arr.count
   - 2. leftIndex 가 middle 보다 작고, rightIndex 가 arr.count 보다 작으면 반복한다
     - left[leftIndex] 가 right[rightIndex] 보다 작으면 => left 요소를 결과배열.append, leftIndex += 1
     - left[leftIndex] 가 right[rightIndex] 보다 크면 => right 요소를 결과배열.append, rightIndex += 1
   - 3. left, right 배열에 남은 요소를 결과배열에 모두 넣는다
   - 4. 결과배열 반환
 */

func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 {
        return arr
    }
    let middleIndex = arr.count / 2
    let leftArr = mergeSort(Array(arr[0..<middleIndex]))
    let rightArr = mergeSort(Array(arr[middleIndex..<arr.count]))
    return merge(leftArr, rightArr)
}

func merge(_ leftArr: [Int], _ rightArr: [Int]) -> [Int] {
    var result = [Int]()
    result.reserveCapacity(leftArr.count + rightArr.count)

    var leftIndex = 0
    var rightIndex = 0
    
    while(leftIndex < leftArr.count && rightIndex < rightArr.count) {
        let leftElement = leftArr[leftIndex]
        let rightElement = rightArr[rightIndex]
        
        if (leftElement < rightElement) {
            result.append(leftElement)
            leftIndex += 1
        } else if (leftElement > rightElement) {
            result.append(rightElement)
            rightIndex += 1
        } else {
            result.append(rightElement)
            rightIndex += 1
            result.append(leftElement)
            leftIndex += 1
        }
    }
    
    while(leftIndex < leftArr.count) {
        result.append(leftArr[leftIndex])
        leftIndex += 1
    }
    
    while(rightIndex < rightArr.count) {
        result.append(rightArr[rightIndex])
        rightIndex += 1
    }
    
    return result
}

let array = [3,7,5,1,6]
mergeSort(array)

//: [Next](@next)
