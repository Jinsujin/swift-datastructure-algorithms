//: [Previous](@previous)

import Foundation

/*
 모의 테스트
 
 */

struct Student {
    var answers: [Int] = [] // 정답배열
    var correct_count = 0 // 맞힌 정답 갯수
    
    // 문제갯수, 패턴
    init(count: Int, pattern: [Int]){
        // 문제 갯수만큼 패턴으로 배열을 채운다
        for i in 0..<count { // 0 ~ 9
            answers.append(pattern[i % pattern.count])
        }
        
    }
}


let answers = [1,2,3,4,5]
//let answers = [1,3,2,4,2]

func solution(_ answers: [Int]) -> [Int] {
    let answers_count: Int = answers.count

    var 학생1 = Student(count: answers_count, pattern: [1,2,3,4,5])
    var 학생2 = Student(count: answers_count, pattern: [2,1,2,3,2,4,2,5])
    var 학생3 = Student(count: answers_count, pattern: [3,3,1,1,2,2,4,4,5,5])

    // 학생이 맞힌 정답수 계산
    for (index, num) in answers.enumerated() {
        if (num == 학생1.answers[index]) { 학생1.correct_count += 1 }
        if (num == 학생2.answers[index]) { 학생2.correct_count += 1 }
        if (num == 학생3.answers[index]) { 학생3.correct_count += 1 }
    }
    
    return [학생1.correct_count, 학생2.correct_count, 학생3.correct_count]
}

solution(answers)


//: [Next](@next)
