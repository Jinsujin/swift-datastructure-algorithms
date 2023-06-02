//: [Previous](@previous)

import Foundation


func solution(_ input: Int) {
    var check = Array(repeating: -1, count: 2)
    dfs(0, sIndex: 0)
        
    func dfs(_ depth: Int, sIndex: Int) {
        if depth == 2 {
            print(check)
            return
        }
        for i in sIndex..<input {
            check[depth] = i
            dfs(depth + 1, sIndex: i + 1)
        }
    }
}
//solution(4)
//[0, 1]
//[0, 2]
//[0, 3]
//[1, 2]
//[1, 3]
//[2, 3]


// 원소 n 개인 부분집합 구하기
func solution2(_ input: Int) {
    var answer = [String]()
    var check = Array(repeating: false, count: input + 1)
    dfs(1)
    
    func dfs(_ depth: Int) {
        if depth == input + 1 {
            var temp = ""
            for i in 1...input {
                if check[i] {
                    temp += "\(i)"
                }
            }
            print(temp)
            answer.append(temp)
            return
        }

//        for i in 1...input {
            // 해당 숫자를. 선택
            check[depth] = true
            dfs(depth + 1)
            
            check[depth] = false
            dfs(depth + 1)
//        }
    }
}

solution2(3)
//123
//12
//13
//1
//23
//2
//3


//: [Next](@next)
