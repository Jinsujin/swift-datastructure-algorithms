//: [Previous](@previous)

import Foundation
import XCTest

//: 학습
/**
 타겟 넘버(프로그래머스)
 https://programmers.co.kr/learn/courses/30/lessons/43165
 
 +4+1-2+1 = 4
 +4-1+2-1 = 4
 
 */

func solution(_ numbers:[Int], _ target:Int) -> Int {
    var count = 0
    dfs(0,0)
    
    func dfs(_ index: Int,_ result: Int) {
        if index == numbers.count {
            if result == target {
                count += 1
            }
            return
        }
        let plusResult = result + numbers[index]
        let minusResult = result - numbers[index]
//        print(index, plusResult, minusResult)
        dfs(index + 1, plusResult)
        dfs(index + 1, minusResult)
    }
    
    return count
}



class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test() {
        let result1 = solution([1,1,1,1,1], 3) // 5
        let result2 = solution([4,1,2,1], 4) // 2
        XCTAssertEqual(result1, 5)
        XCTAssertEqual(result2, 2)
    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
