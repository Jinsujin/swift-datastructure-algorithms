//: [Previous](@previous)

import Foundation

/*: N으로 표현(동적 계획법)
 프로그래머스
 */

// ❌ 테스트 3/10 만 통과
func solution(_ N:Int, _ number:Int) -> Int {
    
//    let numbers = [55, (5+5), (5*5), (5/5)]
    let doubleNum = Int(String(N)+String(N))!
    let numbers: [Int] = [
        N*N, N/N, N+N, doubleNum
    ]
    let max = 9999
    var count = max
    
    func dfs(_ c: Int, _ sum: Int) {
        if c > 8 { return }
        if sum == number {
            count = min(count, c)
            return
        }
        // count:2 | 55+5, 55/5, 55*5
            // count:3 | (55+5)+5, (55/5)/5, (55*5)*5
        
        // count:2 | (5+5)+5, (5+5)/5, (5+5) *5
            // count:3 | ((5+5)+5)+5, (5+5)/5/5, (55*5)*5*5
        dfs(c + 1, sum + N)
        dfs(c + 1, sum / N)
        dfs(c + 1, sum * N)
        dfs(c + 1, Int(String(sum)+String(N))!)
    }
    
    for num in numbers {
        dfs(2, num)
    }
    
    return (count == max) ? -1 : count
}

// 4
//solution(5, 12)

// 3
//solution(2, 11)

/**
 i = 2 일때, 1번 반복:
     // j = 1 | (i-j) = 1
 => N = 5일때, 5 를 두번 연산해야 함
 
 i = 3일때, 1번 반복:
     // j = 1 | (i-j) = 2
 => 1 + 2 = 3개(i) 이므로, 1 번과 2 번을 연산
 
 i = 4일때, 2번 반복:
     // j = 1 | (i-j) = 3
     // j = 2 | (i-j) = 2
 => 4(i)가 되는 경우 3-1, 2-2 를 연산
 
 i = 5일때, 2번 반복:
     // j = 1 | (i-j) = 4
     // j = 2 | (i-j) = 3
 => 5(i) 가 되는 경우 1-4, 2-3 연산
 
 i = 6일때, 3번 반복:
     // j = 1 | (i-j) = 5
     // j = 2 | (i-j) = 4
     // j = 3 | (i-j) = 3
 => 6(i) 가 되는경우 1-5, 2-4, 3-3 연산
 */

func solution2(_ N:Int, _ number:Int) -> Int {
    var listSet = Array(repeating: Set<Int>(), count: 9)
    listSet[1].insert(N)
    
    if N == number {
        return 1
    }
    
    for i in 2...8 { // N 은 최대 8개만 사용 가능
        for j in 1...i/2 {
//            print("사용한개수 i = \(i), j = \(j)")
     
            // 값을 채워넣을 박스
            let aSet = listSet[i - j] // 2-1 = 1
            let bSet = listSet[j] // 1
            
            calc(&listSet[i], aSet, bSet)
            calc(&listSet[i], bSet, aSet)
            
        }
        let nn = String(N)
        var doubleNum = nn
        for _ in 0..<i-1 {
            doubleNum += nn
        }
        listSet[i].insert(Int(doubleNum)!)
        
        for num in listSet[i] {
            if num == number {
                return i
            }
        }
    }
    
    return -1
}


func calc(_ union: inout Set<Int>, _ aSet: Set<Int>, _ bSet: Set<Int>) {
    for a in aSet {
        for b in bSet {
            union.insert(a + b)
            union.insert(a * b)
            union.insert(a - b)
            if b != 0 {
                union.insert(a / b)
            }
        }
    }
}



//i = 2, j = 1
//i = 3, j = 1
//i = 4, j = 1
//i = 4, j = 2
//i = 5, j = 1
//i = 5, j = 2
//i = 6, j = 1
//i = 6, j = 2
//i = 6, j = 3
//i = 7, j = 1
//i = 7, j = 2
//i = 7, j = 3
//i = 8, j = 1
//i = 8, j = 2
//i = 8, j = 3
//i = 8, j = 4


// 4
solution2(5, 12)

// 3
solution2(2, 11)

//: [Next](@next)
