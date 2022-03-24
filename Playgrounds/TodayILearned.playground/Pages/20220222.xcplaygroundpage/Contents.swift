//: [Previous](@previous)

import Foundation

/**
 백준 프린터 큐
 
 각 테스트 케이스에 대해 문서가 몇번째로 인쇄되는지 출력
 
 - (문서개수 N, 인쇄순서가 궁금한 문서의 index)
 - (N개 문서의 중요도)
 */
func solution(입력값: String, 중요도배열: [Int]) -> Int {
    let commands = 입력값.components(separatedBy: " ").compactMap{ Int($0) }
    let 문서개수: Int = commands[0]
    let 구할문서인덱스: Int = commands[1]
    
    var queue = [Document]()
    
    for i in 0..<중요도배열.count {
        let doc = Document(index: i, 중요도: 중요도배열[i])
        queue.append(doc)
    }
 
    var 출력순서:Int = 1
    
    while(!queue.isEmpty) {
        guard let peekItem = queue.first else {
            break
        }
        
        // 첫번째 아이템의 중요도를 확인
        // 현재 아이템보다 중요도가 높은 문서가 배열에 있다? => 큐의 가장뒤에 배치
        // 현재 아이템의 중요도가 가장 높다 => 큐에서 제거
        let 중요도높은문서있나 = queue
            .filter{$0.index != peekItem.index}
            .contains{ $0.중요도 > peekItem.중요도 }
        if !중요도높은문서있나 {
            // 현재 아이템의 중요도가 가장 높다
            let 지운문서 = queue.removeFirst()
            if (지운문서.index == 구할문서인덱스) { return 출력순서 }
            출력순서 += 1
            continue
        }
        
        // 큐의 가장뒤에 배치
        let 지운문서 = queue.removeFirst()
        queue.append(지운문서)
    }
    
    return 0
}

struct Document {
    let index: Int
    let 중요도: Int
}

let result = solution(입력값: "4 2", 중요도배열: [1,2,3,4])
print(result)


//: [Next](@next)
