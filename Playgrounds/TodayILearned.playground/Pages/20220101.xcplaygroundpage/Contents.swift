//: [Previous](@previous)

import Foundation
import XCTest

//: # 복습
func binarySearch(_ arr: [Int], find: Int) -> Int {
    var first = 0
    var last = arr.count - 1
    while(first <= last) {
        let mid = (first + last) / 2
        if arr[mid] == find { return mid }
        if arr[mid] > find {
            last = mid - 1
        }
        first = mid + 1
    }
    return -1
}


binarySearch([1,2,3,4,5], find: 5)

func insertionSort(_ arr: [Int]) -> [Int] {
    var copyArr = arr
    
    for i in 0..<copyArr.count {
        let v = copyArr[i]
        var prevIdx = i - 1
        while(prevIdx >= 0 && copyArr[prevIdx] > v) {
            copyArr[prevIdx + 1] = copyArr[prevIdx]
            prevIdx -= 1
        }
        copyArr[prevIdx + 1] = v
    }
    return copyArr
}

//insertionSort([4,3,1,6,7])


func bubbleSort(_ arr: [Int]) -> [Int] {
    var copyArr = arr
    
    for i in stride(from: arr.count - 1, through: 1, by: -1) {
        for j in 0..<i {
            if (copyArr[i] < copyArr[j]) {
                copyArr.swapAt(i, j)
            }
        }
    }
    return copyArr
}

//bubbleSort([4,3,1,7,5])









//: # 학습
/*:
 ## 스택(백준 문제)
 https://www.acmicpc.net/problem/10828
 
 - readLine 은 Command Line Tool 에서만 사용가능
 let line = readLine() ?? ""

 // " " 를 기준으로 배열에 저장
 let lineArr = line.components(separatedBy: " ")
 */

struct Stack {
   private var elements = [Int]()
   
   mutating func push(_ element: Int) {
       self.elements.append(element)
   }
   
   mutating func pop() -> Int {
    if !self.elements.isEmpty {
        return self.elements.removeLast()
    }
    return -1
   }
   
   var empty: Int {
       if !elements.isEmpty {
           return 0
       }
       return 1
   }
   
   var top: Int {
       elements.last ?? -1
   }
   
   var size: Int {
       self.elements.count
   }
}



var stack = Stack()
let NN: Int = Int(readLine()!)!

(0..<NN).forEach { _ in
    // components 는 백준에서 컴파일 에러 뜸
//   solutionStack(readLine()!.components(separatedBy: " "))
    solutionStack(readLine()!.split(separator: " ").map { String($0) })
}

func solutionStack(_ readlines: [String]) {
   let command: String = readlines[0]
   
   switch command {
   case "push":
        let value: Int = Int(readlines[1]) ?? 0
       stack.push(value)
   case "pop":
       print(stack.pop())
   case "top":
       print(stack.top)
   case "size":
       print(stack.size)
   case "empty":
       print(stack.empty)
   default:
       break
   }
}




/*:
 ### 재귀함수
 - DFS 의 작동원리는 스택이다.
 - 함수를 재귀 호출하는 동작은 호출스택(CallStack) 에 함수를 쌓아서 실행하는 원리로 Stack과 닮았다.
 - 따라서, Stack 자료구조 대신 함수 재귀호출로 DFS 를 구현할 수 있다.
 */
func fac(_ n: Int) -> Int {
    if (n == 1) { return 1 }
    return fac(n - 1) * n
}

fac(4) // 4*3*2*1 = 24



/*:
 ## 강의-아파트 단지
 - N x N 격자로 땅이 이루어져 있다
 - 1: 아파트 지어질 곳
 - 0: 그렇지 않은 곳
 - 1이 상하좌우로 인접해 있다면 그 공간은 한개의 단지이다
 - 이동순서: 시계방향 (-1, 0) (0,1) (1,0) (0,-1)
 
 - 출력
    - 아파트 단지수 N
    - 아파트 단지의 갯수 오름차순 출력
 
 - 문제 해결
    1. 단지가 정해지지 않은 아파트 찾기
    2. 인접한 모든 아파트 식별(DFS)
    3. 단지 번호 부여
 */

// 최대보다 여유로운 크기로 만드는 것이 좋다
var grid = Array(repeating: Array(repeating: 0, count: 30), count: 30)

// 아파트 단지 식별하기 위한 index
var cnt = 0

// 아파트 단지 index 수를 세기 위한 배열 - 예) ap[2] == 10 // index 2번 단지가 10번 나왔다
var ap = [Int](repeating: 0, count: 30)



func solutionApart(_ arr: [[Int]]) -> Int {
    // 지도 크기
    let N = arr.count
    

    //1. grid 를 0,1 로 채우기
    for i in 0..<arr.count {
        for j in 0..<arr[i].count {
            grid[i][j] = arr[i][j]
        }
    }

    //2. dfs 함수 호출
    for i in 0..<N {
        for j in 0..<N {
            // 좌표에 1 이 있을떄만 dfs 호출
            if (grid[i][j] != 1) { continue }
            dfs(i,j, size: N)
            
            // 아파트 단지가 1개 식별되었다
            cnt += 1
        }
    }
    // cnt 에는 아파트 단지의 수가 들어있다
//    print(cnt)
    
    // 각 단지의 수 배열을 오름차순으로 정렬
//    let sortedApartArr = ap[2..<cnt+2].sorted()

//    for i in 0..<sortedApartArr.count {
//        print(sortedApartArr[i])
//    }
    
    return cnt
}

