//: [Previous](@previous)

import Foundation

/*
 기능 개발
  
 **/



print(100%30)

70/30 //2
70%30 //10
// => 나머지가 0 보다 큰경우 몫+1

45/5 //9
45%5 //0



struct DevFunc {
    // 남은 날짜수. 하루단위로 for loop 돌리면서 remainDay를 -=1. 0이 될때 배열에 추가하면 된다
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
        print("day", day)
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
