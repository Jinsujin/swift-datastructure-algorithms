//: [Previous](@previous)

import Foundation


func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var answer = [Int]()
    var left = 0
    var right = nums.count - 1
    var arr = [(idx: Int, num: Int)]()
    for i in 0..<nums.count {
        arr.append((idx: i, num: nums[i]))
    }
    let sortedArr = arr.sorted(by: { $0.num < $1.num })
    
    while(left < right) {
        let sum = sortedArr[left].num + sortedArr[right].num
        if sum == target {
            answer = [sortedArr[left].idx, sortedArr[right].idx]
            break
        } else if sum > target {
            right -= 1
        } else {
            left += 1
        }
    }
    return answer
}


//Output: [0,1]
twoSum([2,7,11,15], 9)

// [1,2]
twoSum([3,2,4], 6)


func reverse(_ x: Int) -> Int {
    var answer = 0
    var isMinus = false
    if x < 0 { isMinus = true }
    // 입력값이 음수일때는 while 문이 돌지 않으므로 절대값으로 변환
    var value = abs(x)
    
    while(value > 0) {
        answer = (answer * 10) + (value % 10)
        value /= 10
    }
    return isMinus ? answer * -1 : answer
}

// 🎖️솔루션 코드
func reverse2(_ x: Int) -> Int {
    var (r, x) = (0, x)
    // 음수(-) 도 입력값에 포함되므로, 0이 아닐때 반복한다
    while x != 0 {
        // (0 * 10) + (-3)
        // (-3 * 10) + (-2)
        // (-32 & 10) + (-1)
        r = (r * 10) + (x % 10)
        x /= 10
    }
    // -231 <= x <= 231 - 1 조건에 맞추기 위함
    return r < Int32.min || r > Int32.max ? 0 : r
}

reverse2(-123)

//Output: -321
reverse(-123)

//Output: 21
reverse(120)

//: [Next](@next)
