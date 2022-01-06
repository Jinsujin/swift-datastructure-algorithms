//: [Previous](@previous)

import Foundation


/*:
 ## 재귀
 */
func countDown(_ num: Int) {
    var num = num
    print(num)
    if (num <= 1) {
        return
    }
    num -= 1
    countDown(num)
}
countDown(4)
// 4
// 3
// 2
// 1



func countArray(_ arr: [Int]) {
    var copyArr = arr
    print(arr)
//    if (arr.count <= 0) {
//        return
//    }
    copyArr.popLast()
    
    // 재귀를 언제 멈출지, 재귀단계에서 거르면 필요없는 함수 호출을 줄일 수 있다
    if (arr.count > 1) {
        countArray(copyArr)
    }
}

let array = [1,2,3,4]
countArray(array)

//[1, 2, 3, 4]
//[1, 2, 3]
//[1, 2]
//[1]


/// 전체 배열의 합 구하기
func sum(_ arr: [Int]) -> Int {
    var total = 0
    for i in arr {
        total += i
    }
    return total
}

print(sum(array)) // 10


/// 재귀로 배열의 합 구하기
func sumRec(_ array: [Int]) -> Int {
    var arr = array
    
    // 재귀를 막는 조건
    if arr.count <= 1 {
        return arr[0]
    }
    
    let last = arr.popLast()!
    return last + sumRec(arr)
}

sumRec(array)


/// 팩토리얼- 재귀
func fact(_ n: Int) -> Int {
    if (n == 1) {
        return n
    }
    return n * fact(n-1)
}
fact(3) // 6




/*
### 피보나치 다양하게 구현하기
 - 1. 재귀
 - 2. 동적 계획법(Dynamic Programming):
    - 복잡한 문제를 작은 문제로 쪼개서 푸는 방법
    - 한번 푼 문제를 다시 풀지 않도록 알고리즘을 개선한다
 */
/// 피보나치 재귀- 1,1,2,3,5,8
func fibo(_ num: Int) -> Int {
    if (num < 2) {
        return 1
    }
    return fibo(num-1) + fibo(num-2)
}

/// n 번째의 피보나치 수 - 시간 복잡도 O(N)
func fibonachi(_ n: Int) -> Int {
    // (n - [0,1].count) 만큼 배열을 만든다
    let emptyArr: [Int] = Array(repeating: 0, count: n-2)
    var result: [Int] = [0,1] + emptyArr
    
    for i in 2..<n {
        result[i] = result[i-1] + result[i-2]
    }
    return result[n-1]
}

fibonachi(3)




/*:
 ### 퀵 정렬
 분할정복 알고리즘 기법이 적용되었다.
 - 분할정복:
    - 문제를 나눌 수 없을때까지 나누어서 풀고, 나누어서 풀었던 문제를 다시 합쳐서 답을 얻는 알고리즘
    - 재귀함수로 구현한다
 
 [기준원소 보다 작은 원소들] (기준원소) [기준원소 보다 큰 원소들]
 
 만약 하위배열들이 정렬되어 있다면, 다음처럼 합칠 수 있다
 [10,23,19,4,1]
 퀵정렬( [4,1], 10, [23, 19] )
 퀵정렬( [1,4], 10, [19,23] )
 결과: [1,4,10,19,23 ]
 
 - 참고 사이트
 https://babbab2.tistory.com/101
 https://velog.io/@sso0022/swift-%EC%A0%95%EB%A0%AC-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98-%EC%BD%94%EB%93%9C

 - NOTE: O(NlogN) 시간 복잡도를 가지며, 빠른 정렬에 속한다.
 */
func quickSort(_ arr: [Int]) -> [Int] {
    // 기본단계
    // 원소의 갯수가 0, 1이면 이미 정렬되어 있는 상태이다
//    if arr.count < 2 { return arr }
    
    guard let pivot = arr.first, arr.count >= 1 else { return arr }
    
    // 재귀(확산 단계)
    // 기준원소보다 작거나 같은 원소로 이루어진 하위 배열
    let left = array.filter{ $0 < pivot }
    
    // 기준 원소보다 큰 모든 원소로 이루어진 하위 배열
    let right = array.filter{ $0 > pivot }
    
    return quickSort(left) + [pivot] + quickSort(right)
}

let sortArr = [5,2,1,4,3]
quickSort(sortArr)


/// 다른 방법
func quickSort<T: Comparable>(_ arr: [T]) -> [T] {
    if arr.count < 2 { return arr }
    
    let pivot = arr[arr.count/2]
    let left = arr.filter{ $0 < pivot }
    let right = arr.filter{ $0 > pivot }
    
    return quickSort(left) + [pivot] + quickSort(right)
}


//: [Next](@next)
