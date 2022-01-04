//: [Previous](@previous)

import Foundation


//: # 학습
/*:
 ## 재귀
 자기 자신을 호출하는 함수
 
 팩토리얼
 n! = n * (n - 1) * (n - 2)
 3! = 3 * 2 * 1
 */

func factorial(_ n: Int) -> Int {
    if n == 1 { return 1 }
    return n * factorial(n - 1)
}
// 3 * (3-1) // 3 * 2
// 2 * (2-1) // 2 * 1

factorial(3)



/*:
 ## 동적 계획법
 한번 계산한 결과를 기록해 두고, 같은 계산이 반복되면 이 기록을 활용한다.
 점화식을 만들고 이를 기반으로 반복해서 최적의 답을 계산한다.
 O(mn) 의 메모리 영역이 필요.
 
 기록하면서 재귀하는 방식을 memoization 재귀라고 부른다.

 - 피보나치 수열 만들기
    - 점화식: n = (n-1) + (n+2)
    - n == 0 이면, 0
    - n == 1 이면, 1
 
 - 참고자료
 https://shoark7.github.io/programming/algorithm/%ED%94%BC%EB%B3%B4%EB%82%98%EC%B9%98-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98%EC%9D%84-%ED%95%B4%EA%B2%B0%ED%95%98%EB%8A%94-5%EA%B0%80%EC%A7%80-%EB%B0%A9%EB%B2%95
 
 */
// 이미 연산한 식을 다시 연산하는 낭비가 있다.=> memoization 을 사용하면 복잡도 개선 가능
func fibonacci(_ n: Int) -> Int {
    if (n == 0 || n == 1) { return 1 }
    return fibonacci(n - 2) + fibonacci(n - 1)
}


var dp = Array(repeating: -1, count: 50)

func fib(_ n: Int) -> Int {
    // 기저사례(base case): 재귀함수가 끝나도록 하는 조건
    if (n == 0 || n == 1) {
        dp[n] = 1
        return dp[n]
    }
    // 기저사례 2
    if (dp[n] != -1) {
        return dp[n]
    }
    dp[n] = fib(n - 1) + fib(n - 2)
    return dp[n]
}

fib(5) // 8
fib(2)





/*:
 배열에서 최댓값을 선형 탐색이 아닌 분할 정복 알고리즘으로 찾기.
 - 분할 정복 알고리즘:
    1. 문제를 부분 문제로 분할한다.
    2. 부분 문제를 재귀적으로 해결한다.
    3. 부분 문제의 답을 통합해 원래 문제를 해결한다.
 
 findMacimum( A, l, r)
 - 배열 A 의 l ~ r 범위에서 최대값 반환
 */
//var count = 0

func findMaximum(_ arr: [Int],_ first: Int,_ last: Int) -> Int {
    let mid = (first + last) / 2
    if first == last-1 { return arr[first] }
    
    // 절반씩 나누어서 탐색한다.
    let u = findMaximum(arr, first, mid)
    let v = findMaximum(arr, mid, last)
    let x = max(u, v)
//    count += 1
    return x
}


let arr = [1,2,3,4,5,6] // 0 ~ 5,
print(findMaximum(arr, 1, 6)) // 4


/*:
 ## 전체 탐색(Exhaustive Search)
 
 수열 A 와 정수 m이 있을떄, A 의 요소 내부에서 몇개의 요소를 더했을때, m을 만들 수 있는지 판정하는 함수를 구현하라

 입력
 - n: 수열 A의 길이 5
 - A 의 정수 배열 [1,5,7,10,21]
 - q: 4
 - q개의 정수 배열 [2,4,17,8]
 
 - NOTE: 잘 모르겠음
 */

let A = [1,5,7,10,21]
let m = [2,4,7,8]

func solution() {
    for i in 0..<m.count {
        solve(0, 7) // A 배열요소의 합이 7 이 될 수 있나?
//        if (solve(0, 7)) {
//            print("yes")
//        }
    }
}

// i: , m: 목표숫자
func solve(_ i: Int,_ m: Int) -> Int {
    if (m == 0) { return 1 }
    if (i >= A.count) { return 0 }
//    let res: Int = solve(i + 1, m) || solve(i + 1, m - A[i])
//    return res
    return 0
}

//: [Next](@next)
