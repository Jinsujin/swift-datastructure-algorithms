//: [Previous](@previous)

import Foundation


/**
 완주하지 못한 선수
 
 
 수많은 마라톤 선수들이 마라톤에 참여하였습니다. 단 한 명의 선수를 제외하고는 모든 선수가 마라톤을 완주하였습니다.
 마라톤에 참여한 선수들의 이름이 담긴 배열 participant와 완주한 선수들의 이름이 담긴 배열 completion이 주어질 때, 완주하지 못한 선수의 이름을 return 하도록 solution 함수를 작성해주세요.
 제한사항
 마라톤 경기에 참여한 선수의 수는 1명 이상 100,000명 이하입니다.
 completion의 길이는 participant의 길이보다 1 작습니다.
 참가자의 이름은 1개 이상 20개 이하의 알파벳 소문자로 이루어져 있습니다.
 참가자 중에는 동명이인이 있을 수 있습니다.
 
 
 
 http://minsone.github.io/mac/ios/swift-collection-types-summary
 Swift의 모든 기본 타입(String, Int, Double, Bool)은 기본적으로 해쉬가 가능하며 이 모든 타입은 딕셔너리의 키로 사용됨.
 자신만의 타입을 딕셔너리에 넣어 사용하고자 한다면 Swift 표준 라이브러리로 부터 Hashable 프로토콜을 만들어 따라야함.
 */


var namesOfIntegers = [Int: String]()

// 참여 선수들
let participant = ["leo", "kiki", "eden"]

// 완주한 선수들
let completion = ["kiki", "eden"]


var dic = [String: Int]()

dic["oreo"]
dic["oreo"] = 0
dic["remon"] = 10

dic["remon"]

dic.values

dic["oreo"] = 1

dic


func solution(all participant: [String], completion: [String]) -> String {
    var answer = ""
    var dic = [String: Int]()
    
    for p in participant {
//        if (dic[p] == nil) { dic[p] = 1 } // 초기화
//        else { dic[p] = dic[p]!+1 }
        
        if let oldValue = dic[p] {
            dic[p] = oldValue + 1
        } else {
            dic[p] = 1
        }
    }
    
    for c in completion {
//        dic[c] = dic[c]!-1
        if let oldValue = dic[c],
           let _ = dic.updateValue(oldValue-1, forKey: c) {}
    }
    
    for (name, count) in dic {
        if (count > 0) {
            answer = name
            break
        }
    }
    
    return answer
}

solution(all: participant, completion: completion)

//: [Next](@next)
