//: [Previous](@previous)

import Foundation
import XCTest

//: # 복습

/*:
 ## Stack
 - peek
 - push
 - pop
 */
struct Stack<T> {
    private var datas = [T]()
    
    mutating func push(_ element: T) {
        datas.append(element)
    }
    
    mutating func pop() -> T? {
        return datas.popLast()
    }
    
    func peek() -> T? {
        return datas.last
    }
}

var stack = Stack<Int>()
stack.push(2)
stack.pop()


/*:
 ## Queue
 - enqueue
 - dequeue
 - peek
 */
struct Queue<T> {
    private var elements = [T]()
    
    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        return elements.removeFirst()
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
}


/*:
 ## 하샤드 수
 18의 자릿수 합은 1+8=9이고, 18은 9로 나누어 떨어지므로 18은 하샤드 수입니다.
 */

func solution(_ x: Int) -> Bool {
    var xx = x
    var sum = 0
    
    while(xx > 0) {
        sum += xx % 10
        xx = xx / 10
    }
    return (x % sum == 0)
}


//: # 학습
/*:
 ## 완주하지 못한 선수
 
 수많은 마라톤 선수들이 마라톤에 참여하였습니다. 단 한 명의 선수를 제외하고는 모든 선수가 마라톤을 완주하였습니다.
 마라톤에 참여한 선수들의 이름이 담긴 배열 participant와 완주한 선수들의 이름이 담긴 배열 completion이 주어질 때, 완주하지 못한 선수의 이름을 return 하도록 solution 함수를 작성해주세요.

 - 제한사항
     - 마라톤 경기에 참여한 선수의 수는 1명 이상 100,000명 이하입니다.
     - completion의 길이는 participant의 길이보다 1 작습니다.
     - 참가자의 이름은 1개 이상 20개 이하의 알파벳 소문자로 이루어져 있습니다.
     - 참가자 중에는 동명이인이 있을 수 있습니다.
 */


func solutionMarathon(participant: [String], completion: [String]) -> String {
    var dic = [String: Int]()
    
    for name in participant {
        // 만약 키가 이미 있다면 값 +=1
        if dic.keys.contains(name) {
            let prevVal = dic[name]
            dic.updateValue(prevVal! + 1, forKey: name)
            continue
        }
        dic[name] = 1
    }
    
    for name in completion {
        dic[name]! -= 1
    }
    
    return dic.filter({ $0.value > 0 }).map({ $0.key }).first ?? ""
}



/*:
 ## 주식가격
 초 단위로 기록된 주식가격이 담긴 배열 prices가 매개변수로 주어질 때, 가격이 떨어지지 않은 기간은 몇 초인지를 return 하도록 solution 함수를 완성하세요.

 - 제한사항
     - prices의 각 가격은 1 이상 10,000 이하인 자연수입니다.
     - prices의 길이는 2 이상 100,000 이하입니다.
 */
func solutionStock(_ prices: [Int]) -> [Int] {
    var results = [Int](repeating: 0, count: prices.count)
    
    for (i_price, price) in prices.enumerated() {
        var count = 0
        for j in i_price+1..<prices.count {
            count += 1
            if (price > prices[j]) {  // 가격이 떨어짐
                break
            }
        }
        results[i_price] = count
    }
    return results
}


/*:
 ## 기능 개발
 각 기능은 진도가 100%일 때 서비스에 반영할 수 있습니다.

 또, 각 기능의 개발속도는 모두 다르기 때문에 뒤에 있는 기능이 앞에 있는 기능보다 먼저 개발될 수 있고, 이때 뒤에 있는 기능은 앞에 있는 기능이 배포될 때 함께 배포됩니다.

 먼저 배포되어야 하는 순서대로 작업의 진도가 적힌 정수 배열 progresses와 각 작업의 개발 속도가 적힌 정수 배열 speeds가 주어질 때 각 배포마다 몇 개의 기능이 배포되는지를 return 하도록 solution 함수를 완성하세요.

 - 제한 사항
 - 작업의 개수(progresses, speeds배열의 길이)는 100개 이하입니다.
 - 작업 진도는 100 미만의 자연수입니다.
 - 작업 속도는 100 이하의 자연수입니다.
 - 배포는 하루에 한 번만 할 수 있으며, 하루의 끝에 이루어진다고 가정합니다. 예를 들어 진도율이 95%인 작업의 개발 속도가 하루에 4%라면 배포는 2일 뒤에 이루어집니다.
 */
func solutionFeatureDev(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    // 남은날짜
    var queue = Queue<Int>()
    var results = [Int]()
    
    for (i_progress, progress) in progresses.enumerated() {
        let remainingPercent = (100 - progress)
        let mok = remainingPercent / speeds[i_progress]
        let left = remainingPercent % speeds[i_progress]
        let leftDay = left > 0 ? mok + 1 : mok
        queue.enqueue(leftDay)
    }
    
    while (!queue.isEmpty()) {
        let currentDay = queue.peek()
        var nextDay = queue.peek()
        var count = 0
        while (!queue.isEmpty() && currentDay! >= nextDay!) {
            count += 1
            queue.dequeue()
            nextDay = queue.peek()
//            print(currentDay, nextDay, count)
        }
        results.append(count)
    }
    return results
}




class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMarathon() {
        let result = solutionMarathon(participant: ["leo", "kiki", "eden"], completion: ["eden", "kiki"]) // "leo"
        XCTAssertEqual(result, "leo", "완주하지 못한 선수")
    }
    
    func testStock() {
        let result = solutionStock([1, 2, 3, 2, 3])
        let expect: [Int] = [4, 3, 1, 1, 0]
        XCTAssertEqual(result, expect, "주식 가격")
    }
    
    func testFeatureDev() {
        let result = solutionFeatureDev([93, 30, 55], [1, 30, 5])
        let expect: [Int] = [2,1]
        XCTAssertEqual(result, expect, "기능 개발")
    }
}

Tests.defaultTestSuite.run()


//: [Next](@next)
