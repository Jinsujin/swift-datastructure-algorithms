//: [Previous](@previous)

import Foundation


/*: 재귀 복습
 
 */
func factorial(_ n: Int) -> Int {
    if n <= 1 { return n }
    return n * factorial(n - 1)
}

factorial(3) // 6

// 3! = 3 * 2 * 1
// n! = n * (n-1) * (n-2) = n * (n-1)
// = 6

// 피보나치 수열

/*: 분할정복 알고리즘
 문제를 부분 문제로 분할하여 재귀적으로 해결한 다음, 해결한 부분 문제의 답을 합쳐 원래 문제를 해결
 
 */

/// 배열 A 의 l~r 범위(r 포함하지 않음) 에서 최대값을 구하는 알고리즘
func findMaximum(_ A: [Int], l: Int, r: Int) -> Int {
    // divide
    // List 에서 중간 index를 구함
    let m = (l + r) / 2
    
    // 재귀탈출 조건: 요소 개수가 1개
    if (l == r - 1) {
        return A[l]
    } else {
        // 앞부분 문제 해결
        let u = findMaximum(A, l: l, r: m)
        // 뒷부분 문제 해결
        let v = findMaximum(A, l: m, r: r)
        let x = max(u, v)
        return x
    }
}

var array = [1,2,3,4,5,6]
array.shuffle()
let first = array.first
let last = array.last
print(findMaximum(array, l: 0, r: array.count - 1))


/*: 병합정렬
 
 - 일반 반으로 쪼개고 나중에 합친다
 - 정렬된 2가지 부분 집합을 합쳐서 하나의 큰 집합을 만든다
 - 합치는 순간에 정렬한다
 [6,7] + [5,8] => [5,6,7,8]
 */

/*
// 데이터 갯수
let number = 5
var sorted = [Int](repeating: 0, count: 5) // 모든함수가 동일하게 사용할 전역변수로 선언

/// 2개의 배열을 하나의 배열로 합치는 함수
/// m: 시작점, middle: 중간점, n: 끝점
func merge(_ arr: inout [Int], m: Int, middle: Int, n: Int) {
    var i = m // 합칠 집합A 의 시작 index
    var j = middle + 1 // 합칠 집합 B의 시작 index
    var k = m // A + B 의 결과배열 시작 index
    
    // 작은 순서대로 배열에 삽입
    // 집합A 의 index(i)를 한칸씩 이동, 집합B 의 index(j)를 한칸씩 이동
    // i, j 를 비교해 더 작은값을 결과배열 k 위치에 넣어줌
    while(i <= middle && j <= n) {
        if(arr[i] <= arr[j]) {
            // 집합 A의 i 번째값이 집합 B의 j 보다 작다면
            sorted[k] = arr[i]
            i += 1
        } else {
            sorted[k] = arr[j]
            j += 1
        }
        k += 1
    }
    // 넣고 남은 데이터 삽입
    if(i > middle) {
        // 집합 A 의 i 가 먼저 끝난것 => 남은 집합 B의 j 번째 원소를 삽입
        for t in (j..<n) {
            sorted[k] = arr[t]
            k += 1
        }
    } else {
        for t in (i..<middle) {
            sorted[k] = arr[t]
            k += 1
        }
    }
    // 정렬된 배열을 실제배열로 옮겨줌
    for t in m..<n {
        arr[t] = sorted[t]
    }
}

func mergeSort(_ arr: [Int], m: Int, n: Int) -> [Int] {
    // 크기가 1보다 큰 경우
    if(m < n) {
        // 반으로 나누고 나중에 합침
        var a = arr
        let middle = (m + n) / 2
        mergeSort(a, m: m, n: middle)
        mergeSort(a, m: middle + 1, n: n)
        merge(&a, m: m, middle: middle, n: n)
        return a
    }
    return []
}

var array2 = [4,6,2,1,9]
mergeSort(array2, m: 0, n: array2.count - 1)
*/


/// https://babbab2.tistory.com/102
//func mergeSort(_ arr: [Int]) -> [Int] {
//    if arr.count <= 1 { return arr }
//    let middle = arr.count / 2
//    let left = Array(arr[0..<middle])
//    let right = Array(arr[middle..<arr.count])
//
//    func merge(_ l: [Int], _ r: [Int]) -> [Int] {
//        var l = l
//        var r = r
//        var result = [Int]()
//
//        while(!l.isEmpty && !r.isEmpty) {
//            if l[0] < right[0] {
//                result.append(l.removeFirst())
//            } else {
//                result.append(r.removeFirst())
//            }
//        }
//        if !l.isEmpty {
//            result.append(contentsOf: l)
//        }
//        if !r.isEmpty {
//            result.append(contentsOf: r)
//        }
//        return result
//    }
//    return merge(mergeSort(left), mergeSort(right))
//}
//
//let array2 = [4,6,2,1,9]
//print(mergeSort(array2))



func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
    // 1
    var leftIndex = 0
    var rightIndex = 0

    // 2. reserveCapacity 로 배열의 크기 설정
    // leftArray + rightArray = 총 배열 크기
    var orderedPile = [Int]()
    orderedPile.reserveCapacity(leftPile.count + rightPile.count)

    // 3. leftArray와 rightArray의 요소 하나하나의 크기를 비교하여 작은 것부터
    // orderdPile array에 append() 메소드를 이용해 삽입
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            // left, right 요소가 같은 경우
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }

    // 4. 왼쪽배열, 오른쪽배열에 남아있는 요소가 있다면 왼쪽배열부터 결과배열에 넣어줌
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }

    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }

    return orderedPile
}

func mergeSort(_ array: [Int]) -> [Int] {
    // 1. 요소가 1이 될때까지 배열을 쪼갠다
    guard array.count > 1 else { return array }
    let middleIndex = array.count / 2
    let left = mergeSort(Array(array[0..<middleIndex]))
    let right = mergeSort(Array(array[middleIndex..<array.count]))
    // 2. 모든 요소를 쪼갠후에, merge 시작
    return merge(leftPile: left, rightPile: right)
}

let array3 = mergeSort([6, 5, 3, 1, 8, 7, 2, 4])
print(array3)

//: [Next](@next)
