//: [Previous](@previous)

import Foundation


// 두 배열 합치기
func solution(_ leftArr: [Int], rightArr: [Int]) -> [Int] {
    var result = [Int]()
    var leftArr = leftArr
    var rightArr = rightArr
    var li = 0
    var ri = 0
    // And 조건
    while(li < leftArr.count && ri < rightArr.count) {
        let left = leftArr[li]
        let right = rightArr[ri]
        
        if left < right {
            result.append(left)
            li += 1
        } else if left > right {
            result.append(right)
            ri += 1
        } else {
            result.append(left)
            li += 1
            result.append(right)
            ri += 1
        }
    }
    
    while(li < leftArr.count) {
        result.append(leftArr[li])
        li += 1
    }
    while(ri < rightArr.count) {
        result.append(rightArr[ri])
        ri += 1
    }
    
    return result
}

// [1, 2, 3, 3, 5, 6, 7, 9]
solution([1, 3, 5], rightArr: [2,3, 6, 7, 9])


func solution2(_ leftArr: [Int], rightArr: [Int]) -> [Int] {
    var result = [Int]()
    var leftArr = leftArr.sorted(by: <) // [1,2,3,5,9]
    var rightArr = rightArr.sorted(by: <)
    var li = 0
    var ri = 0
    
    while(li < leftArr.count && ri < rightArr.count) {
        let left = leftArr[li]
        let right = rightArr[ri]
        if left == right {
            result.append(left)
            li += 1
            ri += 1
        } else if left < right {
            li += 1
        } else {
            ri += 1
        }
    }
    return result
}
// [2, 3, 5]
solution2([1, 3, 9, 5, 2], rightArr: [3, 2, 5, 7, 8])

// 연속된 K 일의 최대 매출액
func solution3(_ input: [Int], K: Int) -> Int {
    var answer = 0
    let loopEnd = input.count - K // 10 - 3 = 7
    
    for i in 0...loopEnd {
        var sum = 0
        for j in i..<(i+K) {
            sum += input[j]
        }
        answer = max(sum, answer)
    }
    return answer
}
// 56
solution3([12, 15, 11 ,20, 25, 10, 20, 19, 13, 15], K: 3)


func solution3_1(_ input: [Int], K: Int) -> Int {
    var answer = Array(input[0..<K]).reduce(0, +)
    var sum = answer
    
    for i in K..<input.count {
        sum += input[i] - input[i-K]
        answer = max(answer, sum)
    }
    return answer
}
// 56
solution3_1([12, 15, 11 ,20, 25, 10, 20, 19, 13, 15], K: 3)

// 수열에서 연속부분수열의 합이 특정숫자 M이 되는 경우가 몇 번 있는지 구하는 프로그램을 작성하세요. O(N)
func solution4(target: Int, _ arr: [Int]) -> Int {
    var answer = 0
    var li = 0
    var ri = 1
    var total = arr[li]
    
    while(li < arr.count && ri < arr.count) {
        if total == target {
            answer += 1
            total -= arr[li]
            li += 1
        } else if total < target {
            total += arr[ri]
            ri += 1
        } else {
            total -= arr[li]
            li += 1
        }
    }
    
    return answer
}

// 3
solution4(target: 6, [1, 2, 1, 3, 1, 1, 1, 2])

func solution4_1(target: Int, _ arr: [Int]) -> Int {
    var answer = 0
    var lt = 0
    var sum = 0
    
    for rt in 0..<arr.count {
        sum += arr[rt]
        if sum == target {
            answer += 1
        }
        while(sum >= target) {
            sum -= arr[lt]
            lt += 1
            // lt 를 옮긴 시점에 값 비교가 필요!
            if sum == target { answer += 1 }
        }
    }
    return answer
}
// 3
solution4_1(target: 6, [1, 2, 1, 3, 1, 1, 1, 2])


