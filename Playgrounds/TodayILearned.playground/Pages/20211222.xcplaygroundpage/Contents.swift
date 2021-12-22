//: [Previous](@previous)

import Foundation
import XCTest

/*:
 ## K번째 수
 
 - 배열 array의 i번째 숫자부터 j번째 숫자까지 자르고 정렬했을 때, k번째에 있는 수를 구하려 합니다.
 - 예를 들어 array가 [1, 5, 2, 6, 3, 7, 4], i = 2, j = 5, k = 3이라면

 1. array의 2번째부터 5번째까지 자르면 [5, 2, 6, 3]입니다.
 2. 1에서 나온 배열을 정렬하면 [2, 3, 5, 6]입니다.
 3. 2에서 나온 배열의 3번째 숫자는 5입니다.
 - 배열 array, [i, j, k]를 원소로 가진 2차원 배열 commands가 매개변수로 주어질 때, commands의 모든 원소에 대해 앞서 설명한 연산을 적용했을 때 나온 결과를 배열에 담아 return 하도록 solution 함수를 작성해주세요.
 */

// [1, 5, 2, 6, 3, 7, 4], i = 2, j = 5, k = 3


func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    var results: [Int] = []
    for c in commands {
        let v = findValue(arr: array, command: c)
        results.append(v)
    }
    return results
}

func findValue(arr: [Int], command: [Int]) -> Int {
    let i = command[0]
    let j = command[1]
    let k = command[2]
        let result = arr[i-1..<j].sorted()
        return result[k-1]
}


/*:
 ## 문자열 내 마음대로 정렬하기
 문자열로 구성된 리스트 strings와, 정수 n이 주어졌을 때, 각 문자열의 인덱스 n번째 글자를 기준으로 오름차순 정렬하려 합니다. 예를 들어 strings가 ["sun", "bed", "car"]이고 n이 1이면 각 단어의 인덱스 1의 문자 "u", "e", "a"로 strings를 정렬합니다.
 
 - strings는 길이 1 이상, 50이하인 배열입니다.
 - strings의 원소는 소문자 알파벳으로 이루어져 있습니다.
 - strings의 원소는 길이 1 이상, 100이하인 문자열입니다.
 - 모든 strings의 원소의 길이는 n보다 큽니다.
 - 인덱스 1의 문자가 같은 문자열이 여럿 일 경우, 사전순으로 앞선 문자열이 앞쪽에 위치합니다.
 
- 입출력 예 1
    - "sun", "bed", "car"의 1번째 인덱스 값은 각각 "u", "e", "a" 입니다. 이를 기준으로 strings를 정렬하면 ["car", "bed", "sun"] 입니다.
 
 */
func solutionStringSort(_ strings:[String], _ n:Int) -> [String] {
    let r = strings.sorted(by: {
        let char1 = $0[$0.index($0.startIndex, offsetBy: n)]
        let char2 = $1[$1.index($0.startIndex, offsetBy: n)]
        if (char1 == char2) {
            return $0 < $1
        }
        return char1 < char2
    })
    
    print(r)
    
    return []
}




/*:
 ## 스킬 트리
 선행 스킬이란 어떤 스킬을 배우기 전에 먼저 배워야 하는 스킬을 뜻합니다.
 예를 들어 선행 스킬 순서가 스파크 → 라이트닝 볼트 → 썬더일때, 썬더를 배우려면 먼저 라이트닝 볼트를 배워야 하고, 라이트닝 볼트를 배우려면 먼저 스파크를 배워야 합니다.

 위 순서에 없는 다른 스킬(힐링 등)은 순서에 상관없이 배울 수 있습니다. 따라서 스파크 → 힐링 → 라이트닝 볼트 → 썬더와 같은 스킬트리는 가능하지만, 썬더 → 스파크나 라이트닝 볼트 → 스파크 → 힐링 → 썬더와 같은 스킬트리는 불가능합니다.

 선행 스킬 순서 skill과 유저들이 만든 스킬트리1를 담은 배열 skill_trees가 매개변수로 주어질 때, 가능한 스킬트리 개수를 return 하는 solution 함수를 작성해주세요.

 - 제한 조건
     - 스킬은 알파벳 대문자로 표기하며, 모든 문자열은 알파벳 대문자로만 이루어져 있습니다.
     - 스킬 순서와 스킬트리는 문자열로 표기합니다.
     - 예를 들어, C → B → D 라면 "CBD"로 표기합니다
     - 선행 스킬 순서 skill의 길이는 1 이상 26 이하이며, 스킬은 중복해 주어지지 않습니다.
     - skill_trees는 길이 1 이상 20 이하인 배열입니다.
     - skill_trees의 원소는 스킬을 나타내는 문자열입니다.
     - skill_trees의 원소는 길이가 2 이상 26 이하인 문자열이며, 스킬이 중복해 주어지지 않습니다.
 */

