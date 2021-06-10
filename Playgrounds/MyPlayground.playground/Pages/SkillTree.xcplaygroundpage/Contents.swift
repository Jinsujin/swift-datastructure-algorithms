//: [Previous](@previous)

import Foundation

/**
 스킬 트리
 예를 들어 선행 스킬 순서가 스파크 → 라이트닝 볼트 → 썬더일때, 썬더를 배우려면 먼저 라이트닝 볼트를 배워야 하고, 라이트닝 볼트를 배우려면 먼저 스파크를 배워야 합니다.

 위 순서에 없는 다른 스킬(힐링 등)은 순서에 상관없이 배울 수 있습니다. 따라서 스파크 → 힐링 → 라이트닝 볼트 → 썬더와 같은 스킬트리는 가능하지만, 썬더 → 스파크나 라이트닝 볼트 → 스파크 → 힐링 → 썬더와 같은 스킬트리는 불가능합니다.

 선행 스킬 순서 skill과 유저들이 만든 스킬트리1를 담은 배열 skill_trees가 매개변수로 주어질 때, 가능한 스킬트리 개수를 return 하는 solution 함수를 작성해주세요.
 
 입출력 예
 skill = "CBD"
 skill_trees = ["BACDE", "CBADF", "AECB", "BDA"]
 return == 2 // 가능한 스킬트리 갯수
 
 - "BACDE": B 스킬을 배우기 전에 C 스킬을 먼저 배워야 합니다. 불가능한 스킬트립니다.
 - "CBADF": 가능한 스킬트리입니다.
 - "AECB": 가능한 스킬트리입니다.
 - "BDA": B 스킬을 배우기 전에 C 스킬을 먼저 배워야 합니다. 불가능한 스킬트리입니다.
 
 */

// 테스트 케이스 1.
let skill = "CBD"
let skill_trees = ["BACDE", "CBADF", "AECB", "BDA"]

let idx = skill.index(skill.startIndex, offsetBy: 0)
String(skill[idx]) // C

skill[String.Index.init(utf16Offset: 0, in: skill)] // c

// 문자열 자르기
let startIndex = skill.index(skill.startIndex, offsetBy: 1)
String(skill[startIndex...])    // "BD"


// 문자열 배열 접근
// let array = skill.map( { String($0) })
Array(skill)[0]
Array(skill)[1]
Array(skill)[2]

// char 에 해당하는 index 가져오기
skill.firstIndex(of: "B")
var str = "abcdefg"
let str_index = str.firstIndex(of: "c")?.utf16Offset(in: str) // Result: 2

//public extension String {
//  func indexInt(of char: Character) -> Int? {
//    return index(of: char)?.encodedOffset
//  }
//}

// 감소루프
//for i in (0..<skill.count-1).reversed(){
//    print(i)
//}


/// 문자열 안에서 글자찾기
/// 글자가 있는경우, index 반환
/// 글자가 없는 경우, -1반환
func findIndex(char: Character, str: String) -> Int? {
    if let idx = str.firstIndex(of: char) {
        return idx.utf16Offset(in: str)
    }
    return nil
}

findIndex(char: "B", str: skill) //

/**
 Error: 테스트 케이스 1 일떄만 통과함
 skill: "CBD"
 */
func solution(_ skill:String, _ skill_trees:[String]) -> Int {
    var result = 0
    
    for skill_tree in skill_trees {
        var isAvailable = true // 스킬트리 조건을 만족하나
        var skill_indexlist: [Int] = []
        
        // 스킬 트리의 값이 제대로 들어있는지 검사
        for i in (0..<skill.count).reversed() { // 2,1,0
            // skill "CBD"를 뒤에서 부터 찾는다
            let idx = skill.index(skill.startIndex, offsetBy: i)
            let char = String(skill[idx]) // "D"
            
            // skill 의 글자가 뒤에서 부터 한글자씩 들어가 있나
            if let c = char.map({ $0 }).first,
               let findIdx = findIndex(char: c, str: skill_tree) {
                
                // 가장 처음 글자인 경우, 이전 글자가 없으므로 검사할 필요 없다
                if i == 0 {
                    skill_indexlist.append(findIdx)
                    break
                }
                
                // 값이 있는경우, 이전 인덱스에 해당하는 글자 검사
                let before_char = Array(skill)[i-1]
                if let _ = findIndex(char: before_char, str: skill_tree) {
                    // 값이 존재함
                    skill_indexlist.append(findIdx)
                } else {
                    // 값이 존재하지 않음
                    isAvailable = false
                    break
                }
            } // End if
        } // End for
        
        print(skill_indexlist)
        
        // skill_indexlist 값이 순서대로인지 검사
        // 오름차순 순서로 정렬 되어 있지 않다면,
        if (isAvailable) {
            for i in 0..<skill_indexlist.count-1 {
                if (skill_indexlist[i] < skill_indexlist[i+1]) {
                    isAvailable = false
                    break
                }
            }
        }
        
        if isAvailable { result += 1 }
    }
    return result
}

solution(skill, skill_trees)


//: [Next](@next)
