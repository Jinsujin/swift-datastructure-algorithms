//: [Previous](@previous)

import Foundation


@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
// 방법1.
//struct SmallRectangle {
//    @TwelveOrLess var height: Int
//    @TwelveOrLess var width: Int
//}

// 방법2.
struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}


var rectangle = SmallRectangle()
print(rectangle.height) // 0

rectangle.height = 10
print(rectangle.height) // 10

rectangle.height = 23
print(rectangle.height) // 12


/*:
### 초기값을 설정하는 Property Wrapper 사용 예
 */
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximun: Int) {
        self.maximum = maximun
        number = min(wrappedValue, maximun)
    }
}

// property에 초기값을 생략한 경우,
// property wrapper 의 init() 을 사용해 초기값을 설정함
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)


// property에 초기값을 명시한 경우,
// init(wrappedValue: Int) 를 사용해 초기값 설정함
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 20
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width) // 1, 12


// 초기값과 max 값을 설정하여 인스턴스를 생성할 수 있다
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximun: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximun: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// 2,3

narrowRectangle.height = 100
narrowRectangle.width = 90
print(narrowRectangle.height, narrowRectangle.width)
// 5,4


//: ### Projecting a value From a Property Wrapper
@propertyWrapper
struct ProjectedSmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeStructure {
    @ProjectedSmallNumber var someNumber: Int
}

// $someNumber 를 사용해 wrapper 의 projectedValue 에 접근가능
var someStructure = SomeStructure()
someStructure.someNumber = 4
print(someStructure.someNumber) // 4
print(someStructure.$someNumber) // false

someStructure.someNumber = 55
print(someStructure.someNumber) // 12
print(someStructure.$someNumber) // true


enum Size {
    case small, large
}

struct SizedRectangle {
    @ProjectedSmallNumber var height: Int
    @ProjectedSmallNumber var width: Int
    
    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 10
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}

var sizedRectangle = SizedRectangle()
let smallSize = sizedRectangle.resize(to: .small)
let largeSize = sizedRectangle.resize(to: .large)


//: [Next](@next)
