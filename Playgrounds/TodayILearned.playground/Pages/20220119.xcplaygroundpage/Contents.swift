//: [Previous](@previous)

import Foundation

/*:
 ## 크레인 인형 뽑기
 https://programmers.co.kr/learn/courses/30/lessons/64061
 */
func solutionCrane(_ board:[[Int]], _ moves:[Int]) -> Int {
    var dic = [Int: [Int]]()
    let boardCount = board.count
    for i in 1...boardCount {
        dic[i] = []
    }
    
    // 배열 갯수
    for y in 0..<boardCount {
        for x in 0..<boardCount {
            let value = board[y][x]
            if value == 0 {
                continue
            }
            dic[x+1]?.append(value)
        }
    }
    
    for i in 1...boardCount {
        dic[i] = dic[i]?.reversed()
    }
    var basket = [Int]()
    var removeCount = 0
    
    for move in moves {
        guard let popItem = dic[move]?.popLast() else { continue }

        if basket.isEmpty {
            basket.append(popItem)
            continue
        }
        
        guard let basketItem = basket.last else {
            continue
        }
        if popItem == basketItem {
            removeCount += 2
            basket.popLast()
            continue
        }
        basket.append(popItem)
    }
    
    return removeCount
}



/*:
 ## 이상한 문자 만들기
 https://programmers.co.kr/learn/courses/30/lessons/12930
 */
func solution(_ s:String) -> String {
    let arrayStr = Array(s)
    var results: String = ""
    var index: Int = 0
    for char in arrayStr {
        var wiredChar: String = String(char)
        if char == " " {
            index = 0
            results += wiredChar
            continue
        }
        if(index % 2 == 0) {
            wiredChar = char.uppercased()
        } else {
            wiredChar = char.lowercased()
        }
        index += 1
        results += wiredChar
    }
    return results
}



//: [Next](@next)
