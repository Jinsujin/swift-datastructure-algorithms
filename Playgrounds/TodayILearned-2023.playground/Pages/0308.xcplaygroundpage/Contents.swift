//: [Previous](@previous)

import Foundation

private func diagram(for node: Node?,
                     _ top: String = "",
                     _ root: String = "",
                     _ bottom: String = "") -> String {
   guard let node = node else {
        return root + "nil\n"
    }
    if node.left == nil && node.right == nil {
        return root + "\(node.data)\n"
    }
    return diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
        + root + "\(node.data)\n"
        + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
}

/*: ## 이진 탐색 트리
 
 */

final class Node {
    var data: Int
    var left: Node?
    var right: Node?
    
    init(data: Int) {
        self.data = data
    }
}

func searchNode(_ node: Node?, _ target: Int) -> Node? {
    guard let node = node else { return nil }
    if (node.data == target) { return node }
    if (target < node.data) { return searchNode(node.left, target) }
    return searchNode(node.right, target)
}

func insert(_ node: Node?, _ data: Int) -> Node? {
    guard let node = node else {
        return Node(data: data)
    }
    
    if (data < node.data) {
        // left 하위 트리에 삽입
        node.left = insert(node.left, data)
    } else {
        // right 하위 트리에 삽입
        node.right = insert(node.right, data)
    }
    return node
}

let root = Node(data: 50)

insert(root, 24)
insert(root, 42)
insert(root, 33)
insert(root, 22)

insert(root, 55)
insert(root, 52)
insert(root, 57)

let num = root.data
root.left?.data
root.right?.data

root.left?.left?.data // 22
root.left?.right?.data  // 42
root.left?.right?.left?.data // 33

root.right?.data // 55
root.right?.right?.data // 57
root.right?.left?.data // 52
 

searchNode(root, 51)

//print(diagram(for: root))

// 중위 순회
func traverseInOrder(_ node: Node?) {
    guard let node = node else { return }
    traverseInOrder(node.left)
    print(node.data)
    traverseInOrder(node.right)
}

//traverseInOrder(root)
//22
//24
//33
//42
//50
//52
//55
//57

/**
 자식이 있는 노드의 삭제
 
 1. 삭제할 노드를 찾는다
 2. 삭제할 노드의 바로 다음값을 찾는다:
    => 삭제할 노드의 left tree에서 가장 오른쪽에 있는 값
 3. 삭제할 노드와 2에서 찾은 노드를 교체
 4. 리프로 만든 target Node 삭제
 */
func deleteNode(_ node: Node, _ target: Int) -> Node? {
    guard let targetNode = searchNode(node, target) else {
        return nil
    }
    
    // 삭제할 값의 바로 이전값을 찾는다
    // 위치: 삭제할 노드의 left 트리에서 가장 오른쪽 자식
    var prevNode = targetNode.left
    var prevParent: Node? = targetNode
    
    while(prevNode?.right != nil) {
        if (prevNode?.right == nil) {
            prevParent = prevNode
        }
        prevNode = prevNode?.right
    }
    
    print("찾은 노드", prevNode?.data) // 22
    print("찾은 노드의 부모", prevParent?.data)
    
    let updateData = prevNode!.data
    
    // 삭제할 노드와 교환할 leaf 노드의 부모가 같은경우
    if targetNode === prevParent {
        prevParent?.left = nil
    } else {
        prevParent?.right = nil
    }
    
    targetNode.data = updateData
    return targetNode
}

//deleteNode(root, 24) // 22 와 자리바꿈
//traverseInOrder(root)
//22
//33
//42
//50
//52
//55
//57


//print(diagram(for: root))

func deepCopy(_ node: Node?) -> Node? {
    guard let node = node else { return nil }
    
    let newNode = Node(data: node.data)
    newNode.left = deepCopy(node.left)
    newNode.right = deepCopy(node.right)
    return newNode
}

let copyNode = deepCopy(root)

traverseInOrder(root)

print("CopyNode----")
traverseInOrder(copyNode)

print("원본 node 에 삽입")
insert(root, 10)
traverseInOrder(root)
//10
//22
//24
//33
//42
//50
//52
//55
//57


print("CopyNode----")
traverseInOrder(copyNode)
//22
//24
//33
//42
//50
//52
//55
//57

//: [Next](@next)
