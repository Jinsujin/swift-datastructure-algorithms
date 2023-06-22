//: [Previous](@previous)

import Foundation

class ListNode {
     var val: Int
     var next: ListNode?
     init() { self.val = 0; self.next = nil; }
     init(_ val: Int) { self.val = val; self.next = nil; }
     init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }


func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
   guard let l1Num = convertReverseNumber(l1),
       let l2Num = convertReverseNumber(l2) else {
       return nil
   }
   var sum = l1Num + l2Num
   let str: [String] = Array(String(sum)).map { String($0) }
   
   var curNode: ListNode?
   for char in str {
       guard let val = Int(char) else { continue }
       let newNode = ListNode(val)
       if curNode == nil {
           curNode = newNode
       } else {
           curNode = ListNode(val, curNode)
       }
   }
   return curNode
}

private func convertReverseNumber(_ listNode: ListNode?) -> Int? {
   guard let listNode = listNode else { return nil }
   var result = ""
   var currentNode: ListNode? = listNode
   
   while(currentNode!.next != nil) {
       guard let node = currentNode else { break }
       result += "\(node.val)"
       currentNode = node.next
   }
   result += "\(currentNode!.val)"
   return Int(String(result.reversed()))
}

// l1 = [2,4,3]
// l2 = [5,6,4]

var l1 = ListNode(2, ListNode(4, ListNode(3, nil)))
var l2 = ListNode(5, ListNode(6, ListNode(4, nil)))

//convertReverseNumber(l1)

let l3 = addTwoNumbers(l1, l2)
l3?.val // 7
l3?.next?.val // 0
l3?.next?.next?.val // 8


//: [Next](@next)
