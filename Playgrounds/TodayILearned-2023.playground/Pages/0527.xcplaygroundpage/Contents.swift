//: [Previous](@previous)

import Foundation

// 최대 길이 연속 부분 수열
func solution(K: Int, _ input: [Int]) -> Int {
    var answer = 0
    var changeCount = 0 // 0 -> 1 로 바꾼 횟수
    var lt = 0
    
    for rt in 0..<input.count {
        if input[rt] == 0 { changeCount += 1 }
        while(changeCount > K) {
            if input[lt] == 0 { changeCount -= 1 }
            lt += 1
        }
        answer = max(answer, rt - lt + 1)
    }
    return answer
}

// 8
solution(K: 2, [1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1])


func solution2(_ input: String) -> String {
    let arr:[String] = input.split(separator: "").map({ String($0) })
    var dic = [String: Int]()
    
    for key in arr {
        if let value = dic[key] {
            dic.updateValue(value + 1, forKey: key)
        } else {
            dic[key] = 0
        }
    }
    return dic.sorted(by: { $0.1 > $1.1 }).first?.key ?? ""
}

// C
solution2("BACBACCACCBDEDE")

func solution3(_ input1: String, input2: String) -> Bool {
    var dic = [String: Int]()
    let arr1 = input1.split(separator: "").map({ String($0) })
    let arr2 = input2.split(separator: "").map({ String($0) })
    
    for str in arr1 {
        if let value = dic[str] {
            dic.updateValue(value + 1, forKey: str)
        } else {
            dic[str] = 1
        }
    }
    
    for str in arr2 {
        if var value = dic[str] {
            value -= 1
            print(str, value)
            if value <= 0 {
                dic.removeValue(forKey: str)
            } else {
                dic.updateValue(value, forKey: str)
            }
        } else {
            // 다른 단어가 들어온 경우=> 아나그램 아님
            return false
        }
    }
    return dic.isEmpty
}

// true
//solution3("AbaAeCe", input2: "baeeACA")

// false
//solution3("abaCC", input2: "Caaab")

// 매출액의 종류
func solution4(day: Int, input: [Int]) -> [Int] {
    var answer = [Int]()
    var lt = -1
    
    for rt in day-1..<input.count {
        lt += 1
        print("\(lt) ~ \(rt)")
        answer.append(Set(input[lt...rt]).count)
    }
    return answer
}
// [3,4,4,3]
//solution4(day: 4, input: [20, 12, 20, 10, 23, 17, 10])


func solution4_2(day: Int, input: [Int]) -> [Int] {
    var answer = [Int]()
    var dic = [Int: Int]() // 해당 숫자가 몇번 나왔나 기록
    var lt = 0
    
    for i in 0..<day { // [0]~[3] 데이터를 미리 딕셔너리에 저장
        let key = input[i]
        if let value = dic[key] {
            dic.updateValue(value + 1, forKey: key)
        } else {
            dic[key] = 1
        }
    }
    answer.append(dic.count)
    
    for rt in day..<input.count {
        let key = input[rt]
        if let value = dic[key] {
            dic.updateValue(value + 1, forKey: key)
        } else {
            dic[key] = 1
        }
        
        // lt 에 해당하는 값을 딕셔너리에서 뺸다
        let leftKey = input[lt]
        if var value = dic[leftKey] {
            value -= 1
            if value == 0 {
                dic.removeValue(forKey: leftKey)
            } else {
                dic.updateValue(value, forKey: leftKey)
            }
            lt += 1
        }
        print("\(lt) ~ \(rt)")
        print(dic)
        answer.append(dic.count)
    }
    return answer
}
// [3,4,4,3]
//solution4_2(day: 4, input: [20, 12, 20, 10, 23, 17, 10])


func solution4_3(day: Int, input: [Int]) -> [Int] {
    var answer = [Int]()
    var dic = [Int: Int]() // 해당 숫자가 몇번 나왔나 기록
    var lt = 0
    
    for i in 0..<day-1 { // [0]~[2] 데이터를 미리 딕셔너리에 저장
        let key = input[i]
        if let value = dic[key] {
            dic.updateValue(value + 1, forKey: key)
        } else {
            dic[key] = 1
        }
    }
    
    for rt in day-1..<input.count { // 3~끝까지
        let key = input[rt]
        if let value = dic[key] {
            dic.updateValue(value + 1, forKey: key)
        } else {
            dic[key] = 1
        }
        answer.append(dic.count)

        let leftKey = input[lt]
        if var value = dic[leftKey] {
            value -= 1
            if value <= 0 {
                dic.removeValue(forKey: leftKey)
            } else {
                dic.updateValue(value, forKey: leftKey)
            }
            lt += 1
        }
    }
    return answer
}
// [3,4,4,3]
solution4_3(day: 4, input: [20, 12, 20, 10, 23, 17, 10])


//: [Next](@next)
