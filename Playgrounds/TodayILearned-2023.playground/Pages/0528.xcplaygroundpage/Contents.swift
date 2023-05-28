//: [Previous](@previous)

import Foundation

// 모든 아나그램 찾기
func solution(_ str: String, t: String) -> Int {
    var anagram = [String: Int]()
    let tArr = t.split(separator: "").map({ String($0) })
    for key in tArr {
        anagram[key] = 1
    }
    
    // 0,1 까지 미리 딕셔너리에 넣어둔다
    let inputArr = str.split(separator: "").map({ String($0) })
    var dic = [String: Int]()
    for i in 0..<t.count-1 {
        let key = inputArr[i]
        if var value = dic[key] {
            value += 1
            dic.updateValue(value ,forKey: key)
        } else {
            dic[key] = 1
        }
    }
    
    var answer = 0
    var lt = 0
    for rt in t.count-1..<inputArr.count {
        let key = inputArr[rt]
        if var value = dic[key] {
            value += 1
            dic.updateValue(value, forKey: key)
        } else {
            dic[key] = 1
        }
        
        if dic == anagram { answer += 1 }
        
        // lt 를 이동한다
        let ltKey = inputArr[lt]
        if var value = dic[ltKey] {
            value -= 1
            if value == 0 {
                dic.removeValue(forKey: ltKey)
            } else {
                dic.updateValue(value, forKey: ltKey)
            }
            lt += 1
        }
    }
    
    return answer
}

// {bac}, {acb}, {cba} 3개의 부분문자열이 "abc"문자열과 아나그램
// 3
solution("bacaAacba", t: "abc")

// K 번째 큰 수
func solution2(_ k: Int, input: [Int]) -> Int {
    let loopEnd = input.count
    var set = Set<Int>()
    
    for i in 0..<loopEnd {
        for j in i+1..<loopEnd {
            for l in j+1..<loopEnd {
                set.insert(input[i] + input[j] + input[l])
            }
        }
    }
    
    let sortedSet = set.sorted(by: { $0 > $1 })
    return sortedSet[k-1]
}
// 143
solution2(3, input: [13, 15, 34, 23, 45, 65, 33, 11, 26, 42])

func solution2_2(_ k: Int, input: [Int]) -> Int {
    var selects = Array(repeating: 0, count: k)
    var set = Set<Int>()
    dfs(0, s: 0)
    
    func dfs(_ depth: Int, s: Int) {
        if depth == 3 {
            set.insert(selects.reduce(0, +))
            return
        }
        for i in s..<input.count {
            selects[depth] = input[i]
            dfs(depth + 1, s: i + 1)
        }
    }
    
    let sortedSet = set.sorted(by: { $0 > $1 })
    return sortedSet[k-1]
}

solution2_2(3, input: [13, 15, 34, 23, 45, 65, 33, 11, 26, 42])

// 올바른 괄호
func solution3(_ input: String) -> Bool {
    let arr: [String] = input.split(separator: "").map({ String($0) })
    var stack = [String]()
    
    for char in arr {
        if char == "(" { // 여는 괄호일때
            stack.append("(")
        } else { // 닫는 괄호일때
            if let last = stack.last, last == "(" {
                stack.removeLast()
            } else {
                return false
            }
        }
    }
    // 괄호가 하나라도 안없어지고 남아있다면 올바른 괄호가 아니다
    return stack.isEmpty
}

// false
solution3("(()(()))(()")

// true
solution3("(())()")


// 입력된 문자열에서 소괄호 ( ) 사이에 존재하는 모든 문자를 제거하고 남은 문자만 출력하는 프로그램을 작성하세요.
func solution4(_ input: String) -> String {
    let arr = input.split(separator: "").map({ String($0) })
    var stack = [String]()
    
    for ch in arr {
        stack.append(ch)
        if ch == ")" {
            // 여는 괄호를 뺄때까지 반복한다
//            while true {
//                let removeElem = stack.removeLast()
//                if removeElem == "(" { break }
//            }
            while(stack.removeLast() != "(") {}
        }
    }
    return stack.joined()
}

// EFLM
solution4("(A(BC)D)EF(G(H)(IJ)K)LM(N)")

//: [Next](@next)
