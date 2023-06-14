//: [Previous](@previous)

import Foundation

// (Queue) 응급실
func solution(n: Int, m: Int, _ input: [Int]) -> Int {
    var answer = 0
    var queue = [(id: Int, val: Int)]()
    for i in 0..<input.count {
        queue.append((id: i, val: input[i]))
    }
    
    while(!queue.isEmpty) {
        let cur = queue.removeFirst()
        // 꺼낸 요소의 위험도보다 큰 요소가 큐에 있는지 검사
        if queue.filter({ $0.val > cur.val }).isEmpty == false {
            queue.append(cur)
            continue
        }
        // 위험도가 더 큰 환자가 없다면 치료
        answer += 1
        if cur.id == m { return answer }
    }
    
    return answer
}

// 3
solution(n: 5, m: 2, [60, 50, 70, 80, 90])

// 4
solution(n: 6, m: 3, [70, 60, 90, 60, 60, 60])


// 스택2개로 큐 만들기
final class Queue {
    private var newStack = [Int]()
    private var oldStack = [Int]()
    
    var size: Int {
        newStack.count + oldStack.count
    }
    
    func enqueue(_ val: Int) {
        newStack.append(val)
    }
    
    func dequeue() -> Int? {
        shiftStacks()
        if oldStack.isEmpty { return nil }
        return oldStack.removeLast()
    }
    // 큐에서 첫번째 요소를 반환
    func peek() -> Int? {
        shiftStacks()
        if oldStack.isEmpty { return nil }
        return oldStack.last
    }
    
    private func shiftStacks() {
        if oldStack.isEmpty {
            while(!newStack.isEmpty) {
                let val = newStack.removeLast()
                oldStack.append(val)
            }
        }
    }
}

let q = Queue()
q.size
q.enqueue(1)
q.enqueue(2)
q.enqueue(3)
q.dequeue() // 1
q.dequeue() // 2
q.peek() // 3


// 스택2개로 작은값이 위로 오도록 정렬하기
final class Stack {
    private var s = [Int]()
    
    var isEmpty: Bool { s.isEmpty }
    
    init(values: [Int]) {
        s = values
    }
    
    func push(_ val: Int) {
        s.append(val)
    }
    
    func pop() -> Int {
        s.removeLast()
    }
    
    func peek() -> Int? {
        s.last
    }
    
    func printElems() {
        for i in stride(from: s.count-1, through: 0, by: -1) {
            print(s[i])
        }
    }
}

func sort(stack: Stack) {
    var newStack = Stack(values: [])
    // 입력받은 스택이 빌때까지 반복하며, newStack 에 큰값이 위로 오도록 옮긴다
    while(!stack.isEmpty) {
        let temp = stack.pop()
        while(!newStack.isEmpty && newStack.peek()! > temp) {
            stack.push(newStack.pop())
        }
        newStack.push(temp)
    }
    
    while(!newStack.isEmpty) {
        stack.push(newStack.pop())
    }
}

var stack = Stack(values: [3,5,1,2,9,4,2])
sort(stack: stack)
stack.printElems()
//1
//2
//2
//3
//4
//5
//9


//: [Next](@next)
