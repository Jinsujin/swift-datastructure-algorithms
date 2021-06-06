//: [Previous](@previous)

import Foundation

/*
 모의 테스트
 
 1번 수포자가 찍는 방식: 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, ...
 2번 수포자가 찍는 방식: 2, 1, 2, 3, 2, 4, 2, 5, 2, 1, 2, 3, 2, 4, 2, 5, ...
 3번 수포자가 찍는 방식: 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, 3, 3, 1, 1, 2, 2, 4, 4, 5, 5
 
 */


//let answers = [1,2,3,4,5] // return [1]
let answers = [1,3,2,4,2] // return [1,2,3]


struct Student {
    let idx: Int
    var answers: [Int] = [] // 정답배열
    var correct_count = 0 // 맞춘 정답 갯수
    
    // 문제갯수, 패턴
    init(idx: Int, count: Int, pattern: [Int]){
        self.idx = idx
        // 문제 갯수만큼 패턴으로 배열을 채운다
        for i in 0..<count {
            answers.append(pattern[i % pattern.count])
        }
    }
}


func solution(_ answers: [Int]) -> [Int] {
    let answers_count: Int = answers.count

    var 학생들: [Student] = [
        Student(idx:1, count: answers_count, pattern: [1,2,3,4,5]),
        Student(idx:2, count: answers_count, pattern: [2,1,2,3,2,4,2,5]),
        Student(idx:3, count: answers_count, pattern: [3,3,1,1,2,2,4,4,5,5])
    ]
    
    for (index, num) in answers.enumerated() {
        for (s_i, s) in 학생들.enumerated() {
            if (num == s.answers[index]) { 학생들[s_i].correct_count += 1 }
        }
    }
    
    var result: [Int] = []
    
    let max = 학생들.map({ $0.correct_count }).max()
    for 학생 in 학생들 {
        if (학생.correct_count == max) { result.append(학생.idx) }
    }
    
    return result
}

solution(answers)

//: [Next](@next)
