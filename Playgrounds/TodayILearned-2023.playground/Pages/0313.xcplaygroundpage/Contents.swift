//: [Previous](@previous)

import Foundation

/*: ## KeyPath(framework)
 
 https://developer.apple.com/documentation/swift/keypath
 
 - KeyPath : 읽기 전용(가장많이 사용)
 - WritableKeyPath : 읽기 및 쓰기 가능
 
 */


struct Part {
    var name: String
}

struct Car {
    let part1: Part
    let part2: Part
}



let part1 = Part(name: "타이어")
let part2 = Part(name: "핸들")

let tico = Car(part1: part1, part2: part2)

// 변수의 프로퍼티 2개에 접근하려면 함수가 2개 필요
func getPart1(_ car: Car) -> Part
{
    return car.part1
}

func getPart2(_ car: Car) -> Part
{
    return car.part2
}


print(getPart1(tico))

func getPart(_ car: Car, keypath: KeyPath<Car, Part>) -> Part
{
    return car[keyPath: keypath]
}

print(getPart(tico, keypath: \.part1).name) // 타이어
print(getPart(tico, keypath: \.part2).name) // 핸들


struct Address {
    var post: String
    var city: String
}

struct Person {
    let name: String
    var address: Address
}

var homeAddress = Address(post: "32-13", city: "Busan")
let getAddress = homeAddress[keyPath: \.post]

print(getAddress)
print(type(of: getAddress))

homeAddress[keyPath: \.post] = "99-99"
print(getAddress) // 32-13
print(homeAddress.post) // "99-99"


let people = [
    Person(name: "JIWO", address: Address(post: "12-23", city: "Orange")),
    Person(name: "PIKACHU", address: Address(post: "40-91", city: "Blue")),
]


// WritableKeyPath<Person, Address>
let peopleAddressKeypath = \Person.address

// KeyPath<Person, String>
let peopleNameKeypath = \Person.name


// Swift5.2 에서는 Key Path Expressions 을 함수로 사용할 수 있도록 하는 Proposal이 구현
// 아래 프로토콜이 지원됨
//extension Sequence {
//    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
//        return map { $0[keyPath: keyPath] }
//    }
//}

// 단일 값을 추출하기 위해서는 map 의 클로저를 사용하는 것보다, keypath 를 사용하는 것이 적합할 수 있다
let names1 = people.map{ $0.name }
type(of: names1) // Array<String>.Type

let names2 = people.map(\.name)
type(of: names2) // Array<String>.Type


struct Animal {
    let name: String
}

let animal = Animal(name: "얼룩말")
animal[keyPath: \Animal.name]

type(of: \Animal.name) // KeyPath<Animal, String>.Type


//: [Next](@next)
