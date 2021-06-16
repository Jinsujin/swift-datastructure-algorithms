//: [Previous](@previous)

import Foundation

/*
 기능 개발
 
 프로그래머스 팀에서는 기능 개선 작업을 수행 중입니다. 각 기능은 진도가 100%일 때 서비스에 반영할 수 있습니다.
 또, 각 기능의 개발속도는 모두 다르기 때문에 뒤에 있는 기능이 앞에 있는 기능보다 먼저 개발될 수 있고, 이때 뒤에 있는 기능은 앞에 있는 기능이 배포될 때 함께 배포됩니다.
 먼저 배포되어야 하는 순서대로 작업의 진도가 적힌 정수 배열 progresses와 각 작업의 개발 속도가 적힌 정수 배열 speeds가 주어질 때 각 배포마다 몇 개의 기능이 배포되는지를 return 하도록 solution 함수를 완성하세요.
 제한 사항
 작업의 개수(progresses, speeds배열의 길이)는 100개 이하입니다.
 작업 진도는 100 미만의 자연수입니다.
 작업 속도는 100 이하의 자연수입니다.
 배포는 하루에 한 번만 할 수 있으며, 하루의 끝에 이루어진다고 가정합니다. 예를 들어 진도율이 95%인 작업의 개발 속도가 하루에 4%라면 배포는 2일 뒤에 이루어집니다.
  
 **/



print(100%30)

70/30 //2
70%30 //10
// => 나머지가 0 보다 큰경우 몫+1

45/5 //9
45%5 //0



struct DevFunc {
    // 남은 날짜수
    public var remainDay: Int
    
    init(_ progress:Int, _ speed: Int) {
        let remainPercent = 100 - progress
        let d = remainPercent / speed
        let f = remainPercent % speed
        remainDay = (f > 0) ? d + 1 : d
    }
}

let df1 = DevFunc(30, 30)
print(df1)


let df2 = DevFunc(55,5)
print(df2)



/// Queue
struct Queue<T> {
    public var queue: [T] = []
    
    /// 배열의 끝에 데이터 추가
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    /// 배열의 첫부분의 데이터를 꺼내오고, 꺼내온 데이터를 배열에서 삭제
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : queue.removeFirst()
    }
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
}

// 큐 사용해 보기
//var q = Queue<Int>()
//q.enqueue(5)
//q.enqueue(6)
//q.enqueue(7)
//q.dequeue()




// return [2,1]
let progresses = [93, 30, 55]
let speeds = [1, 30, 5]



func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var result: [Int] = []
    
    var queue = Queue<DevFunc>()
    for i in 0..<progresses.count {
        queue.enqueue(DevFunc(progresses[i], speeds[i]))
    }
    
    var day: Int = 1
    
     //큐에 데이터가 없을때까지 반복
    while(!queue.isEmpty) {
//        print("day", day)
        var count: Int = 0
        for data in queue.queue {
            if( data.remainDay <= day) {
                count += 1
                print(count)
                continue
            } else {
                break
            }
        }
        
        if (count > 0) {
            result.append(count)
            for _ in 0..<count {
                queue.dequeue()
            }
        }
        
        day += 1
    }
    
    return result
}

print(solution(progresses, speeds))

//: [Next](@next)
