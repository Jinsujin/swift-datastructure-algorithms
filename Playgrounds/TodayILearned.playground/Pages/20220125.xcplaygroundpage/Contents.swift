//: [Previous](@previous)

import Foundation
import XCTest

/*: 완전탐색
 가능한 모든 가짓수를 계산한다.
 구현 방법에는 2가지가 있다:
 - 순열
 - 백트래킹
 
 무식한 풀이 방법으로, 사람은 편하지만 기계는 힘들다.
 
 1억번 연산 == 1초
 - O(N): 1억
 - O(NlogN): 5백만
 - O(N^2): 1만
 - O(N!): 11
 */



/*:
 ## 오픈 채팅방
 https://programmers.co.kr/learn/courses/30/lessons/42888
     
 let record = ["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]
 let result = ["Prodo님이 들어왔습니다.", "Ryan님이 들어왔습니다.", "Prodo님이 나갔습니다.", "Prodo님이 들어왔습니다."]
 
 
 ["Enter", "Leave", "Change"]
 */

func solution(_ record:[String]) -> [String] {

    let reversedRecords: [String] = record.reversed()

    // 1. 최근에 변경한 아이디를 딕셔너리에 등록한다
    var 최근변경한아이디들 = [String: String]()
    
    for i in 0..<reversedRecords.count {
        let splitRecord = reversedRecords[i].split(separator: " ")
        if splitRecord[0] == "Leave" {
            continue
        }
        // change 와 Enter 일때 [2] 에 바뀐 닉네임이 들어있다
        let targetId = splitRecord[1]
        
        // 이미 등록된 아이디이면, 갱신된것 => 딕셔너리에 등록할 필요 없다
        if 최근변경한아이디들.keys.contains(String(targetId)) {
            continue
        }
        
        // 딕셔너리에 아이디가 없다 => 등록필요
        최근변경한아이디들[String(targetId)] = String(splitRecord[2])
    }
    
    var result = [String]()
    
    // 2. record 배열을 돌면서 result 배열을 만든다
    for str in record {
        let splitRecord = str.split(separator: " ")
        guard let nickname = 최근변경한아이디들[String(splitRecord[1])] else { continue }
        
        switch splitRecord[0] {
        case "Enter":
            result.append("\(nickname)님이 들어왔습니다.")
        case "Leave":
            result.append("\(nickname)님이 나갔습니다.")
        default:
            continue
        }
    }
    
    return result
}




/*:
 ## 음양 더하기
 https://programmers.co.kr/learn/courses/30/lessons/76501
 */

func solution(_ absolutes:[Int], _ signs:[Bool]) -> Int {
    var total = 0
    
    for i in 0..<absolutes.count {
        let val = signs[i] ? absolutes[i] : -absolutes[i]
        total += val
    }
    return total
}




/*:
 ## DFS
깊이 우선 방문
 
 */

// 현재배열보다 1개 더큰 갯수로 배열 초기화
var visited: [Bool] = Array(repeating: false, count: 9)
//var graph: [[Int]] = Array(repeating: [Int](), count: 9)
//
var graph: [[Int]] = [
    [], // 보통 1번부터 시작하므로 0번째는 빈 배열로 선언
    [2,3,8],
    [1,7],
    [1,4,5],
    [3,5],
    [3,4],
    [7],
    [2,6,8],
    [1,7]
]

/// x: 방문하려는 노드 번호
func dfs(_ x: Int) {
    // 현재 노드를 방문했다고 체크
    visited[x] = true
    print(x)
    
    // x 와 연결된 인접 노드를 하나씩 방문
    for i in 0..<graph[x].count {
        let y = graph[x][i]
        if (!visited[y]) { dfs(y) }
    }
}


// 1 2 7 6 8 3 4 5
dfs(1)


class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOpenChat() {
        let record = ["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]
        let expect = ["Prodo님이 들어왔습니다.", "Ryan님이 들어왔습니다.", "Prodo님이 나갔습니다.", "Prodo님이 들어왔습니다."]
        let result = solution(record)
        
        XCTAssertEqual(result, expect)
    }
    
    func testPlusValues() {
        //[4,7,12]    [true,false,true]    9
        //[1,2,3]    [false,false,true]    0

        let absolutes = [4,7,12]
        let signs = [true,false,true]
        let result = solution(absolutes, signs)
        XCTAssertEqual(result, 9)

    }
}

//Tests.defaultTestSuite.run()


//: [Next](@next)
