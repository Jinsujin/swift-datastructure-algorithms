//: [Previous](@previous)

import Foundation
import XCTest


struct Stack<T> {
    private var elements = [T]()
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func pop() -> T? {
        return self.elements.popLast()
    }
    
    func peek() -> T? {
        return self.elements.last
    }
}




//: # 학습
/*:
 ## 그래프 표현(책) - 인접 행렬
 인접 행렬은 그래프를 2차원 배열로 표현한다.
 - 장점: M[u][v] 로 에지(u,v) 를 참조할 수 있으므로, 노드 u와 노드 v 의 관계를 상수시간O(1)에 파악 가능
 - 단점: 메모리 낭비. 노드 수의 제곱과 비례해 메모리를 소비함
 */
//let N: Int = Int(readLine()!)!

//var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: N+10), count: N+10)

//(0..<N).forEach { _ in
//    graph(readLine()!)
//}

//for i in 1...N {
//    let r = grid[i][1...N]
//        .compactMap{ String($0) }.joined(separator: " ")
//    print(r)
//}

//func graph(_ inputLine: String) {
//    let inputArr = inputLine.split(separator: " ").compactMap{ Int($0) }
//    let current = inputArr[0]
//
//    if (inputArr[1] == 0) { return }
//    var nodeList = inputArr.dropFirst(2)
//
//    while (!nodeList.isEmpty) {
//        let next = nodeList.removeFirst()
//        grid[current][next] += 1
//    }
//}





/*:
 ## 문자열 뒤집기(백준)
 https://www.acmicpc.net/problem/9093
 - reverse 메서드를 사용하지 않고 뒤집기
 
 - 예
    - 입력: I am happy today
    - 출력: I ma yppah yadot
 */
//let N: Int = Int(readLine()!)!
//
//(0..<N).forEach { _ in
//    solutionReverse(readLine()!)
//}

func solutionReverse(_ line: String) {
    let splitLine = line.split(separator: " ").map{ String($0) }
    var result = [String]()
    
    // " " 단위로 자른다
    for str in splitLine {
        let reversed = reverseString(str)
        result.append(reversed)
//        print(reversed, terminator: " ") // 배열에 담지 않고 바로 출력하는 경우
    }
    print(result.joined(separator: " "))
}

func reverseString(_ str: String) -> String {
    var copyStr = str
    var result = [Character](repeating: "a", count: copyStr.count)
    
    for i in stride(from: str.count - 1, through: 0, by: -1) {
        let val = copyStr.removeFirst()
        result[i] = val
    }
    return String(result)
}


/*:
 ## 괄호(백준)
 https://www.acmicpc.net/problem/9012
 문자열이 한쌍의 괄호가 맞으면 YES, 아니면 NO 출력
 
 - 예
    - 입력: (())())
    - 출력: NO
    - 입력: (())()
    - 출력: YES
 */

//let N: Int = Int(readLine()!)!
//
//(0..<N).forEach { _ in
//    solution(readLine()!)
//}

func solution(_ line: String) {
    check(line) ? print("YES") : print("NO")
}

func check(_ line: String) -> Bool {
    let arr = line.map { String($0) }
    var count = 0

    for item in arr {
        if item == "(" {
            count += 1
        } else if item == ")" {
            count -= 1
            if count < 0 {
                return false
            }
        }
    }
    return (count == 0)
}



/*:
 ## 스택 수열(백준)
 https://www.acmicpc.net/problem/1874
 */
var start = 0
var stack = Stack<Int>()

func main() {
    let N: Int = Int(readLine()!)!
    var results = [String]()
    var checkNo = false
    
    (0..<N).forEach { _ in
        guard let r = solution(readLine()!) else {
            checkNo = true
            return
        }
        results.append(contentsOf: r)
    }

    checkNo
        ? print("NO")
        : print(results.joined(separator: "\n"))
}



func solution(_ line: String) -> [String]? {
    let value = Int(line)!
    var results = [String]()
    
    if(value > start) {
        for i in (start + 1)...value {
            results.append("+")
            stack.push(i)
        }
        start = value
    }

    // stack 의 위에 있는 원소가 입력값과 다른 경우
    if (stack.peek() != value) {
        return nil
    }

    // stack 의 위에 있는 원소가 입력값과 같은 경우
    stack.pop()
    results.append("-")
    return results
}

//main()




/*:
 ## 큐
 https://www.acmicpc.net/problem/10845
 */
//let N: Int = Int(readLine()!)!
//var queue = [Int]()
//
//(0..<N).forEach { _ in
//    solutionQueue(readLine()!)
//}
//
//
//func solutionQueue(_ line: String) {
//    let lineArr = line.split(separator: " ").map{ String($0) }
//    let command = lineArr[0]
//
//    switch command {
//    case "push":
//        let val = Int(lineArr[1]) ?? 0
//        queue.append(val)
//    case "pop":
//        if queue.isEmpty {
//            print(-1)
//            return
//        }
//        let val = queue.removeFirst()
//        print(val)
//    case "front":
//        print(queue.first ?? -1)
//    case "back":
//        print(queue.last ?? -1)
//    case "size":
//        print(queue.count)
//    case "empty":
//        print(queue.isEmpty ? 1 : 0)
//    default:
//        break
//    }
//}


