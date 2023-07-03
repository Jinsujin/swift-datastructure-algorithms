//: [Previous](@previous)

import Foundation


// 과일 가져가기
func solution(_ input: [[Int]]) -> Int {
    var answer = Array(repeating: -1, count: input.count)
    let basketCount = input[0].count
    
    for i in 0..<input.count {
        if answer[i] != -1 { continue }
        for j in i+1..<input.count {
            if answer[j] != -1 { continue }
            var iArr = input[i]
            var jArr = input[j]
            // 학생이 선택한 바구니의 최소값과 index
            let iSelect = minItem(iArr)
            let jSelect = minItem(jArr)
            if iSelect.idx == jSelect.idx { continue }
            
            // 교환 후에 둘 모두 최소값이 올랐는지 확인
            // => 모두 올랐을때 교환이 됨
            iArr[iSelect.idx] += 1
            jArr[iSelect.idx] -= 1
            
            jArr[jSelect.idx] += 1
            iArr[jSelect.idx] -= 1
            
            if iArr.min()! <= iSelect.val || jArr.min()! <= jSelect.val {
                continue
            }
            
            // 교환했으면 더이상 교환하지 않으므로 건너뜀 => j 반복문을 멈춘다
            answer[i] = iArr.min()!
            answer[j] = jArr.min()!
            break
        }
    }
    
    func minItem(_ arr: [Int]) -> (val: Int, idx: Int) {
        var minIdx = 0
        for i in 1..<arr.count {
            if arr[minIdx] > arr[i] {
                minIdx = i
            }
        }
        return (val: arr[minIdx], idx: minIdx)
    }
    print(answer)
    var result = 0
    // 교환되지 않은 학생의 바구니 갱신
    for i in 0..<answer.count {
        if answer[i] != -1 {
            result += answer[i]
            continue
        }
        result += input[i].min() ?? 0
    }
    return result
}

// answer: 58
solution([[10, 20, 30], [12, 15, 20], [20, 12, 15], [15, 20, 10], [10, 15, 10]])

// answer: 24
solution([[10, 9, 11], [15, 20, 25]])
// [[9, 10, 11], [16, 19, 25]] => A 는 9로 같으므로 교환안함

// answer: 32
solution([[0, 3, 27], [20, 5, 5], [19, 5, 6], [10, 10, 10], [15, 10, 5], [3, 7, 20]])

// answer: 48
solution([[3, 7, 20], [10, 15, 5], [19, 5, 6], [10, 10, 10], [15, 10, 5], [3, 7, 20], [12, 12, 6], [10, 20, 0], [5, 10, 15]])

//: [Next](@next)
