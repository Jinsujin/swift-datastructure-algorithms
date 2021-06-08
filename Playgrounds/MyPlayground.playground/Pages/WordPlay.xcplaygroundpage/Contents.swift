//: [Previous](@previous)

import Foundation

/*
    끝말잇기
 
 1부터 n까지 번호가 붙어있는 n명의 사람이 영어 끝말잇기를 하고 있습니다. 영어 끝말잇기는 다음과 같은 규칙으로 진행됩니다.

 1번부터 번호 순서대로 한 사람씩 차례대로 단어를 말합니다.
 마지막 사람이 단어를 말한 다음에는 다시 1번부터 시작합니다.
 앞사람이 말한 단어의 마지막 문자로 시작하는 단어를 말해야 합니다.
 이전에 등장했던 단어는 사용할 수 없습니다.
 한 글자인 단어는 인정되지 않습니다.
 다음은 3명이 끝말잇기를 하는 상황을 나타냅니다.

 tank → kick → know → wheel → land → dream → mother → robot → tank

 위 끝말잇기는 다음과 같이 진행됩니다.

 1번 사람이 자신의 첫 번째 차례에 tank를 말합니다.
 2번 사람이 자신의 첫 번째 차례에 kick을 말합니다.
 3번 사람이 자신의 첫 번째 차례에 know를 말합니다.
 1번 사람이 자신의 두 번째 차례에 wheel을 말합니다.
 (계속 진행)
 끝말잇기를 계속 진행해 나가다 보면, 3번 사람이 자신의 세 번째 차례에 말한 tank 라는 단어는 이전에 등장했던 단어이므로 탈락하게 됩니다.

 사람의 수 n과 사람들이 순서대로 말한 단어 words 가 매개변수로 주어질 때, 가장 먼저 탈락하는 사람의 번호와 그 사람이 자신의 몇 번째 차례에 탈락하는지를 구해서 return 하도록 solution 함수를 완성해주세요.
 **/




// [3,3]
//let words = ["tank", "kick", "know", "wheel", "land", "dream", "mother", "robot", "tank"]
//let n = 3

// [1,3]
let words = ["hello", "one", "even", "never", "now", "world", "draw"]
let n = 2


// [0,0]
//let words = ["hello", "observe", "effect", "take", "either", "recognize", "encourage", "ensure", "establish", "hang", "gather", "refer", "reference", "estimate", "executive"]
//let n = 5


//print(0 % 3) // 0
//print(1 % 3) // 1
//print(2 % 3) // 2
//print(3 % 3) // 0
//print(9 % 3) // 0


let string = "tank"
var firstChar = Array(string)[0]
string.first
string.last
string.count

// 팁: 배열 안전하게 조회하기
// CollectionType은 indices라는 값을 가지는데, 이 값은 유효한 값의 범위를 가집니다. 이를 사용하여 다음과 같이 확장하여 안전하게 배열에서 값을 얻을 수 있습니다.
//extension Array {
//    subscript (safe index: Int) -> Element? {
//        return indices ~= index ? self[index] : nil
//    }
//}
//
//let list = [1, 2, 3]
//list[safe: 4] // nil
//list[safe: 2] // 3

/**
 문제해결
 
 - Hash연산을 하는 Dictionary 를 사용함으로써 연산 시간 감소
 -  key 의 타입은 해쉬가능한 타입이어야 하며, swift 기본타입(string, int..) 과 enum 또한 키로 사용될 수 있다
 */
func solution(_ n:Int, _ words:[String]) -> [Int] {
    // 단어 중복여부 검사
    var dic = [String: Int]()
    
    for (i, word) in words.enumerated() {
        
        let i_사람 = (i % n) + 1
        let i_round = (i / n) + 1
        
        if i > 0 {
            let before_word = words[i-1]
            if let last = before_word.last, let first = word.first { if first != last { return [i_사람, i_round] } }
        }

        // 이미 쓴 단어인지 검사
        if let oldValue = dic[word], oldValue >= 1 {  return [i_사람, i_round]}
        else { dic[word] = 1 }
    }
    return [0,0]
}

print(solution(n, words))




/**
 /// 문제점: 사람수만큼 배열을 생성하고, 또 그안에 단어배열을 저장함으로써 연산시간 증가
 func solution(_ n:Int, _ words:[String]) -> [Int] {
     // 사람 수만큼 배열 초기화
     var 사람들 = [Int: [String]]()
     for i in 0..<n {
         사람들[i] = []
     }
     
     for (i, word) in words.enumerated() {
         let index_사람 = i % n
         
         // index가 사람들에 있는 key값과 일치하면, 단어 넣기
         if var 대답 = 사람들[index_사람] {
             대답.append(word)
             사람들[index_사람] = 대답
             
             // 자신 이전의 차례의 배열 마지막번쨰 단어의 끝 글자와, 자신의 단어 첫글자가 일치하는가
             let index_before = ((index_사람 - 1) < 0) ? (n - 1) : (index_사람 - 1)
             if let beforeWord = 사람들[index_before]?.last,
                let last = beforeWord.last,
                let first = word.first
                {
                 // 이전번째의 첫글짜와 끝글자가 같지 않은 경우
                 if last != first { return [ index_사람 + 1, 대답.count] }
             }
             
             // 현재의 단어가, 이미 쓴 단어인 경우
             for j in 0..<i {
                 if words[j] == word { return [ index_사람 + 1, 대답.count] }
             }
         }
     }
     return [0,0]
 }
 
 
 */

//: [Next](@next)
