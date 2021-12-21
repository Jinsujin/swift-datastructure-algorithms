//: [Previous](@previous)

import Foundation
import XCTest

/*:
 ## 하샤드 수
 양의 정수 x가 하샤드 수이려면 x의 자릿수의 합으로 x가 나누어져야 합니다.
 예를 들어 18의 자릿수 합은 1+8=9이고, 18은 9로 나누어 떨어지므로 18은 하샤드 수입니다.
 자연수 x를 입력받아 x가 하샤드 수인지 아닌지 검사하는 함수, solution을 완성해주세요.
- 제한조건: x는 1 이상, 10000 이하인 정수입니다.
 */

func solution(x: Int) -> Bool {
    var y = x
    var sum = 0
    
    while(y > 0){
        sum += y % 10
        y = y / 10
    }
    return (x % sum == 0) ? true: false
}


/*:
 ## 다음 큰 숫자
 자연수 n이 주어졌을 때, n의 다음 큰 숫자는 다음과 같이 정의 합니다.

 - 조건 1. n의 다음 큰 숫자는 n보다 큰 자연수 입니다.
 - 조건 2. n의 다음 큰 숫자와 n은 2진수로 변환했을 때 1의 갯수가 같습니다.
 - 조건 3. n의 다음 큰 숫자는 조건 1, 2를 만족하는 수 중 가장 작은 수 입니다.
 - 예를 들어서 78(1001110)의 다음 큰 숫자는 83(1010011)입니다.
 - 자연수 n이 매개변수로 주어질 때, n의 다음 큰 숫자를 return 하는 solution 함수를 완성해주세요.
- n은 1,000,000 이하의 자연수 입니다.

 n: 78, result: 83
 n: 15, result: 23
 */

// 2진수 숫자를 센다
func binaryCount(_ decimal: Int) -> Int {
   let binary = String(decimal, radix: 2)
    return binary.filter({ $0 == "1" }).count
}

//binaryCount(decimal: 30) //11110 => 4개


func solution(n: Int) -> Int {
    let nBinaryCount = binaryCount(n)
    
    for i in n+1...1000000 {
        // i 의 1의 갯수가 n의 1의 갯수와 같나
        if binaryCount(i) == nBinaryCount {
            return i
        }
    }
    return 0
}




/*:
 ## 모의고사
 - 수포자는 수학을 포기한 사람의 준말입니다. 수포자 삼인방은 모의고사에 수학 문제를 전부 찍으려 합니다. 수포자는 1번 문제부터 마지막 문제까지 다음과 같이 찍습니다.

 - 1번 수포자가 찍는 방식: 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, ...
 - 2번 수포자가 찍는 방식: 2, 1, 2, 3, 2, 4, 2, 5, 2, 1, 2, 3, 2, 4, 2, 5, ...
 - 3번 수포자가 찍는 방식: 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, ...

 1번 문제부터 마지막 문제까지의 정답이 순서대로 들은 배열 answers가 주어졌을 때, 가장 많은 문제를 맞힌 사람이 누구인지 배열에 담아 return 하도록 solution 함수를 작성해주세요.

 - 제한 조건
    - 시험은 최대 10,000 문제로 구성되어있습니다.
    - 문제의 정답은 1, 2, 3, 4, 5중 하나입니다.
    - 가장 높은 점수를 받은 사람이 여럿일 경우, return하는 값을 오름차순 정렬해주세요.
 */

struct Student {
    let index: Int
    let answers: [Int]
    var correctCount: Int = 0
    
    init(_ index: Int, pattern: [Int], answersCount: Int) {
        var result: [Int] = []
        for i in 0..<answersCount {
            let answer = pattern[i % pattern.count]
            result.append(answer)
        }
        self.answers = result
        self.index = index
    }
}

func solutionTest(_ answers: [Int]) -> [Int] {
    var students = [
        Student(1, pattern: [1, 2, 3, 4, 5], answersCount: answers.count),
        Student(2, pattern: [2, 1, 2, 3, 2, 4, 2, 5], answersCount: answers.count),
        Student(3, pattern: [3, 3, 1, 1, 2, 2, 4, 4, 5, 5], answersCount: answers.count)
    ]
    
    
    // 정답 카운트
    for i in 0..<answers.count {
        for i_s in 0..<students.count {
            if students[i_s].answers[i] == answers[i] {
                students[i_s].correctCount += 1
            }
        }
    }
 
    // 가장 많은 문제를 맞힌 사람
    guard let max = students.map({$0.correctCount}).max() else {
        return []
    }
    let results = students.filter({ $0.correctCount >= max })
        .sorted(by: { $0.index < $1.index })
        .map({ $0.index })
    return results
}


/*:
 ## 소수 만들기
 주어진 숫자 중 3개의 수를 더했을 때 소수가 되는 경우의 개수를 구하려고 합니다. 숫자들이 들어있는 배열 nums가 매개변수로 주어질 때, nums에 있는 숫자들 중 서로 다른 3개를 골라 더했을 때 소수가 되는 경우의 개수를 return 하도록 solution 함수를 완성해주세요.

 - 제한사항
    - nums에 들어있는 숫자의 개수는 3개 이상 50개 이하입니다.
    - nums의 각 원소는 1 이상 1,000 이하의 자연수이며, 중복된 숫자가 들어있지 않습니다.
 
 */

// 소수 판별하기
func isPrime(_ num: Int) -> Bool {
    if num < 2 {
        return false
    }
    for i in 2..<num {
        if num % i == 0 {
            return false
        }
    }
    return true
}

//TODO: 3중 for문을 줄일 수 없을까..?
func solutionPrime(_ nums: [Int]) -> Int {
    var result = 0
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            for k in j+1..<nums.count {
                // print(i, j, k)
                let sum = nums[i] + nums[j] + nums[k]
                if isPrime(sum) { result += 1 }
            }
        }
    }
    return result
}

solutionPrime([1,2,3,4])


//: # Test
class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testHashard() {
//        let result = solution(x: 10)
//        XCTAssertEqual(result, true)
//
//        let result2 = solution(x: 11)
//        XCTAssertEqual(result2, false)
//    }
//
//    func testNextNumber() {
//        let result = solution(n: 78)
//        XCTAssertEqual(result, 83)
//
//        let result2 = solution(n: 15)
//        XCTAssertEqual(result2, 23)
//    }
    
    /// 모의고사
//    func testRandomTest() {
//        let result = solutionTest([1,2,3,4,5])
//        XCTAssertEqual(result, [1])
//
//        let result2 = solutionTest([1,3,2,4,2])
//        XCTAssertEqual(result2, [1,2,3])
//    }
    
    /// 소수 만들기
    func testPrime() {
        let result = solutionPrime([1,2,3,4])
        XCTAssertEqual(result, 1)
        
        let result2 = solutionPrime([1,2,7,6,4])
        XCTAssertEqual(result2, 4)
    }
}

//Tests.defaultTestSuite.run()





//: [Next](@next)
