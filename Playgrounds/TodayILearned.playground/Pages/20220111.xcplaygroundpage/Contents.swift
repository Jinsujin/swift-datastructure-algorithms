//: [Previous](@previous)

import Foundation
import XCTest

/*:
 https://zeddios.tistory.com/1244
 https://www.swift.org/blog/swift-collections/
 https://twitter.com/swiftandtips/status/1379620330529042432/photo/2
 
 */


protocol Queue {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}


extension Array: Queue {
    mutating func push(_ element: Element) {
        self.append(element)
    }
    
    mutating func pop() -> Element? {
        if self.isEmpty { return nil }
        return self.removeFirst()
    }
}


class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQueueDefault() {

        var queue = [Int]()
        measure {
            for i in 0...1000 {
                queue.push(i)
            }
        }
        while let _ = queue.pop() {}
    }
}

//Tests.defaultTestSuite.run()

var str: String? = "Hello World!"

// while let : 반복 횟수를 모를때 사용
while let x = str {
    print(x)
    str = nil
}


//: [Next](@next)
