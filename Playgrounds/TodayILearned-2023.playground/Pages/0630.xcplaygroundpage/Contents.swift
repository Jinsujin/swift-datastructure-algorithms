//: [Previous](@previous)

import Foundation


// 사다리 타기
func solution(n: Int, _ ladders: [[Int]]) -> [String] {
    var answer: [String] = Array(repeating: "", count: n)
    
    for i in 0..<n {
        let studentName = String(Character(UnicodeScalar(65 + i)!))
        var pos = i + 1
        
        // 사다리 이동
        for ladder in ladders {
            for j in ladder {
                if j == pos { pos += 1 }
                else if j == pos - 1 { pos -= 1}
            }
        }
        // 사다리 이동이 끝난 후, 위치 저장
        answer[pos - 1] = studentName
    }
    return answer
}

func solution1_2(n: Int, _ ladders: [[Int]]) -> [String] {
    var answer = [String]()
    for i in 0..<n {
        answer.append(String(Character(UnicodeScalar(65 + i)!)))
    }
    for ladder in ladders {
        for l in ladder {
            answer.swapAt(l-1, l)
        }
    }
    return answer
}


// answer: ['D', 'B', 'A', 'C', 'E']
solution(n: 5, [[1,3], [2,4], [1,4]])
solution1_2(n: 5, [[1,3], [2,4], [1,4]])

// answer: ['A', 'C', 'B', 'F', 'D', 'G', 'E']
solution1_2(n: 7, [[1,3,5], [1,3,6], [2,4]])

// answer: ['C', 'A', 'B', 'F', 'D', 'E', 'H', 'G']
solution1_2(n: 8, [[1, 5], [2, 4, 7], [1, 5, 7], [2, 5, 7]])

// answer: ['C', 'A', 'F', 'B', 'D', 'I', 'E', 'K', 'G', 'L', 'J', 'H']
solution1_2(n: 12, [[1, 5, 8, 10], [2, 4, 7], [1, 5, 7, 9, 11], [2, 5, 7, 10], [3, 6, 8, 11]])

//: [Next](@next)
