//: [Previous](@previous)

import Foundation

// 크레인 인형뽑기
func solution(_ board: [[Int]], _ moves: [Int]) -> Int {
    var answer = 0
    var dic = [Int: [Int]]()
    
    for i in 0..<board.count {
        var value = [Int]()
        for j in 0..<board.count { // 뒤에서 부터 값을 넣어야 한다
            let cur = board[5-j-1][i]
            if cur == 0 { continue }
            value.append(cur)
        }
        dic[i+1] = value
    }
    var boxStack = [Int]()
    
    for m in moves {
        if dic[m]!.isEmpty { continue }
        if let removed = dic[m]?.removeLast() {
            if boxStack.last == removed {
                while(boxStack.last == removed) {
                    boxStack.removeLast()
                    answer += 2
                }
            } else {
                boxStack.append(removed)
            }
        }
    }
    return answer
}


let board =
[[0, 0, 0, 0, 0],
[0, 0, 1, 0, 3],
[0, 2, 5, 0, 1],
[4, 2, 4, 4, 2],
[3, 5, 1, 3, 1]]
let moves = [1, 5, 3, 5, 1, 2, 1, 4]

//4
solution(board, moves)


func solution1_2(_ board: [[Int]], _ moves: [Int]) -> Int {
    var answer = 0
    var board = board
    var stack = [Int]()
    
    for move in moves {
        for i in 0..<board.count {
            let cur = board[i][move-1]
            if cur == 0 { continue }
            board[i][move-1] = 0
            // 바구니가 비어있지 않고, 바구니의 상단의 값과 꺼낸값이 같다면
            if (!board.isEmpty &&  stack.last == cur) {
                answer += 2
                stack.removeLast()
            } else {
                stack.append(cur)
            }
            break
        }
    }
    
    return answer
}

solution1_2(board, moves)


//: [Next](@next)
