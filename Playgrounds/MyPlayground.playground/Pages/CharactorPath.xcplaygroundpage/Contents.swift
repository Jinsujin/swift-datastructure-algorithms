//: [Previous](@previous)

import Foundation

/**
 방문 길이
 
 게임 캐릭터를 4가지 명령어를 통해 움직이려 합니다. 명령어는 다음과 같습니다
 캐릭터는 좌표평면의 (0, 0) 위치에서 시작합니다. 좌표평면의 경계는 왼쪽 위(-5, 5), 왼쪽 아래(-5, -5), 오른쪽 위(5, 5), 오른쪽 아래(5, -5)로 이루어져 있습니다.
 이때, 우리는 게임 캐릭터가 지나간 길 중 캐릭터가 처음 걸어본 길의 길이를 구하려고 합니다. 예를 들어 위의 예시에서 게임 캐릭터가 움직인 길이는 9이지만, 캐릭터가 처음 걸어본 길의 길이는 7이 됩니다. (8, 9번 명령어에서 움직인 길은 2, 3번 명령어에서 이미 거쳐 간 길입니다)

 단, 좌표평면의 경계를 넘어가는 명령어는 무시합니다.

 
 U: 위쪽으로 한 칸 가기
    y+=1
 D: 아래쪽으로 한 칸 가기
    y-=1
 
 R: 오른쪽으로 한 칸 가기
    x+=1
 
 L: 왼쪽으로 한 칸 가기
    x-=1
 
 dirs                       answer
 "ULURRDLLU"        7
 "LULLLLLLU"            7
 */


struct Path {
    let start: CGPoint
    let end: CGPoint
}

func solution(_ dirs:String) -> Int {
    var paths: [Path] = []
    var currentPoint = CGPoint(x: 0, y: 0)
    var result: Int = 0
    
    let chars = Array(dirs)
    for c in chars {
        var nextPoint = currentPoint
        
        switch c {
        case "U":
            let y = currentPoint.y + 1
            nextPoint = CGPoint(x: currentPoint.x, y: y)
        case "D":
            let y = currentPoint.y - 1
            nextPoint = CGPoint(x: currentPoint.x, y: y)
        case "R":
            let x = currentPoint.x + 1
            nextPoint = CGPoint(x: x, y: currentPoint.y)
        case "L":
            let x = currentPoint.x - 1
            nextPoint = CGPoint(x: x, y: currentPoint.y)
        default:
            break
        }
        
        let newPath = Path(start: currentPoint, end: nextPoint)
        
        // 중복 패스 검사
        // 현재 패스와, 배열에 들어있는 패스를 비교해서 중복되는 패스가 배열에 없다면 새로운길+1
        var isExsistPath = false
        for p in paths {
            if (newPath.start == p.start && newPath.end == p.end)
                || (newPath.start == p.end && newPath.end == p.start) {
                isExsistPath = true
                break
            }
        }
        
        // 범위를 벗어난 패스 검사
        let isOver = (isOverArea(newPath.start) || isOverArea(newPath.end))
        
        // 중복이 없는 패스이면서, 범위를 벗어나지 않았을때만 카운트
        if (!isExsistPath && !isOver) {
            result += 1
        }
        
        // 패스의 좌표가 움직일수 있는 범위를 벗어난 경우, 패스배열에 넣지 않는다
        if !isOver {
            paths.append(newPath)
            currentPoint = nextPoint
        }
    }
    
    return result
}

// point 가 범위를 벗어나는지를 검사
func isOverArea(_ point: CGPoint) -> Bool {
    if(point.x > 5 || point.x < -5 || point.y > 5 || point.y < -5) { return true }
    return false
}

//solution("ULURRDLLU")
solution("LULLLLLLU")

//: [Next](@next)
