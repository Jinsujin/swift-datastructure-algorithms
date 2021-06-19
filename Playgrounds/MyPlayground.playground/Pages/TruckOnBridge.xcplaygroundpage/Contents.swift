//: [Previous](@previous)

import Foundation

/**
 다리 위 트럭
 */

struct Truck {
    let weight: Int
    var startTime: Int = 0
}

struct Queue {
    public var queue: [Truck] = []
    
    public mutating func enqueue(_ element: Truck) {
        queue.append(element)
    }
    
    public mutating func dequeue() -> Truck? {
        return isEmpty ? nil : queue.removeFirst()
    }
    
    public func first() -> Truck? {
        return queue.first
    }
    
    // 전체 큐 데이터의 합
    public var totalSum: Int {
        return queue.map({$0.weight}).reduce(0, +)
    }
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
}

// return 8
let bridge_length = 2
let weight = 10
let truck_weights = [7,4,5,6]


//return 101
//let bridge_length = 100
//let weight = 100
//let truck_weights = [10]


//return 110
//let bridge_length = 100
//let weight = 100
//let truck_weights = [10,10,10,10,10,10,10,10,10,10]



solution(bridge_length, weight, truck_weights)



func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    
    var time = 0
    // 움직여야 할 트럭들
    var trucksQueue = Queue()
    for t in truck_weights {
        trucksQueue.enqueue(Truck(weight: t, startTime: time))
    }
    
    // 다리위 트럭들 - bridge_length 갯수만큼 가질 수 있다
    var trucksOnBridgeQueue = Queue()
    
    // 큐에 값이 하나라도 있으면 루프를 계속 돈다
    while(!trucksQueue.isEmpty || !trucksOnBridgeQueue.isEmpty) {
        print("time ==== ", time)
        
        // 1. 다리위에 올라간 트럭이 있으면 체크
        if !trucksOnBridgeQueue.isEmpty {
            var goalCount = 0
            for t in trucksOnBridgeQueue.queue {
                if time >= (t.startTime + bridge_length) {
                    goalCount+=1
                }
            }
            
            for _ in 0..<goalCount {
                trucksOnBridgeQueue.dequeue()
            }
        }
        
        // 2. 다리위에 트럭을 놓을 수 있나
        if let currentTruck = trucksQueue.first(),
           currentTruck.weight <= (weight - trucksOnBridgeQueue.totalSum),
           trucksOnBridgeQueue.count < bridge_length {
            
            if let truck = trucksQueue.dequeue() {
                   // 다리에 트럭을 올릴 수 있는 상태. 트럭을 하나 빼서 다리위에 올린다
                let t = Truck(weight: truck.weight, startTime: time)
                   trucksOnBridgeQueue.enqueue(t)
                   print("다리위에 올라간 트럭 ", truck)
               }
        }

        time += 1
    } // End while
    
    return time
}




//: [Next](@next)
