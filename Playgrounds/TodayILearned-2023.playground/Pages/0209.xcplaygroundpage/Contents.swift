//: [Previous](@previous)

import Foundation

//*: ## 복습
/*:
 병합정렬
 1. 입력 배열을 left, right 나눈다
 2. 요소가 1개가 될때까지 mergeSort 재귀한다
 3. 요소가 1개가 되었다면 merge 한다
 
 merge
 1. left, right 배열을 인자로 받는다. 반복문을 돌면서 두 배열을 비교해 더 작은값을 result 배열에 넣고 넣은 배열의 index+=1
 2. 반복문이 끝나고 난 후, index 가 인자로 받은 배열 갯수보다 작은경우 남아있는 요소가 있는 것 => result 배열에 넣는다
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


let array = [3,4,1,7,2]

mergeSort(array)
print(2)


//: [Next](@next)
