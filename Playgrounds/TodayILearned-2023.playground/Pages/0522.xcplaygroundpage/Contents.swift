//: [Previous](@previous)

import Foundation

/**
 집합
 - 상태 트리를 사용해 i 번째를 선택할지 안할지 분기할 수 있다
 - 재귀 사용
 */


// input 집합에서 2개의 하위 집합으로 나누었을때, 원소의 합이 같다면 true 반환
// {1, 3, 5, 7} = {6, 10} 으로 두 부분집합의 합이 16 이므로 true 반환
func solution(_ input: [Int]) -> Bool {
    let totalSum = input.reduce(0, +)
    var flag = false
    
    func dfs(_ depth: Int, sum: Int) {
        if flag { return }
        if sum > totalSum/2 { return }
        if depth == input.count {
            if totalSum - sum == sum {
                flag = true
                return
            }
            return
        }
        
        // 숫자를 집합에 포함O
        dfs(depth + 1, sum: sum + input[depth])
        
        // 숫자를 집합에 포함X
        dfs(depth + 1, sum: sum)
        return
    }
    dfs(0, sum: 0)
    return flag
}

//true
//solution([1, 3, 5, 6, 7, 10])

// weights 배열에서 limit 이 초과하지 않는 집합에서 가장 큰 집합의 합계
func solution2(_ limit: Int, weights: [Int]) -> Int {
    var result = 0
    dfs(0, sum: 0)
    
    func dfs(_ depth: Int, sum: Int) {
        if sum > limit { return }
        if depth == weights.count {
            // 선택된 원소의 총 합이 limit 안이라면
            if limit > sum {
                result = max(result, sum)
            }
            return
        }
        
        // 선택한다, 선택하지 않는다
        dfs(depth + 1, sum: sum + weights[depth])
        dfs(depth + 1, sum: sum)
    }
    return result
}
//242
solution2(259, weights: [81,58,42,33,61])


//: [Next](@next)
