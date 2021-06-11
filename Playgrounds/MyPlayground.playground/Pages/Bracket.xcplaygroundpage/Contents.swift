//: [Previous](@previous)

import Foundation

/**
 올바른 괄호
 
 "()()"    true
 "(())()"    true
 ")()("    false
 "(()("    false
 */


//let s = "(())()" // true
let s = ")()(" // false


func solution(_ s:String) -> Bool
{
    var check:Int = 0
    let arr = Array(s)

    for char in arr {
        if(char == "(") { check += 1 }
        else {
            if(check == 0) { return false }
            check -= 1
        }
    }

    return (check == 0)
}

print(solution(s))

//: [Next](@next)