public struct Queue<T> {
    private var data = [T]()
    
    public init() {}
    
    // 첫번째 요소를 제거후 반환
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    // 첫번째 요소를 제거하지 않고 반환
    public func peek() -> T? {
        return data.first
    }
    
    // 큐의 맨 뒤에 데이터 추가
    public mutating func enqueue(_ element: T)  {
        data.append(element)
    }
    
    func isEmpty() -> Bool {
        return data.isEmpty
    }
}


func solutionSkill(_ skill:String, _ skill_trees:[String]) -> Int {
    
    var skillStack = Queue<Character>()
 
    for c in skill {
        skillStack.enqueue(c)
    }
    
    var count = 0
    for skill_s in skill_trees {
        var stack = skillStack
        var isOk = true
        for c in skill_s {
            if !skill.contains(c) {
                continue
            }
            if stack.isEmpty() {
                break
            }
            if c != stack.peek() {
                isOk = false
                break
            }
            // 배울 스킬이 스킬트리에 포함된다
            if c == stack.peek() {
                // 배울 스킬이 맞다
                stack.dequeue()
                continue // 다음 루프 돌기
            }
        }
        // 루프를 다 돌고나서, 스택이 비었다면 스킬트리 조건에 만족한 것
        if stack.isEmpty() || isOk {
            // 스킬트리를 모두 만족했음
            count += 1
            continue
        }
    }
    
    return count
}


/*:
 ## 올바른 괄호
 괄호가 바르게 짝지어졌다는 것은 '(' 문자로 열렸으면 반드시 짝지어서 ')' 문자로 닫혀야 한다는 뜻입니다. 예를 들어

 - "()()" 또는 "(())()" 는 올바른 괄호입니다.
 - ")()(" 또는 "(()(" 는 올바르지 않은 괄호입니다.
 - '(' 또는 ')' 로만 이루어진 문자열 s가 주어졌을 때, 문자열 s가 올바른 괄호이면 true를 return 하고, 올바르지 않은 괄호이면 false를 return 하는 solution 함수를 완성해 주세요.
 */

func solution(_ s:String) -> Bool {
    var check = 0
    
    for c in s {
        if (c == "(") { check += 1 }
        else {
            // 열지 않았는데, 바로 닫힌 괄호가 나온다면
            if (check == 0) { return false }
            check -= 1
        }
    }
    return check == 0
}




class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// K번째 수
    func testKnumber() {
        let s = solution([1, 5, 2, 6, 3, 7, 4], [[2, 5, 3], [4, 4, 1], [1, 7, 3]])
        XCTAssertEqual(s, [5,6,3])
    }
    
    /// 문자열 내마음대로 정렬
    func testStringSort() {
        let result = solutionStringSort(["sun", "bed", "car"], 1)
        let expect = ["car", "bed", "sun"]
//        ["abce", "abcd", "cdx"]    2 =>     ["abcd", "abce", "cdx"]
        XCTAssertEqual(result, expect, "문자열 내마음대로 정렬")
    }
    
    /// 스킬트리
    func testSkillTree() {
        let result = solutionSkill("CBD", ["BACDE", "CBADF", "AECB", "BDA"])
        XCTAssertEqual(result, 2, "스킬 트리")
    }
    
    /// 올바른 괄호
    func testBracket() {
        let result = solution("(())()")
        XCTAssertEqual(result, true, "올바른 괄호")
    }
    
}

Tests.defaultTestSuite.run()


//: [Next](@next)