func solution5(N: Int) -> Int {
    let m = N / 2 + 1
    let arr: [Int] = Array(1...m)
    var count = 0
    var lt = 0
    var sum = 0
    
    for rt in 0..<arr.count {
        sum += arr[rt]
        if sum == N {
            count += 1
            print(lt, rt, sum)
        }
        while(sum >= N) {
            sum -= arr[lt]
            lt += 1
            if sum == N {
                count += 1
                print(lt, rt, sum)
            }
        }
    }
    return count
}
// 3 가지
//solution5(N: 15)
//0~4
//3~5
//6~7

// 피자배달거리
struct MapPoint {
    let x: Int
    let y: Int
}

func solution6(_ map: [[Int]], selectNum: Int) -> Int {
    var answer = 0//모든 거리의 합
    var selectPizzaHut = Array(repeating: MapPoint(x: 0, y: 0), count: selectNum)
    var pizzaHut = [MapPoint]()
    let M = map.count
    
    // 피자집 초기화
    for i in 0..<M {
        for j in 0..<M {
            if map[i][j] == 2 {
                pizzaHut.append(MapPoint(x: i, y: j))
            }
        }
    }

    //
    for i in 0..<M {
        for j in 0..<M {
            if map[i][j] == 1 {
                let minDist = combiDfs(0, s: 0, house: MapPoint(x: i, y: j))
                answer += minDist
                print(minDist)
            }
        }
    }

    // 현재좌표에서 피자집4개까지 가는 거리중 가장 짧은 거리
    func calcMinDistance(start: MapPoint, pizzaHuts: [MapPoint]) -> Int {
        var minDistance = 999
        for hut in pizzaHuts {
            let result = abs(start.x - hut.x) + abs(start.y - hut.y)
            minDistance = min(result, minDistance)
        }
        return minDistance
    }
    
    
    // 피자집 6개중에 4개를 선택해서, 집에서 가장 빨리 도착할 수 있는 피자집으로의 최소 거리를 누적
    func combiDfs(_ depth: Int, s: Int, house: MapPoint) -> Int {
        if depth == selectNum {
            var temp = ""
            for num in selectPizzaHut {
                temp += "\(num)"
            }
            // 4개의 피자집을 골랐다. -> 선택한 집에서 갈 수 있는 피자집들 중에서 가장 작은 최소거리는?
            let curDis = calcMinDistance(start: house, pizzaHuts: selectPizzaHut)
            return curDis
        }
        // 중복을 허용하지 않는 수열
        var result = 99
        for i in s..<pizzaHut.count {
            selectPizzaHut[depth] = pizzaHut[i]
            result = min(combiDfs(depth + 1, s: i + 1, house: house), result)
        }
        return result
    }
    return answer
}

let map = [
[0,1,2,0],
[1,0,2,1],
[0,2,1,2],
[2,0,1,2]]

// 6
//solution6(map, selectNum: 4)


func solution6_1(_ map: [[Int]], selectCount: Int) -> Int {
    let M = map.count
    var selects = Array(repeating: -1, count: selectCount)
    var pizzahuts = [MapPoint]()
    var houses = [MapPoint]()
    var answer = 999 //모든 거리의 합
    
    // 피자집 초기화
    for i in 0..<M {
        for j in 0..<M {
            if map[i][j] == 1 {
                houses.append(MapPoint(x: i, y: j))
            }
            if map[i][j] == 2 {
                pizzahuts.append(MapPoint(x: i, y: j))
            }
        }
    }
    dfs(0, startIdx: 0)
    
    // 6개중4개 선택
    func dfs(_ depth: Int, startIdx: Int) {
        if depth == selectCount {
            // 집 하나에서 이동할 수 있는 피자집들(조합) 의 최단거리 계산
            var distSum = 0
            for h in houses {
                var minDist = 999
                for i in 0..<selects.count {
                    let p = pizzahuts[selects[i]]
                    minDist = min(minDist, abs(h.x - p.x) + abs(h.y - p.y))
                }
                distSum += minDist
            }
            answer = min(distSum, answer)
            return
        }
        
        for i in startIdx..<pizzahuts.count {
            selects[depth] = i
            dfs(depth + 1, startIdx: i + 1)
        }
    }
    return answer
}

// 6
solution6_1(map, selectCount: 4)



//: [Next](@next)
