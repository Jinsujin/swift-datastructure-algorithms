//: [Previous](@previous)

import Foundation


/*:
분산처리
https://www.acmicpc.net/problem/1009
 
 - NOTE: 제출시 테스트 실패. 문제에 나와있는 테스트 케이스는 통과.
 - 빠진 예외가 있는지 찾아볼것
*/
let N: Int = Int(readLine()!)!

for _ in 0..<N {
    let lineArr = readLine()!.split(separator: " ").map{ Int($0) }
    guard let base = lineArr[0], let idx = lineArr[1] else { continue }
    var result = base
    
    if idx == 1 {
        print(result)
        continue
    }

      // 3^2 부터 3^7 까지 // 7을 포함한다
    for _ in 2...idx {
        result = (result * base) % 10
    }
    
    if (result == 0) {
        print(10)
        continue
    }
    
    print(result)
}



/*
저항
https://www.acmicpc.net/problem/1076
*/
let N: Int = 3
var result: String = ""

for i in 0..<N {
    guard let str = readLine() else { continue }
    let resistance = Resistance.convert(str)
    
    // 곱셈인 경우
    if i == 2 {
        result = String(Int(result)!) + resistance.multi
        break
    }
    result += String(resistance.rawValue)
}

result.first == "0" ? print("0") : print(result)


enum Resistance: Int {
    case black = 0, brown, red, orange, yellow, green, blue, violet, grey, white

    static func convert(_ str: String) -> Self {
        switch str {
        case "black":
            return .black
        case "brown":
            return .brown
        case "red":
            return .red
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "green":
            return .green
        case "blue":
            return .blue
        case "violet":
            return .violet
        case "grey":
            return .grey
        case "white":
            return .white
        default:
            fatalError("변환할 수 없음")
        }
    }
    
    var multi: String {
        switch self {
        case .black :
            return ""//"1"
        case .brown:
            return "0"//"10"
        case .red:
            return "00"//"100"
        case .orange:
            return "000"//"1000"
        case .yellow:
            return "0000"//"10000"
        case .green:
            return "00000"//"100000"
        case .blue:
            return "000000"//"1000000"
        case .violet:
            return "0000000"//"10000000"
        case .grey:
            return "00000000"//"100000000"
        case .white:
            return "000000000" //"1000000000"
        default:
            return ""
        }
    }
}

//: [Next](@next)
