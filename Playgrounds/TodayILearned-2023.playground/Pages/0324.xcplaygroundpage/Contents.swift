//: [Previous](@previous)

import Foundation

final class Node {
    var key: Character?
    var children: [Character: Node] = [:]
    var isFinish = false
    
    init(key: Character? = nil) {
        self.key = key
    }
}


final class TrieTree {
    private let root: Node
    
    init() {
        root = Node(key: nil)
    }
    
    func insert(_ word: String) {
        var currentNode = root
        
        for w in Array(word) {
            if currentNode.children[w] == nil {
                currentNode.children[w] = Node(key: w)
            }
            currentNode = currentNode.children[w]!
        }

        currentNode.isFinish = true
    }
    
    func isContain(_ word: String) -> Bool {
        var currentNode = root
        for w in word {
            guard let childNode = currentNode.children[w] else {
                return false
            }
            currentNode = childNode
        }
        return currentNode.isFinish
    }
    
    private func startNode(prefix: String, start: Node) -> Node? {
        var currentNode = start
        for w in prefix {
            if let child = currentNode.children[w] {
                currentNode = child
            } else {
                return nil
            }
        }
        return currentNode
    }
    
    func all() -> [String] {
        return recusiveSearch(startNode: self.root, prefixText: "")
    }
    
    func recusiveSearch(startNode: Node, prefixText: String) -> [String] {
        var result: [String] = []
        dfs(startNode, word: prefixText)
        
        func dfs(_ current: Node, word: String) {
            if current.isFinish {
                result.append(word)
            }
            for (key, childNode) in current.children {
                let appendedWord = "\(word)\(key)"
                dfs(childNode, word: appendedWord)
            }
        }
        return result
    }
    
    
    func startsWith(_ prefix: String) -> [String] {
        var result: [String] = []
        
        guard let startNode = startNode(prefix: prefix, start: self.root) else {
            return result
        }
        return recusiveSearch(startNode: startNode, prefixText: prefix)
    }
}


let tri = TrieTree()
tri.insert("Hello")
tri.isContain("Hello")
tri.isContain("He")
tri.startsWith("Hell")

tri.insert("Hello World")
tri.startsWith("Hell")


// 생성할 문자열의 길이
//let stringLength = 10

// 랜덤 문자열 생성 함수
func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

// 랜덤 문자열 배열
var randomStrings = [String]()

// 5개의 랜덤 문자열 생성하여 배열에 추가
for _ in 1...100 {
    let stringLength = Int.random(in: 1...5)
    let randomString = randomString(length: stringLength)
    randomStrings.append(randomString)
}

// 생성된 랜덤 문자열 배열 출력
print(randomStrings)

//: [Next](@next)