/*:
 ## DFS(책)
 인접 행렬을 통한 깊이 우선 탐색은 모든 노드의 인접 여부를 확인한다: O(|V|^2)
 그래프 사이즈가 크다면 스택 오버플로가 발생할 수 있으므로 주의 필요
 */
/// 방문 여부 표시
enum Color: Int {
    case white,gray,black
}

/// 노드 연결을 저장할 인접 행렬 - 주어진 노드갯수보다 조금 크게 만들어 out of range를 예방한다
var M: [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
var N = 0
var time = 0

/// 방문 여부 체크
var colors = [Color](repeating: .white, count: 10)

/// 노드의 발견 시점
var d = [Int](repeating: 0, count: 10)

/// 노드의 완료 시점
var f = [Int](repeating: 0, count: 10)



/// 재귀를 이용한 깊이 우선 탐색
func solutionDFS(_ nodeNum: Int, _ arr: [[Int]]) -> [String]{
    N = nodeNum
    
    // 1. 노드 정보를 2차원 배열에 채우기
    for i in 0..<nodeNum {
        let a = arr[i]
        if a[1] == 0 { continue }
        let nodeList = a.dropFirst(2)
        for v in nodeList {
            M[a[0]][v] = 1
        }
    }
    
    // 2. dfs실행
    for u in 1...N {
        // 아직 방문하지 않은 u를 시작점으로 깊이 우선 탐색
        if(colors[u] == .white) {
            dfs_visit(u)
        }
    }

    var result = [String]()
    
    // 출력
    for u in 1...N {
//        print(u, d[u], f[u])
        let str = "\(u) \(d[u]) \(f[u])"
        result.append(str)
    }
    return result
}


func dfs_visit(_ u : Int) {
    colors[u] = .gray // 방문 중 마킹
    time += 1
    d[u] = time // 첫 방문 시간 기록
    for v in 1...N {
        // u와 이어지지 않은 노드는 패스
        if(M[u][v] == 0) { continue }
        
        // 아직 방문하지 않은 경우 재귀 호출(확산 가능)
        if(colors[v] == .white) {
            dfs_visit(v)
        }
    }
    
    // 현재 노드 u 에 대한 재귀를 다 돌았다
    colors[u] = .black
    time += 1
    f[u] = time // 방문 완료
}







/*:
 ### Stack 을 사용한 DFS
 - NOTE: 재귀호출과 결과값이 다름. 확인 필요
 */
var nt: [Int] = Array(repeating: 0, count: 10)

func solutionStackDFS(_ nodeNum: Int, _ arr: [[Int]]) -> [String]{
    N = nodeNum
    
    // 1. 노드 정보를 2차원 배열에 채우기
    for i in 0..<nodeNum {
        let a = arr[i]
        if a[1] == 0 { continue }
        let nodeList = a.dropFirst(2)
        for v in nodeList {
            M[a[0]][v] = 1
        }
    }
    
    // 2. dfs실행
    for u in 1...N {
        // 아직 방문하지 않은 u를 시작점으로 깊이 우선 탐색
        if(colors[u] == .white) {
            dfs_visit_stack(u)
        }
    }

    var result = [String]()
    
    // 출력
    for u in 1...N {
        let str = "\(u) \(d[u]) \(f[u])"
        result.append(str)
        print(str)
    }
    return result
}



func dfs_visit_stack(_ r: Int) {
    for i in 1...N {
        nt[i] = 0
    }
    
    var stack = Stack<Int>()
    stack.push(r)
    colors[r] = .gray
    time += 1
    d[r] = time
    
    while(!stack.isEmpty) {
        guard let u = stack.peek() else { continue }
        guard let v = next(u) else {
            // 인접한 노드에 값이 없는 경우 == 더이상 탐색할 곳이 없다
            stack.pop()
            colors[u] = .black
            time += 1
            f[u] = time
            continue
        }
        
        // 인접한 노드에 값이 있는 경우
        if (colors[v] != .white) { continue }
        
        // 확산가능 조건 만족
        colors[v] = .gray
        time += 1
        d[v] = time
        stack.push(v)
    }
}


/// u 노드와 인접한 노드를 번호순으로 추출
func next(_ u: Int) -> Int? {
    let v = nt[u]
    
    for i in v..<N {
        nt[u] = v + 1
        if (M[u][i] == 1) {
            return i
        }
    }
    return nil
}

let dfsArr = [
    [1,2,2,3],
    [2,2,3,4],
    [3,1,5],
    [4,1,6],
    [5,1,6],
    [6,0]
]
let s = solutionStackDFS(6, dfsArr)





class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDFS() {
        let dfsArr = [
            [1,2,2,3],
            [2,2,3,4],
            [3,1,5],
            [4,1,6],
            [5,1,6],
            [6,0]
        ]
        let s = solutionDFS(6, dfsArr)

        // 노드번호, 해당 노드의 발견 시점, 해당 노드의 완료 시점
        let answer = [
            "1 1 12",
            "2 2 11",
            "3 3 8",
            "4 9 10",
            "5 4 7",
            "6 5 6"
        ]
        
        XCTAssertEqual(s, answer, "DFS 재귀 타임스탬프")
    }
}

//Tests.defaultTestSuite.run()


//: [Next](@next)
