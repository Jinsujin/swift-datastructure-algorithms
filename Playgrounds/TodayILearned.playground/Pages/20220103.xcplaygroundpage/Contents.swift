//: [Previous](@previous)

import Foundation
import XCTest

func binarySearch(_ arr: [Int], _ find: Int) -> Int {
    var first = 0
    var last = arr.count - 1
    
    while(first <= last) {
        let mid = (first + last) / 2
        if arr[mid] == find { return mid }
        if arr[mid] > find {
            last = mid - 1
            continue
        }
        first = mid + 1
    }
    return -1
}

binarySearch([1,3,5,6], 3)



/*:
 ### 가장 큰 수
 https://programmers.co.kr/learn/courses/30/lessons/42746
 0 또는 양의 정수가 주어졌을 때, 정수를 이어 붙여 만들 수 있는 가장 큰 수를 알아내 주세요.
 예를 들어, 주어진 정수가 [6, 10, 2]라면 [6102, 6210, 1062, 1026, 2610, 2106]를 만들 수 있고, 이중 가장 큰 수는 6210입니다.
 
 numbers    return
 [6, 10, 2]    "6210"
 [3, 30, 34, 5, 9]    "9534330"
 
 */

func solution(_ numbers:[Int]) -> String {
    let answer = numbers
        .sorted(by: sort)
        .map{ String($0) }
        .joined()
    return (answer[answer.startIndex] == "0") ? "0" : answer
}

func sort(_ i: Int, j: Int) -> Bool {
    let r1 = String(i) + String(j)
    let r2 = String(j) + String(i)    
    return r1 > r2
}



/*:
 ## 안정적인 정렬(책)
 버블 정렬, 선택 정렬 알고리즘을 사용해서
 주어진 N개의 카드를 숫자 기준으로 오름차순하는 정렬 프로그램을 작성하세요.
 */
func bubbleSort(_ arr: [Int]) {
    var copyArr = arr
    
    for i in 0..<arr.count {
        for j in stride(from: arr.count - 1, through: i + 1, by: -1) {
//            print(i,j)
            if (copyArr[j] < copyArr[j-1]) {
                copyArr.swapAt(j, j-1)
            }
            
        }
    }
    print(copyArr)
}

//bubbleSort([3,2,1,0,4])


func selectionSort(_ arr: [Int]) {
    var copyArr = arr
    
    for i in 0..<arr.count {
        var minj = i
        for j in i+1..<arr.count {
            print(i, j)
            if (copyArr[j] < copyArr[minj]) { minj = j }
        }
        copyArr.swapAt(i, minj)
    }
    
    print(copyArr)

}

//selectionSort([3,2,1,0,4])



/*:
 ### 여행 경로(강의)
 https://programmers.co.kr/learn/courses/30/lessons/43164
 
 주어진 항공권을 모두 이용하여 여행경로를 짜려고 합니다. 항상 "ICN" 공항에서 출발합니다.
 항공권 정보가 담긴 2차원 배열 tickets가 매개변수로 주어질 때, 방문하는 공항 경로를 배열에 담아 return 하도록 solution 함수를 작성해주세요.

 - 모든 간선을 거쳐야 한다(한붓 그리기) => DFS(Stack)
 - 알파벳 순서로 방문한다
 
 tickets    return
 [["ICN", "JFK"], ["HND", "IAD"], ["JFK", "HND"]]    ["ICN", "JFK", "HND", "IAD"]
 [["ICN", "SFO"], ["ICN", "ATL"], ["SFO", "ATL"], ["ATL", "ICN"], ["ATL","SFO"]]    ["ICN", "ATL", "ICN", "SFO", "ATL", "SFO"]
 
 - NOTE: 이해 필요
 */
func solutionTickets(_ tickets:[[String]]) -> [String] {
    var routes = [String: [String]]()
    
    for i in 0..<tickets.count {
        // 출발 공항의 뒤에 붙인다
        let ticket = tickets[i]
        let key = ticket[0]
        let node = ticket[1]
        if !routes.keys.contains(key) {
            routes[ticket[0]] = []
        }
        routes[ticket[0]]?.append(node)
    }
    
    // 알파벳 순서의 역순으로 정렬
    for route in routes {
        routes[route.key]?.sort(by: >)
    }

    var s = [String]()
    s.append("ICN")
    
    var answer = [String]()
    
    // 스택이 빌때까지 반복한다
    while (!s.isEmpty) {
        guard let airport = s.last else { continue }
        // 갈 수 없는 조건인 경우
        // routes 에 공항으로 출발하는 표가 없거나 (맵이 비어있다)
        // routes 키의 count 가 0 인 경우
        guard let nodes = routes[airport], !nodes.isEmpty else {
            // 현재 방문한 공항(airport)을 정답 배열에 넣고, 스택에서 지운다
            answer.append(airport)
            s.popLast()
            continue
        }
        
        // 이동할 수 있는 조건인 경우
        // 스택에 다음 경로로 가기 위해 넣고, 티켓을 썼으므로 routes 에서 스택에 넣은 경로를 제거
        s.append(nodes.last!)
        routes[airport]?.popLast()
    }
    
    // 스택에서 꺼낸 역순으로 읽어야 올바른 경로가 된다
    return answer.reversed()
}




class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBigestNum() {
        let s1 = solution([6,10,2]) // "6210"
        let s2 = solution([3, 30, 34, 5, 9]) // "9534330"

        XCTAssertEqual(s1, "6210", "가장 큰 수 1")
        XCTAssertEqual(s2, "9534330", "가장 큰 수 2")
    }
    
    func testTickets() {
        let answer =  ["ICN", "JFK", "HND", "IAD"]
        let tickets = [["ICN", "JFK"], ["HND", "IAD"], ["JFK", "HND"]]
        let r = solutionTickets(tickets)
        
        let answer2 = ["ICN", "ATL", "ICN", "SFO", "ATL", "SFO"]
        //정답: ["ICN", "ATL", "ICN", "SFO", "ATL", "SFO"]
        let tickets2 = [["ICN", "SFO"], ["ICN", "ATL"], ["SFO", "ATL"], ["ATL", "ICN"], ["ATL","SFO"]]
        let r2 = solutionTickets(tickets2)

        XCTAssertEqual(r, answer, "여행경로 1")
        XCTAssertEqual(r2, answer2, "여행경로 2")
    }
}

Tests.defaultTestSuite.run()
//: [Next](@next)
