//: [Previous](@previous)

import Foundation

//: # 복습
func binarySearch(_ arr: [Int], find: Int) -> Int {
    var low = 0
    var high = arr.count - 1
    
    while(low <= high) {
        let mid = (low + high) / 2
        if arr[mid] == find { return mid }
        if arr[mid] > find {
            high = mid - 1
            continue
        }
        low = mid + 1
    }
    return 0
}

binarySearch([1,3,5,7,9], find: 9)


struct Stack<T> {
    var elements = [T]()
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    mutating func push(_ element: T) {
        self.elements.append(element)
    }
    
    func peek() -> T? {
        return elements.last
    }
}

struct StackIterator<T>: IteratorProtocol {
    var currentElements: [T]
    mutating func next() -> T? {
        if !self.currentElements.isEmpty {
            return currentElements.popLast()
        }
        return nil
    }
}

extension Stack: Sequence {
    func makeIterator() -> StackIterator<T> {
        return StackIterator<T>(currentElements: self.elements)
    }
}


struct Queue<T> {
    private var elements = [T]()
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        self.elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        self.elements.removeFirst()
    }
    
    func front() -> T? {
        return self.elements.first
    }
}


struct QueueIteratorProtocol<T>: IteratorProtocol {
    var currentElements: [T]
    mutating func next() -> T? {
        if !currentElements.isEmpty {
            return currentElements.removeFirst()
        }
        return nil
    }
}

extension Queue: Sequence {
    func makeIterator() -> QueueIteratorProtocol<T> {
        return QueueIteratorProtocol<T>(currentElements: self.elements)
    }
}


//: # 학습
/*:
 ### 삽입 정렬
 - 현재 인덱스의 값과, [0]~[현재 인덱스-1] 의 값들을 비교해 올바른 위치에 삽입한다
 - 최선의 경우: 이미 정렬이 되어 있는 경우 while 문을 돌 필요가 없으므로  O(N)
 - 최악의 경우: 내림차순으로 정렬되었다면 while 문에서 모든 요소를 이동시켜야 하므로 O(N^2)
 - NOTE: 이해 필요
 */
func insertionSort(_ arr: [Int]) -> [Int] {
    var array = arr
    for i in 0..<array.count {
        let currentValue = array[i] // 현재 인덱스의 값
        print("[\(i)]현재 요소:", currentValue)
        var j = i - 1 // 현재인덱스 이전의 인덱스
        while (j >= 0 && array[j] > currentValue) {
            array[j+1] = array[j]
            j -= 1
        }
        array[j+1] = currentValue
        print(array)
    }
    return array
}

//insertionSort([5,2,4,6,1,3])


/*:
 ### 버블 정렬
 - 거품이 수면 위로 올라가는 것처럼 배열의 요소가 움직임
 - 배열 끝에서 부터 정렬되지 않은 요소들을 비교하여 자리를 교환한다.
 - 최선, 최악 모두 O(N^2) 의 시간 복잡도를 가진다.
 */
func bubbleSort(_ arr: [Int]) -> [Int] {
    var array = arr
    for i in stride(from: arr.count-1, through: 1, by: -1) {
        for j in 0..<i {
//            print("i = \(i), j = \(j)")
            if (array[j] > array[j+1]) {
                array.swapAt(j, j+1)
            }
        }
    }
    return array
}

let a = bubbleSort([7,4,5,1,3])



// 5 ~ 0
//for i in stride(from: 5, through: 0, by: -1) {
//    print(i)
//}

// 5 ~ 1
//for i in stride(from: 5, to: 0, by: -1) {
//    print(i)
//}


//: [Next](@next)
