//: [Previous](@previous)

import Foundation

/**
 다리 위 트럭
 */

struct Truck {
    let idx: Int
    var 다리위에올라온시간: Int = 0
}

struct Queue {
    private var queue: [Int] = []
    
    public mutating func enqueue(_ element: Int) {
        queue.append(element)
    }
    
    public mutating func dequeue() -> Int? {
        return isEmpty ? nil : queue.removeFirst()
    }
    
    public func first() -> Int? {
        return queue.first
    }
    
    // 전체 큐 데이터의 합
    public var totalSum: Int {
        return queue.reduce(0, +)
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



func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    // 움직여야 할 트럭들
    var trucksQueue = Queue()
    for t in truck_weights {
        trucksQueue.enqueue(t)
    }
    
    let trucksCount = trucksQueue.count
    
    // 다리위 트럭들 - bridge_length 갯수만큼 가질 수 있다
    var trucksOnBridgeQueue = Queue()
    
    var time = 0
    
//    var goalTrucks = Queue()
    
    
    // 옮길 트럭이 존재하고, 다리 위 트럭이 아무 것도 없는 경우
    while(!trucksQueue.isEmpty || trucksOnBridgeQueue.isEmpty == false) {
//    while(goalTrucks.count < trucksCount ) {
        print("time ==== ", time)
        // 1. 다리위에 트럭을 놓을 수 있나. 시간 1 소요
        if let currentTruck = trucksQueue.first(),
           currentTruck <= (weight - trucksOnBridgeQueue.totalSum),
           trucksOnBridgeQueue.count < bridge_length {
            
            if let truck = trucksQueue.dequeue() {
                   // 다리에 트럭을 올릴 수 있는 상태. 트럭을 하나 빼서 다리위에 올린다
                   trucksOnBridgeQueue.enqueue(truck)
                   print("다리위에 올라간 트럭 ", truck)
                   time += 1
                   continue
               }
        } else {

            // Error::-
            // 2. 다리위 트럭이 있나 -> 트럭 옮기기(다리 길이만큼 시간이 소요된다)
            // 트럭이 하나라도 다리 위에 있고, 다리 위에 더이상 트럭을 올릴수 없을때 옮긴다
            // 트럭이 다리위에 시간텀을 두고 올라왔을떄 어떻게 처리할 것인지 - 트럭이 몇초에 다리위로 올라왔는지 기록해둔다..?
            if !trucksOnBridgeQueue.isEmpty {
                print("완료된 트럭 수" , trucksOnBridgeQueue.count)
                for _ in 0..<trucksOnBridgeQueue.count {
                    trucksOnBridgeQueue.dequeue()
                }
                time += bridge_length
            }
        }


        

    }
    
    return time
}


solution(bridge_length, weight, truck_weights)

//: [Next](@next)
