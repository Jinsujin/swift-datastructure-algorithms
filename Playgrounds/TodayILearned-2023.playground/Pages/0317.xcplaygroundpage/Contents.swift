//: [Previous](@previous)

import Foundation

/*: ## 회전 배열에서의 이진탐색

 */

func solution(_ arr: [Int], _ num: Int) -> Int {
    
    func binarySearch(_ start: Int, _ end: Int) -> Int {
        // 종료 조건
        if start > end { return -1 }
        let mid = (start + end) / 2
        
        if arr[mid] == num { return mid }
        
        // 1. start ~ mid 까지의 숫자들이 정렬된 경우
        // => 튀는 부분은 mid ~ end 에 있다
        // => 기존 이진탐색과 동일하게 동작
        if arr[start] <= arr[mid] {
            if num >= arr[start] && num <= arr[mid] {
                return binarySearch(start, mid - 1)
            }
            return binarySearch(mid + 1, end)
        }
        
        // 2. mid ~ end 까지 정렬된 경우 => start ~ mid 는 정렬이 안되어 있다
        // 찾을값이 mid ~ end 중간에 있는지 확인
        if num >= arr[mid] && num <= arr[end] {
            return binarySearch(mid + 1, end)
        }
        
        // 3. 튄 부분을 제외하고 재귀를 돌린다!
        return binarySearch(start, mid - 1)
    }
    
    let target = binarySearch(0, array.count - 1)
    return target
}


let array = [20, 21, 23, 24, 1, 2, 4, 8, 11]
solution(array, 11)


/*: ## 퀵정렬
 - 각 단계마다 방문하는 요소 수: N
 - 깊이는 절반씩 줄어드므로 logN
 => O(NlogN)

 - 최악의 경우는 O(N^2)
 => 분할할때마다 한쪽으로 몰리는 경우
 pivot 을 다른곳으로 뽑을수 있지만, 어느 경우에도 최악의 상황은 발생
 
 */

func quickSort(_ arr: [Int]) -> [Int] {
    
    func recursive(_ nums: inout [Int], _ left: Int, _ right: Int) {
        if left >= right { return }
        let pivot = partition(&nums, left, right)
        recursive(&nums, left, pivot - 1)
        recursive(&nums, pivot + 1, right)
    }
    var result = arr
    recursive(&result, 0, arr.count - 1)
    return result
}

/// 왼쪽 오른쪽 정렬하고, 정렬된 pivot index 반환
func partition(_ nums: inout [Int], _ left: Int, _ right: Int) -> Int {
    // 가장 오른쪽 요소를 기준으로 정렬
    let pivot = nums[right]
    
    // swap 이 한번도 안일어나면 left 위치로 기준값을 옮기기 위해 -1
    // Bool 대신 사용
    var i = left - 1
    
    // left ~ (right - 1) 까지 정렬
    for j in left..<right {
        // pivot 보다 작은값은 i 아래로 이동
        if nums[j] < pivot {
            i += 1 // 0,1,2
            nums.swapAt(i, j)
            
            print("\(i) <-> \(j)")
        }
    }
    // => (i보다 작은값) i (i 와 같거나 큰 값)
    // 기준값의 최종 위치
    let pivotResult = i + 1
    nums.swapAt(pivotResult, right)
    print(nums, "pivot=", pivot)
    print("---------")
    return pivotResult
}

quickSort([5,1,8,2,6])

//: [Next](@next)
