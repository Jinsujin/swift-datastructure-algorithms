//: [Previous](@previous)

import Foundation

/*: ## 타겟 넘버(프로그래머스)
 n개의 음이 아닌 정수들이 있습니다. 이 정수들을 순서를 바꾸지 않고 적절히 더하거나 빼서 타겟 넘버를 만들려고 합니다. 예를 들어 [1, 1, 1, 1, 1]로 숫자 3을 만들려면 다음 다섯 방법을 쓸 수 있습니다.
 
 -1+1+1+1+1 = 3
 +1-1+1+1+1 = 3
 +1+1-1+1+1 = 3
 +1+1+1-1+1 = 3
 +1+1+1+1-1 = 3
 */
// 모든 작업이 끝났을때 결과가 목표한 값과 같다면 result += 1 (DFS)
func solution(numbers: [Int], target: Int) -> Int {
    var count = 0
    func dfs(_ depth: Int, _ sum: Int) {
        if depth == numbers.count {
            if sum == target {
                count += 1
            }
            return
        }
        dfs(depth + 1, sum + numbers[depth])
        dfs(depth + 1, sum - numbers[depth])
    }
    dfs(0, 0)
    
    return count
}
// 답: 5
solution(numbers: [1,1,1,1,1], target: 3)

// 답: 2
solution(numbers: [4, 1, 2, 1], target: 4)


/*: ## 단어변환(프로그래머스)
 1. 한 번에 한 개의 알파벳만 바꿀 수 있습니다.
 2. words에 있는 단어로만 변환할 수 있습니다.
 
 예를 들어 begin이 "hit", target가 "cog", words가 ["hot","dot","dog","lot","log","cog"]라면 "hit" -> "hot" -> "dot" -> "dog" -> "cog"와 같이 4단계를 거쳐 변환할 수 있습니다.
 
 */
struct WordItem {
    let word: String
    let depth: Int
}

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
    if !words.contains(target) {
        return 0
    }
    
    func canChange(from word1: String, to word2: String) -> Bool {
        var diff = 0
        for i in 0..<word1.count {
            if Array(word1)[i] != Array(word2)[i] {
                diff += 1
            }
        }
        
        return (diff == 1)
    }
    
    func dfs(_ begin: String, _ depth: Int) -> Int {
        var queue = [WordItem]()
        queue.append(WordItem(word: begin, depth: depth))
        
        while (!queue.isEmpty) {
            let current = queue.removeFirst()
            print(current.word, current.depth)
            // 이동가능한 요소 찾기
            for w in words {
                // current.word 와 한글자 다른 단어가 w 에 있다면 => 바꿀 수 있다
                if !canChange(from: current.word, to: w) {
                    continue
                }
                if w == target {
                    return current.depth + 1
                } else {
                    queue.append(WordItem(word: w, depth: current.depth + 1))
                }
            }
            
        }
        return 0
    }
    
    return dfs(begin, 0)
}

// 4
solution("hit","cog",["hot", "dot", "dog", "lot", "log", "cog"])

// 0: 변환불가
solution("hit","cog",["hot", "dot", "dog", "lot", "log"])


//: [Next](@next)
