//: [Previous](@previous)

import Foundation

enum Direction: Int, CaseIterable {
    case right = 0
    case bottom
    case left
    case top
    // ⚠️ 주의: 2차원 배열에 적용할때는 x, y 반대로 사용해야 함
    func nextDir(_ curPos: (x: Int, y: Int)) -> (x: Int, y: Int) {
        switch self {
        case .right:
            return (x: curPos.x + 1, y: curPos.y)
        case .bottom:
            return (x: curPos.x, y: curPos.y + 1)
        case .left:
            return (x: curPos.x - 1, y: curPos.y)
        case .top:
            return (x: curPos.x, y: curPos.y - 1)
        }
    }
}

func solution(sec: Int, _ board: [[Int]]) -> [Int] {
    var sec = sec
    var dirs = Direction.allCases
    let n = board.count
    var currentPos = (x: 0, y: 0)
    var currentDirIdx = 0
    
    while(sec > 0) {
        // 1. 이동 가능한지 체크
        let nextDir = dirs[currentDirIdx].nextDir(currentPos)
        
        // 2-1. 이동이 불가능 하다면 90도 회전
        if (nextDir.x >= n || nextDir.x < 0 || nextDir.y >= n || nextDir.y < 0)
            || (board[nextDir.y][nextDir.x] == 1) {
//            if currentDirIdx >= dirs.count {
//                currentDirIdx = 0
//            }
            // tip: 0 으로 초기화하는 위 코드와 동일
            currentDirIdx = (currentDirIdx + 1) % dirs.count
            print("회전", dirs[currentDirIdx])
            sec -= 1
            continue
        }
        
        // 2-2. 이동이 가능하다면 직진
        currentPos = nextDir
        print("현재위치", currentPos)
        sec -= 1
    }
    
    return [currentPos.y, currentPos.x]
}

// answer: [2,2]
solution(sec: 10, [[0, 0, 0, 0, 0], [0, 1, 1, 0, 0], [0, 0, 0, 0, 0], [1, 0, 1, 0, 1], [0, 0, 0, 0, 0]])

// answer: [4,5]
solution(sec: 20, [[0, 0, 0, 1, 0, 1], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1], [1, 1, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0]])

// answer: [0,1]
solution(sec: 25, [[0, 0, 1, 0, 0], [0, 1, 0, 0, 0], [0, 0, 0, 0, 0], [1, 0, 0, 0, 1], [0, 0, 0, 0, 0]])


func solution2(_ input: [[Int]]) -> Int {
    let n = input.count
    var count = 0
    var ownerPos = (x: 0, y: 0)
    var dogPos = (x: 0, y: 0)
    
    // 강아지, 주인의 현재 위치를 찾아 변수에 저장
    for i in 0..<n {
        for j in 0..<n {
            if input[i][j] == 2 { ownerPos = (x: i, y: j) }
            if input[i][j] == 3 { dogPos = (x: i, y: j) }
        }
    }
    
    let dirs = [(-1,0), (0,1), (1,0), (0,-1)]
    var ownerDir = 0
    var dogDir = 0
    
    while(count < 1000) {
        count += 1
        
        // 다음에 움직일 위치를 찾는다
        let ownerNext = (x: ownerPos.x + dirs[ownerDir].0, y: ownerPos.y + dirs[ownerDir].1)
        let dogNext = (x: dogPos.x + dirs[dogDir].0, y: dogPos.y + dirs[dogDir].1)

        // 주인: 범위를 벗어나거나, 장애물(1) 을 만나면 시계방향 90 회전
        if (ownerNext.x < 0 || ownerNext.x >= n || ownerNext.y < 0 || ownerNext.y >= n)
            || input[ownerNext.x][ownerNext.y] == 1 {
            ownerDir = (ownerDir + 1) % dirs.count
        } else {
            ownerPos = ownerNext
        }
        // 강아지: 범위를 벗어나거나, 장애물(1) 을 만나면 시계방향 90 회전
        if (dogNext.x < 0 || dogNext.x >= n || dogNext.y < 0 || dogNext.y >= n)
            || input[dogNext.x][dogNext.y] == 1 {
            dogDir = (dogDir + 1) % dirs.count
        } else {
            dogPos = dogNext
        }

        // 주인과 강아지가 움직이고 난 후, 위치가 같다면 반복문 종료
        if ownerPos == dogPos {
            return count
        }
    }
    
    return 0
}

// 51
solution2([[0, 0, 0, 0, 0, 0, 1, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 0, 0, 0], [0, 0, 0, 1, 0, 0, 0, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 0, 0, 0, 2, 0, 0], [1, 0, 0, 0, 0, 0, 1, 0, 0, 0], [0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 3, 0, 0, 0, 1], [0, 0, 0, 1, 0, 1, 0, 0, 0, 0], [0, 1, 0, 1, 0, 0, 0, 0, 0, 0] ])

// 17
solution2([[1, 0, 0, 0, 1, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0, 0, 0], [0, 0, 1, 1, 0, 0, 0, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 0, 1, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 1, 0, 1, 0], [0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [0, 0, 1, 0, 0, 0, 0, 0, 2, 1], [0, 0, 0, 1, 0, 1, 0, 0, 0, 1], [0, 1, 0, 1, 0, 0, 0, 0, 0, 3] ])

//: [Next](@next)
