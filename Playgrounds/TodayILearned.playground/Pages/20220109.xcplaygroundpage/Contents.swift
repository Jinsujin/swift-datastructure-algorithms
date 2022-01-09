//: [Previous](@previous)

import Foundation


//: # 복습

// 피보나치 1,1,2,3,5,8
// n 번째 피보나치 수는?
func fact(_ n: Int) -> Int {
    let emptyArr = [Int](repeating: 0, count: n-2)
    var result: [Int] = [1,1] + emptyArr
    
    for i in 2..<n{
        result[i] = result[i-1] + result[i-2]
    }
    return result[n-1]
}

print(fact(6))



// 배열의 합 구하기
func add(_ array: [Int]) -> Int {
    var arr = array
    if arr.count <= 1 {
        return arr.first!
    }
    let first = arr.removeFirst()
    return first + add(arr)
}

print(add([1,2,3]))




func binarySearch(_ arr: [Int], _ find: Int) -> Int {
    var left = 0
    var right = arr.count - 1
    
    while(left <= right) {
        let mid = (left + right) / 2
        if (arr[mid] == find) { return mid }
        if (arr[mid] > find) {
            right = mid - 1
            continue
        }
        left = mid + 1
    }
    return -1
}


/// 버블 정렬 - 거꾸로 돌리면서 비교 후, swap
func bubbleSort(_ array: [Int]) -> [Int] {
    var arr = array
    
    for i in 0..<arr.count {
        for j in stride(from: arr.count - 1, through: i + 1, by: -1) {
            if (arr[j] < arr[j-1]) {
                arr.swapAt(j, j-1)
            }
        }
    }
    return arr
}
print("----bubble----")
bubbleSort([4,1,2,6])






//: # 학습
/*
 참고 자료
 https://whitepro.tistory.com/232
 https://babbab2.tistory.com/101?category=908012
 */

/// 퀵정렬 O(NlogN) - 별도의 메모리 공간이 필요하다. 중복 데이터의 순서가 바뀌지 않는다(stable)
//func quickSortStable(_ arr: [Int]) -> [Int] {
//    if arr.count < 2 {
//        return arr
//    }
//    let pivot = arr[arr.count/2]
//    let left = arr.filter{ $0 < pivot }
//    let right = arr.filter{ $0 > pivot }
//    return quickSort(left) + [pivot] + quickSort(right)
//}
//
//quickSort([3,1,5,2,6])

var target: [Int] = [7,5,9,0,3,1,6,2,4,8]
var n = target.count

//quickSort(target, 0, n - 1)


// 안됨!
func quickSort(_ array: [Int],_ start: Int,_ end: Int) {
    var arr = array
    
    // 원소가 1개인 경우 정렬할 수 없으므로 종료
    if (start >= end) {
        return
    }
    // 첫번째 값을 pivot 으로 선택한다
    let pivot = start
    var left = start + 1
    var right = end
    
    // left 는 오른쪽으로 이동하며, pivot 보다 큰 값을 찾는다
    while (left <= right) {
        // -> 이동하며, pivot 보다 큰 데이터를 찾을 때까지 반복
        while (left <= end && arr[left] <= arr[pivot]) { left += 1 }
        
        // pivot 보다 작은 데이터를 찾을 때까지 반복
        while (right > start && arr[right] >= arr[pivot]) { right -= 1 }
        
        // 엇갈렸다면 작은 데이터와 pivot 을 교체
        if(left > right) {
            arr.swapAt(pivot, right)
        } else {
            // 엇갈리지 않았다면 작은 데이터와 큰 데이터를 교체
            arr.swapAt(left, right)
        }
    }
    
    // 분할 후, 왼쪽 배열과 오른쪽 배열에서 각각 정렬 수행
    
    print("start:", start, "end:",right-1)
    print("start:", right + 1, "end:",end)
    
    quickSort(arr, start, right - 1)
    quickSort(arr, right + 1, end)
}


func quickSortInPlace(_ arr: [Int],_ left: Int,_ right: Int) -> [Int] {
    if (left >= right) { return arr }
    
    let mid = (left + right) / 2
    let pivot = arr[mid]
    print(left, right, pivot)
    
    let newLeft = divide(arr, pivot, left, right)
    
    func divide(_ arr: [Int],_ pivot: Int,_ l: Int,_ r: Int) -> Int {
        var left = l
        var right = r
        while(left <= right) {
            while (arr[left] < pivot) { left += 1 }
            while (pivot < arr[right]) { right -= 1 }
            if (left <= right) {
                //
                left += 1
                right -= 1
            }
        }
        return left
    }
    
    quickSortInPlace(arr, newLeft, right)
    quickSortInPlace(arr, left, newLeft - 1)
    return arr
}

//print(quickSortInPlace(target, 0, target.count - 1))






//: [Next](@next)
