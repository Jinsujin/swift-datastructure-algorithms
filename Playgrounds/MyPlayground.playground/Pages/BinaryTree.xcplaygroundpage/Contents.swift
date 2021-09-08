//: [Previous](@previous)

import Foundation

/*
 이진 트리 Binary Tree
 최대 두개의 자식 노드를 지닐 수 있는 데이터 구조
 
 이진 검색트리는 데이터 접근, 검색, 삽입, 삭제에 N ~ logN 정도의 시간소요
 성능 시간은 트리의 높이에 영향을 받음.
 트리에서 노드 P가 있을때,
 왼쪽자식트리 노드.value <= P.value
 오른쪽자식트리 노드.value >= P.value

 
 
 
 이진 트리 구현을 위해서는 다음 조건을 갖추어야 한다.
 - 키 데이터 값을 포함한 컨테이너
 - 좌, 우측 자식 노드에 대한 두개의 참조값
 - 부모 노드에 대한 참조값
 **/


/**
 제네릭으로 어떤 타입의 값이든 받아 들일 수 있도록 구현.
 
 */
public class BinaryTreeNode<T: Comparable> {
    // 키 데이터
    public var value: T
    
    // 자식들의 참조값
    public var leftChild: BinaryTreeNode?
    public var rightChild: BinaryTreeNode?
    
    // 부모노드의 참조값
    public weak var parent: BinaryTreeNode?
    
    /// value 값으로 초기화
    public convenience init(_ value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil)
    }
    
    public init(value: T, left:BinaryTreeNode?, right: BinaryTreeNode?, parent: BinaryTreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }
    
    public func insertNodeFromRoot(_ value: T) {
        // 이진 검색 트리의 프로퍼티 유지를 위해서는, 반드시 루트 노드에서 부터 insertNode 작업이 실행되어야 함
        if let _ = self.parent {
            print("Error::- 새로운 노드 추가는 트리의 루트노드에서 부터 가능합니다")
            return
        }
        self.addNode(value)
    }
    
    // 재귀적으로 나머지 노드를 순회하면서 새로운 노드를 삽입할 위치를 찾음
    private func addNode(_ value: T) {
        if value < self.value { // 값이 루트 키값보다 작은경우, 왼쪽 서브트리에 삽입
            // 노드가 존재하는 경우 좌측 서브트리에 삽입하고,
            // 노드가 없는 경우 새로운 노드를 만들어 왼쪽 자식 노드로 삽입
            if let leftChild = leftChild {
                leftChild.addNode(value)
            } else {
                let newNode = BinaryTreeNode(value)
                newNode.parent = self
                leftChild = newNode
            }
        } else { // 값이 루트 키값보다 큰경우, 오른쪽 서브트리에 삽입
            if let rightChild = rightChild {
                rightChild.addNode(value)
            } else {
                let newNode = BinaryTreeNode(value)
                newNode.parent = self
                rightChild = newNode
            }
        }
    }
}

let rootNode = BinaryTreeNode(10)
rootNode.insertNodeFromRoot(20)
rootNode.insertNodeFromRoot(5)
rootNode.insertNodeFromRoot(21)
rootNode.insertNodeFromRoot(8)
rootNode.insertNodeFromRoot(4)


//: [Next](@next)
