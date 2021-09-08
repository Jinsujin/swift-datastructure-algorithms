//: [Previous](@previous)

import Foundation


/**
 Stack
 LIFO (Last In First Out) : 나중에 들어간 것이 먼저 나온다
 
 - mutating: 구조체는 벨류타입이므로, 구조체에 포함된 데이터를 수정 (=인스턴스를 수정)하기 위해서 붙여줘야 하는 키워드
 */

public struct Stack<T> {
    private var elements = [T]()

    public init() {}

    // 삭제후 반환
    public mutating func pop() -> T? {
        return self.elements.popLast()
    }

    public mutating func push(_ element: T) {
        self.elements.append(element)
    }

    // 삭제하지 않고 반환
    public func peek() -> T? {
        return self.elements.last
    }

    public var isEmpty: Bool {
        return self.elements.isEmpty
    }

    public var count: Int {
        return self.elements.count
    }
}
//
//var stack = Stack<Int>()
//stack.push(1) // Stack<Int> => [1]
//stack.push(2)
//stack.push(3)
//
//var value = stack.pop()
//value = stack.pop()
//value = stack.pop()
//value = stack.pop()



// MARK:- Protocol Stack


// 타입값을 출력할때 이해하기 쉬운 이름을 반환하기 위한 프로토콜
// ex) Point(x: 0, y: 0) => description에서 반환한 형태로. (0, 0)
extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }

    public var debugDescription: String {
        return self.elements.debugDescription
    }
}


// 스택을 초기화할떄 배열처럼 동작하도록. []를 사용해서 배열형식으로 추가 가능.
// ex) var stack = [1,2,3]
extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
//        self.init(elems)
        self.init()
        elements.forEach{ push($0) }
    }
}


// IteratorProtocol: 요소를 추가하거나 반복할떄 사용. 다음 원소를 리턴해주는 next()를 구현해야 함
// 스택에 포함된 요소의 타입에 따라 값을 반환하는 반복기를 반환.
public struct ArrayIterator<T>: IteratorProtocol {
    var currentElements: [T]
    
    init(elements: [T]) {
        self.currentElements = elements
    }
    
    /// 시퀸스의 다음 요소를 반환
    mutating public func next() -> T? {
        if(!self.currentElements.isEmpty) {
            return self.currentElements.popLast()
        }
        // 배열의 마지막 위치일 경우
        // nil 이 반환되면 swift runtime 은 for in루프를 이용한 반복기에서 더이상 순회할 요소가 없음을 알게된다.
        return nil
    }
}

// makeIterator 를 통해 이 프로토콜에 부합하는 배열을 반환하도록 함.
extension Stack: Sequence {
    // swift runtime은 for in 루프를 초기화할때 이 메서드를 호출한다.
    // => 스택 인스턴스에 의해 준비된 배열이 사용될 때 초기화되는 ArrayIterator의 새로운 인스턴스가 반환된다.
    public func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator<T>(elements: self.elements)
    }
    
    // 기존의 스택을 통해 새로운 스택을 초기화
    // 배열 복사시 reversed() 를 통해 입력되는 데이터 순서를 바꿔야 Stack구조에 맞게 된다.
    // (Sequence.makeIterator() 는 배열 초기화 객체에 의해 호출되고, 해당 내용은 스택에 추가되기 떄문)
    public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
        self.elements = Array(s.reversed())
    }
}



var myStack: Stack = [1,2,3,4] // [1, 2, 3, 4]

var stackFromMyStack = Stack<Int>(myStack) //[1, 2, 3, 4]

stackFromMyStack.push(20) // [1, 2, 3, 4, 20]

myStack.push(100) // [1, 2, 3, 4, 100]

stackFromMyStack // [1, 2, 3, 4, 20]

//: [Next](@next)