// return 아파트 단지 수
func dfs(_ x: Int, _ y: Int, size: Int) {
    // 좌표를 벗어난 경우
    if !(0 <= x && x < size && 0 <= y && y < size ) { return }
    
    // 이미 방문한 경우
//    if (grid[x][y] > 1) { return }
    
    // 단지가 아닌 경우
//    if (grid[x][y] == 0) { return }
    
    if (grid[x][y] != 1) { return }
    
    // 첫 아파트 단지수가 "2" 라서 +2
    grid[x][y] = cnt + 2
    
    // 각 단지의 갯수 카운트
    ap[cnt + 2] += 1
//    print("cnt==",ap[cnt + 2])
    
    
    let dx = [0,0,1,-1]
    let dy = [1,-1,0,0]
    for i in 0..<dx.count {
        let nx = x + dx[i]
        let ny = y + dy[i]
        dfs(nx, ny, size: size)
    }
}


/// 재귀함수 리펙토링
func dfsRefactor(_ x: Int, _ y: Int, size: Int) {
    // 첫 아파트 단지수가 "2" 라서 +2
    grid[x][y] = cnt + 2
    
    // 각 단지의 갯수 카운트
    ap[cnt + 2] += 1
    
    let dx = [0,0,1,-1]
    let dy = [1,-1,0,0]
    for i in 0..<dx.count {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        // 재귀함수를 부르기 전에 유효한 값인지 체크해, 함수호출을 미리 막는다
        // 4번씩 함수실행이 10번 반복되면 4^10 == 100만번 함수 호출이 일어난다
        // 재귀함수는 메모리 관점에서 큰 부담이 되므로 불필요한 호출을 줄이는 것이 중요하다.
        if !(0 <= nx && nx < size && 0 <= ny && ny < size ) { continue }
        if (grid[nx][ny] != 1) { continue }
        
        dfs(nx, ny, size: size)
    }
}



/*:
 ## 강의-욕심쟁이 조이
 https://www.acmicpc.net/problem/1937
 
 - n x n 딸기밭
 - 상하좌우로 움직일 수 있다.
 - 딸기를 수확하고 자리를 옮기면, 새로 도착한 지역은 전 지역보다 많은 딸기가 있어야 한다.
 - 최대한 많은 칸을 방문하여 수확하려고 한다. 최대로 이동할 수 있는 횟수를 출력하라
 
 - 문제해결
    - 재귀함수 중복 호출(연산)을 줄이기 위해 DP(동적 프로그래밍) 을 결합해 사용
 
 - NOTE: 이해 필요
 */


var grid2 = Array(repeating: Array(repeating: 0, count: 50), count: 50)
var dp = Array(repeating: Array(repeating: 0, count: 50), count: 50)

func solution(_ arr: [[Int]]) -> Int {
    let M = arr.count
    
    for i in 0..<M {
        for j in 0..<M {
            grid2[i][j] = arr[i][j]
        }
    }
    
    // dfs 호출
    for i in 0..<M {
        for j in 0..<M {
            // dfs 호출 결과를 2차원 배열에 저장
            if (dp[i][j] != 0) { continue }
            dp[i][j] = dfs2(i, j, size: M)
        }
    }
    
    var max = -123
    for i in 0..<M {
        for j in 0..<M {
            if (dp[i][j] > max) { max = dp[i][j] }
        }
    }
    
    // 욕심쟁이 판다 문제에서는 "칸 수의 최대값"을 구하는 것이므로 +1
    return max + 1
}

func dfs2(_ x: Int, _ y: Int, size: Int) -> Int {
    // memoization: 이미 계산된 결과가 있다면 곧바로 반환
    if (dp[x][y] != 0) { return dp[x][y] }
    
    let dx = [0,0,1,-1]
    let dy = [1,-1,0,0]
    for i in 0..<dx.count {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        // 좌표를 벗어난 경우 건너뜀
        if !(0 <= nx && nx < size && 0 <= ny && ny < size) { continue }
        
        // 재귀함수(확산) 불가능한 조건
        if (grid2[x][y] >= grid2[nx][ny]) { continue }
        
        // dp2[x][y] 에 저장된 값이 더 큰값일 경우, 둘 중 큰값을 dp 배열에 넣는다
        dp[x][y] = max(dp[x][y], dfs2(nx, ny, size: size) + 1)
    }
    //dp[x][y]에는 dp[x][y] 를 기준으로 뻗어나갈 수 있는 최대 이동 횟수가 기록되어 있다
    return dp[x][y]
}



class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApart() {
        let apart = [
            [0,1,0,1,1,0,0,0],
            [0,1,1,0,1,1,0,0],
            [0,0,1,1,1,0,0,0],
            [0,0,0,0,0,1,1,0],
            [0,1,0,1,1,1,0,0],
            [0,1,0,0,0,0,1,1],
            [1,1,0,1,0,0,1,0],
            [0,0,0,0,0,1,1,0]
        ]

        // 아파트 단지 수: 5
        // 각 단지별 갯수: 1,4,5,5,10
        let result = solutionApart(apart)
        XCTAssertEqual(result, 5, "아파트 단지 갯수")
    }
    
    func testLand() {
        let land = [
            [106, 93, 121, 10],
            [61, 48, 32, 9],
            [70, 150, 12, 53],
            [62, 38, 17, 10]
        ]

        let s = solution(land)
        XCTAssertEqual(s, 6, "욕심쟁이")
        
    }
}

Tests.defaultTestSuite.run()


//: [Next](@next)
