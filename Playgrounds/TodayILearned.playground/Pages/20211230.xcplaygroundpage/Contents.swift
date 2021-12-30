//: [Previous](@previous)

import Foundation
import XCTest


struct Stack<T> {
    private var elements = [T]()
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    mutating func pop() -> T? {
        return self.elements.popLast()
    }
    
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    func peek() -> T? {
        return self.elements.last
    }
}

struct StackIteratorProtocol<T>: IteratorProtocol {
    var currentElements: [T]
    mutating func next() -> T? {
        if !self.currentElements.isEmpty {
            return currentElements.popLast()
        }
        return nil
    }
    
}

extension Stack: Sequence {
    func makeIterator() -> StackIteratorProtocol<T> {
        return StackIteratorProtocol<T>(currentElements: self.elements)
    }
}


struct Queue<T> {
    private var elements = [T]()
    var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        self.elements.removeFirst()
    }
    
    func front() -> T? {
        return self.elements.first
    }
}

struct QueueIteratorProtocol<T>: IteratorProtocol {
    var currentElements: [T]
    
    mutating func next() -> T? {
        if !self.currentElements.isEmpty {
            return currentElements.removeFirst()
        }
        return nil
    }
}

extension Queue: Sequence {
    func makeIterator() -> QueueIteratorProtocol<T> {
        return QueueIteratorProtocol<T>(currentElements: self.elements)
    }
}



//: ### binary search
func binarySearch(_ arr: [Int], find: Int) -> Int {
    var front = 0
    var last = arr.count - 1
    
    while(front <= last) {
        let mid = (front + last) / 2
        
        if arr[mid] == find { return mid }
        if arr[mid] > find {
            last = mid - 1
            continue
        }
        front = mid + 1
    }
    return -1
}

//binarySearch([1,3,5,7,9], find: 9) // 4

//: # 학습
/*:
 ## 강의-BFS(너비 우선 탐색)
 - 물결의 파동처럼  시작노드에서 가까운 노드를 먼저 탐색하면서 범위를 넓혀간다
 
 ### 큐를 사용
 - 큐가 빌때까지 탐색을 반복 한다.
 1. 큐.dequeue() : 실제로 노드를 방문한것과 동시에 (배열에 )방문을 체크
 2. 방문한 노드의 주변 노드들을 큐에 넣는다 (큐에 들어간 노드는 방문 예정인 노드들)
 
 ### 문제- 장기
 - 8*8 장기판에서 말이 졸을 잡기위한 최소한의 이동회수를 구하라.
 - 이동반경: (2,1) (2,-1) (-2,1) (-2,-1) (1,2) (1,-2) (-1,2) (-1,-2)
 - 왼쪽위가 (1,1) 에서 시작. 아래로 내려갈수록 커진다.
 
 - NOTE: 이해 필요
 */

struct MyPoint {
    var x: Int
    var y: Int
}

extension MyPoint: Equatable {
    static func == (lhs: MyPoint, rhs: MyPoint) -> Bool {
        return lhs.x == rhs.x
                && lhs.y == rhs.y
    }
}

func solution(start: MyPoint, find: MyPoint) -> Int {
    var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    var queue = Queue<MyPoint>()
    
    // 1. 첫 위치를 넣는다(말)
    queue.enqueue(start)
    
    // 2. 큐가 빌때까지 탐색한다
    while(!queue.isEmpty) {
        guard let current = queue.dequeue() else { continue }
        
        if(current == find) {
            return grid[current.x][current.y]
        }
        
        // 말이 이동할 수 있는 좌표위치 배열
        let dx = [1,1,-1,-1,2,2,-2,-2]
        let dy = [2,-2,2,-2,1,-1,1,-1]
        for i in 0..<8 {
            let nx = current.x + dx[i]
            let ny = current.y + dy[i]
            
            // 좌표를 벗어난 경우 건너뛴다
            if !(1 <= nx && nx <= 8 && 1 <= ny && ny <= 8) { continue }
            
            // 이미 방문한 곳일 경우 건너뛴다
            if (grid[nx][ny] != 0) { continue }
            
            // 이동한 횟수를 2차원 배열에 저장한다
            // 다음좌표의 이동횟수 = 현재좌표의 이동횟수 + 1
            grid[nx][ny] = grid[current.x][current.y] + 1
            queue.enqueue(MyPoint(x: nx, y: ny))
        }
    }
    return -1
}




/*:
 ## 강의-상한 귤(BFS)
 - 상한 귤 옆에 귤이 있을경우, 하루가 지나면 상한 귤이 된다.
 - 상한귤, 귤, 빈곳 이 주어질때, 귤이 모두 상할때 까지 몇일이 걸릴까
 - 단, 귤의 인접한 곳에 상한 귤이 없다면 영원히 썩지 않는다 (-1 반환)
 - 1: 상한 귤
 - 0: 귤
 - -1: 빈 곳
 
 - NOTE: 이해 필요
 */
func solution(_ arr: [[Int]]) -> Int {
    var grid = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    var queue = Queue<MyPoint>()
    let X = -1 // 귤이 없는 경우
    let N = arr.count
    let M = arr[0].count
    
    // (1,1) 을 기준으로 grid 초기화
    for i in 1...N {
        for j in 1...M {
            grid[i][j] = arr[i-1][j-1]
            if (grid[i][j] == 1) { // 귤이 상했다
                print("상한 귤", i,j) // (2,1)
                queue.enqueue(MyPoint(x: i, y: j))
            }
        }
    }
    
    while(!queue.isEmpty) {
        guard let current = queue.dequeue() else { continue }
        
        let dx = [1,-1,0,0]
        let dy = [0,0,1,-1]

        // 현재 노드를 기준으로 4방향 탐색
        for i in 0..<dx.count {
            let nx = current.x + dx[i]
            let ny = current.y + dy[i]
            
            // 좌표를 벗어난 경우
            if !(1 <= nx && nx <= N && 1 <= ny && ny <= M) { continue }
            
            // -1 == 귤이 없을때
            if (grid[nx][ny] == X) { continue }
            
            // 아직 탐색하지 않은 좌표인 경우
            if (grid[nx][ny] == 0) {
                grid[nx][ny] = grid[current.x][current.y] + 1
                queue.enqueue(MyPoint(x: nx, y: ny))
            }
        }
     }
    
    
    // 최대 몇일이 걸렸는지 결과값 찾기
    var max = -123
    for i in 1...N {
        for j in 1...M {
            // 0 이 하나라도 있으면 모두 상하지 않았다
            if (grid[i][j] == 0) { return -1 }
            if (max < grid[i][j]) {
                max = grid[i][j]
            }
        }
    }
    return max - 1
}



class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test() {
        let s = solution(start: MyPoint(x: 4, y: 4), find: MyPoint(x: 4, y: 6)) // 2
        XCTAssertEqual(s, 2, "장기 테스트")
    }
    
    func testTomato() {
        let s1 = solution([[0,-1,0], [0,0,0], [-1,1,0]]) // 3
        let s2 = solution([[0,-1,1], [0,-1,0], [-1,0,0]]) // -1
        XCTAssertEqual(s1, 3, "상한 토마토 테스트1")
        XCTAssertEqual(s2, -1, "상한 토마토 테스트2")
    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
