//: [Previous](@previous)

import Foundation
import UIKit

/*: # Type Eraser Wrapper 패턴
 
 - 참고 자료
 -  https://minsone.github.io/programming/swift-opaque-type-and-erase-type
 - https://blog.burt.pe.kr/posts/skyfe79-blog.contents-1118038013-post-44/
 */

//: ## Self 제약이 있는 protocol
// 프로토콜은 Generic 을 지원하지 않는 대신, 연관타입을 지원한다
protocol Person {
    var name: String { get set }
    var age: Int { get set }
    func greeting() -> String
    func meet(other: Person)
}


struct KoreanPerson: Person {
    var name: String
    var age: Int
    
    func greeting() -> String {
        return "안녕하세요. 제 이름은 \(name)이고 나이는 \(age)"
    }
    
    func meet(other: Person) {
        print("\(other.name) 을 만났습니다.")
    }
}

struct EnglishPerson: Person {
    var name: String
    var age: Int
    
    func greeting() -> String {
        return "Hello, My name is \(name) and I'm \(age) years old."
    }
    
    func meet(other: Person) {
        print("\(other.name) 을 만났습니다.")
    }
}

var people: [Person] = [
    KoreanPerson(name: "김철수", age: 31),
    EnglishPerson(name: "Berry Chan", age: 21)
]

//: ## Associated Type이 있는 Protocol

//protocol Container {
//    associatedtype Item
//}

//let containers: [Container] = []
// [error]: Use of protocol 'Container' as a type must be written 'any Container'
// 컴파일 타임에 어떤 타입인지 확인이 되어야 메모리에 할당할 수 있는데, 어떤 타입인지 정보가 없기때문에 에러 발생

//: ## Associated Type + Generic Type 사용으로 에러 없애기
protocol Container {
    associatedtype Item
    var items: [Item] { get set }
    var count: Int { get }
    mutating func push(item: Item)
    mutating func pop() -> Item?
}

extension Container {
    var count: Int {
        return items.count
    }
}

/// 구체타입이 protocol 을 채택하여 구현
struct StackContainer<Item>: Container {
    var items: [Item] = []
    mutating func push(item: Item) {
        items.append(item)
    }
    mutating func pop() -> Item? {
        return items.popLast()
    }
}

var containers: [StackContainer<Int>] = [
    StackContainer()
]

containers[0].push(item: 1)
containers[0].push(item: 2)
containers[0].push(item: 3)

print(containers[0].count)

// Container 에 String, Int... 등 다양한 타입을 담고 싶다면?
var anyContainer: StackContainer<Any> = StackContainer()
anyContainer.push(item: 1)
anyContainer.push(item: "Hello")
anyContainer.push(item: 12.5)

// 값을 담을수는 있지만, 사용할때 값을 확인(타입 캐스팅)하여 사용해야 한다
if let item = anyContainer.pop() {
    switch item {
    case is Int:
        print("Int value is \(item)")
    case is String:
        print("String value is \(item)")
    case is Double:
        print("Double value is \(item)")
    default:
        print("undefine value")
    }
}

// 🚨 containers 에 StackContainer<> 타입들을 담고싶지만 에러가 발생한다:
// 이 또한 컴파일러가 어떤 타입인지 알 수 없기때문.
// [Error]: Heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional
//var containers = [
//    StackContainer<Int>(),
//    StackContainer<Double>()
//]

/**
 
 예1.) UICollectionView의 Cell을 그리기 위해서 Model을 사용할 때, 여러 Model을 담을 수 있는 컬렉션이 필요하다
 
 protocol Model {
     associatedtype Data
     var data: Data { get set }
 }

 struct CellModel<Data>: Model {
     var data: Data = []
 }

 var dataCollection = [
     CellModel<String>(),
     CellModel<Int>()
     ...
 ]
 
 여러 제네릭 타입을 가진 CellModel<T> 을 하나의 배열에 담을 수 있고 배열 원소는 타입 정보(속성과 메서드)를 잃지 않는 타입을 만들 수 있을까?
 
 */
//

//------------------------문제해결------------------------------//
//: # Type Eraser Wrapper 패턴
// var dataCollection: [Any] 처럼 선언하여 아무 CellModel 을 추가할 수 있지만 실제로 사용할 때는 타입 캐스팅 없이 사용할 수 있다.
// Combine 의 AnyPublisher, AnyCanllable 또한 여기에 속함

//func get_comparable_value() -> some Comparable {
//  if true { return AnyCompare(10) }
//  else { return AnyCompare("a") }
//}

func get_comparable_value() -> AnyCompare {
    if true { return AnyCompare(10) }
    else { return AnyCompare("a") }
}

let values: [AnyCompare] = [
    AnyCompare(1),
    AnyCompare("A"),
//    AnyCompare(["1", "2"]) // 배열은 안됨..!
]

values.forEach{
    print($0)
}

print("----")

// 값을 어떻게 뽑아오나?
print(get_comparable_value().value)
// AnyCompare(box: __lldb_expr_90.AnyComparableBox<Swift.Int>(origin: 10))


/// 어떤 타입도 가질 수 있는 프로토콜
private protocol AnyTypeBase {
    var value: Any { get }
}

private struct AnyComparableBox<T: Comparable>: AnyTypeBase {
    let origin: T
    var value: Any { self.origin }
}

/// Public Wrapper: 값을 감싸는 타입
/// private box 에 구체 인스턴스를 담는다
struct AnyCompare: Comparable {
    private var box: AnyTypeBase

    public init<T>(_ value: T) where T : Comparable {
        box = AnyComparableBox(origin: value)
      // box.self:: ComparableTypeErased<Int>(origin: 10)
      print(value.self, box.self)
    }
    
    var value: Any {
        return box.value
    }
    
    static func < (lhs: AnyCompare, rhs: AnyCompare) -> Bool {
        return false
    }
    static func == (lhs: AnyCompare, rhs: AnyCompare) -> Bool {
        return false
    }
}


//: [Next](@next)


