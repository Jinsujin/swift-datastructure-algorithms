//: [Previous](@previous)

import Foundation


/*:
 # 학습
 */


//: ## Dynamic Types
// https://developer.apple.com/documentation/swift/2885064-type

func printInfo(_ value: Any) {
    let t = type(of: value)
    print("'\(value)' of type \(t)")
}

let count: Int = 5
printInfo(5) // '5' of type Int

//### 예제.

class Smiley {
    class var text: String {
        return ":)"
    }
}

class EmojiSmiley: Smiley {
    override class var text: String {
        return "😀"
    }
}

func printSmileyInfo(_ value: Smiley) {
    // 여기
    let smileyType = type(of: value)
    print(smileyType, smileyType.text)
}

let emojiSmiley = EmojiSmiley()
printSmileyInfo(emojiSmiley) // EmojiSmiley 😀
// printSmileyInfo 는 Smiley 타입을 인자로 받지만,
// type 함수는 하위 클래스에서 재정의된 값에 접근한다


let emoji = Smiley()

let emojiArray: [Smiley] = [emoji, emojiSmiley]
emojiArray.forEach { print($0) }


//: ### 예제.
let number = 1
let name = "jin"
print(type(of: number)) // Int

let stringType: String.Type = String.self
let AnyType: Any.Type = Any.self

print(type(of: number) == stringType) // false
print(type(of: name) == stringType) // true

//: [Next](@next)
