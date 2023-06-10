//: [Previous](@previous)

import Foundation

// 캐시: Least Recently Used
func solution(_ size: Int, _ arr: [Int]) -> [Int] {
    var cache = Array(repeating: 0, count: size)
    for elem in arr {
        // 1. 캐시에 해당 값이 있는지 찾는다
        if let hit = cache.firstIndex(of: elem) {
            // 2-1. 이미 캐시에 해당 값이 있는 경우
            var idx = hit - 1
            while(idx >= 0) {
                cache[idx+1] = cache[idx]
                idx -= 1
            }
            cache[0] = elem
            continue
        }
        // 2-2. miss 가 난 경우:
        // 값을 한칸씩 뒤로 밀고, 가장 앞에 miss 난 값을 넣는다
        let loopEnd = cache.count - 2
        for i in stride(from: loopEnd, through: 0, by: -1) {
            cache[i+1] = cache[i]
        }
        cache[0] = elem
    }
    return cache
}
// 7 5 3 2 6
let arr = [1, 2, 3, 2, 6, 2, 3, 5, 7]
solution(5, arr)


func solution1_2(_ size: Int, _ arr: [Int]) -> [Int] {
    var cache = Array(repeating: 0, count: size)
    for elem in arr {
        var idx = -1
        // 캐시 hit 인지 탐색
        for i in 0..<size {
            if elem == cache[i] { idx = i }
        }

        // miss 인 경우
        if idx == -1 {
            for i in stride(from: size-1, through: 1, by: -1) {
                cache[i] = cache[i-1]
            }
            cache[0] = elem
            continue
        }
        for i in stride(from: idx, through: 1, by: -1) {
            cache[i] = cache[i-1]
        }
        cache[0] = elem
    }
    return cache
}

// 7 5 3 2 6
solution1_2(5, arr)


//: [Next](@next)
