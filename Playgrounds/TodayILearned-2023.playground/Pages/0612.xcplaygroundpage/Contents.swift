//: [Previous](@previous)

import Foundation

func solution(num: Int, _ arr: [Int]) -> Int {
    var answer = 0
    var lt = arr.max()! // 9
    var rt = arr.reduce(0, +) // 45
    
    while(lt <= rt) {
        let mid = (lt + rt) / 2
        if num == dvdCount(mid) {
            // 최소값을 찾기위해 범위를 줄인다
            rt = mid - 1
            answer = mid
        } else if num > dvdCount(mid) {
            rt = mid - 1
        } else {
            // 큰 범위에 찾는 값이 있으므로, lt 를 옮긴다
            lt = mid + 1
        }
    }
    
    // 이분탐색의 값이 정답이 될 수 있는지 판별
    func dvdCount(_ capacity: Int) -> Int {
        var cnt = 1
        var sum = 0

        for elem in arr {
            if (sum+elem) > capacity {
                // 새로운 DVD 에 쓰기 시작
                cnt += 1
                sum = elem
                continue
            }
            sum += elem
        }
        return cnt
    }
    
    return answer
}

// 17
solution(num: 3, [1, 2, 3, 4, 5, 6, 7, 8, 9])

func solution2(_ horseNum: Int, _ distances: [Int]) -> Int {
    var answer = 0
    var arr = distances.sorted(by: <)
    var lt = arr[1] - arr[0]
    var rt = arr.max()! - arr.min()!
    
    while(lt <= rt) {
        let mid = (lt + rt) / 2
        let calcNum = calc(mid)
        
        // 2마리만 배치 가능하다면=> rt 범위를 줄인다
        // 3마리 모두 배치 가능하다면=> 최적값을 찾기위해 answer 에 저장하고 lt 범위를 줄인다
//        if horseNum == calcNum {
//            answer = mid
//            lt = mid + 1
//        } else if horseNum > calcNum {
//            rt = mid - 1
//        } else {
//            lt = mid + 1
//        }
        if calcNum >= horseNum {
            answer = mid
            lt = mid + 1
        } else {
            rt = mid - 1
        }
    }
    
    // 배치 가능한 말 마리수 반환
    func calc(_ dist: Int) -> Int {
        var cnt = 1
        var pos = arr.min()!
        for elem in arr {
            if elem - pos >= dist {
                cnt += 1
                pos = elem
            }
        }
        return cnt
    }
    
    return answer
}

//solution2(3, [1, 2, 8, 4, 9])

// 그리디: 씨름선수
func solution3(_ input: [[Int]]) -> Int {
    var answer = 0
    let loopCnt = input.count
    
    for i in 0..<loopCnt {
        var isPosible = true
        for j in 0..<loopCnt {
            if i == j { continue }
            // 아무도 i 보다 큰값이 없다면=> 선수로 뽑힌다=> answer += 1
            if canPick(input[i], input[j]) == false {
                isPosible = false
                break
            }
        }
        if isPosible {
            answer += 1
        }
    }
    
    func canPick(_ a: [Int], _ compareB: [Int]) -> Bool {
        if a[0] < compareB[0] && a[1] < compareB[1] { return false }
        return true
    }
    
    return answer
}

// 3
solution3([[172, 67],
           [183, 65],
           [180, 70],
           [170, 72],
           [181, 60]])

func solution3_2(_ input: [[Int]]) -> Int {
    let sortedArr = input.sorted(by: sort)
    var answer = 0
    var maxW = 0
    
    for i in 0..<sortedArr.count {
        let w = sortedArr[i][1]
        if w > maxW {
            answer += 1
            maxW = w
        }
    }
    
    func sort(a: [Int], b: [Int]) -> Bool {
        if a[0] == b[0] {
            return a[1] > b[1]
        } else {
            return a[0] > b[0]
        }
    }
    return answer
}
//3
solution3_2([[172, 67],
           [183, 65],
           [180, 70],
           [170, 72],
           [181, 60]])


// 회의실 배정
func solution4(_ input: [[Int]]) -> Int {
    // 1. 끝난시간을 기준으로 오름차순 정렬
//    let sortedArr = input.sorted(by: { $0[1] < $1[1] }) // ❌
    let sortedArr = input.sorted(by: sort)
    var startTime = 0
    var cnt = 0
    // 2. for 문을 돌면서 큰값이 있다면 수업이 가능한것=> cnt+1
    for i in 0..<sortedArr.count {
        if sortedArr[i][0] >= startTime {
            cnt += 1
            startTime = sortedArr[i][1]
        }
    }
    
    func sort(a: [Int], b: [Int]) -> Bool {
        if a[1] == b[1] { // ‼️ 종료시간을 기준으로 먼저 정렬한다
            return a[0] < b[0]
        } else {
            return a[1] < b[1]
        }
    }
    return cnt
}

//3
solution4([[1,4],
           [2,3],
           [3,5],
           [4,6],
           [5,7]])
//2
solution4([[3,3],
          [1,3],
          [2,3]])

// 결혼식: 테스트 통과 못함❌
func solution5(_ input: [[Int]]) -> Int {
    let sortedArr = input.sorted(by: sort)
    
    var answer = 0
    var cnt = 1
    var endTime = sortedArr[0][1] // 14
    
    for i in 0..<sortedArr.count {
        if sortedArr[i][0] < endTime {
            cnt += 1
            continue
        }
        endTime = sortedArr[i][0]
        answer = max(answer, cnt)
        cnt = 1
    }
    
    func sort(a: [Int], b: [Int]) -> Bool {
        if a[0] == b[0] {
            return a[1] < b[1]
        } else {
            return a[0] < b[0]
        }
    }
    return answer
}

// 정답: 2/ 반환: 3
solution5([[14, 18],
[12, 15],
[15, 20],
[20, 30],
[5, 14]])

// 결혼식
struct S5 {
    let time: Int
    let state: Character
}

func solution5_2(_ input: [[Int]]) -> Int {
    var arr = [S5]()
    for elem in input {
        arr.append(S5(time: elem[0], state: "s"))
        arr.append(S5(time: elem[1], state: "e"))
    }
    let sortedArr = arr.sorted(by: sort)
    print(sortedArr)
    
    var cnt = 0
    var answer = 0
    
    for i in 0..<sortedArr.count {
        if sortedArr[i].state == "e" {
            cnt -= 1
        } else {
            // 온시간일때
            cnt += 1
        }
        answer = max(answer, cnt)
    }
    
    func sort(a: S5, b: S5) -> Bool {
        if a.time == b.time {
            return a.state < b.state
        } else {
            return a.time < b.time
        }
    }
    return answer
}

// 2
solution5_2([[14, 18],
[12, 15],
[15, 20],
[20, 30],
[5, 14]])




//: [Next](@next)
