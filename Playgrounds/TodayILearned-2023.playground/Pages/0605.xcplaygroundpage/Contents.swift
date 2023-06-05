//: [Previous](@previous)

import Foundation

// 특정 문자 뒤집기(two pointer)
func solution(_ input: String) -> String {
    var inputStr: String = input
    var result: [String] = input.split(separator: "").map{ String($0) }
    var lt = 0
    var rt = input.count - 1

    while(lt < rt) {
        if inputStr.isLetterChar(at: lt) == false {
            lt += 1
        } else if inputStr.isLetterChar(at: rt) == false {
            rt -= 1
        } else {
            print(lt, rt)
            result.swapAt(lt, rt)
            inputStr = result.joined(separator: "")
            lt += 1
            rt -= 1
        }
    }
    return result.joined(separator: "")
}

extension String {
    func isLetterChar(at index: Int) -> Bool {
        return self[self.index(self.startIndex, offsetBy: index)].isLetter
    }
}

// input: "a#b!GE*T@S" | Output: "S#T!EG*b@a"
solution("a#b!GE*T@S")

// 중복 문자 제거
func solution2(_ input: String) -> String {
    var result = ""
    var currentIndex = 0
    
    for i in 0..<input.count {
        let char = input[input.index(input.startIndex, offsetBy: i)]
        if let index = input.firstIndex(of: char) {
            let intIndex = input.distance(from: input.startIndex, to: index)
            if i == intIndex { // 처음 등장한 문자인것
                result += String(char)
            }
        }
    }
    return result
}

// input: "ksekkset" | Output: "kset"
solution2("ksekkset")

//: [Next](@next)
