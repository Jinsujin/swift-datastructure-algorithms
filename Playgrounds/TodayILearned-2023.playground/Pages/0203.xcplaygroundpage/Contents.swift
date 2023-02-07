import UIKit

/*: Async/ await
 - concurrent(동시성) programming 을 도와준다
 - 기존에 사용했던 dispatchQueue, completion handler 의 단점을 해결:
 - 큰 장점: 가독성을 높일 수 있다
 - 동기: 이전 작업이 끝날때까지 기다린다. (block 상태가 됨)
 - 비동기: 이전 작업이 끝날때까지 기다리지 않고 다음 작업 실행
 - async 키워드로 비동기함수라는 것을 표시
 - await 키워드로 연기 시점(suspend point)을 표시
 */

/*
func networkTask(_ second: UInt64) async -> UInt64 {
    do {
        try await Task.sleep(nanoseconds: 1000 * 1000 * 1000 * second)
    } catch {
        // 작업이 취소되면 error 로 들어옴
        print(error)
    }
    print(second)
    return second
}

func simpleWork() {
    print("simple-work")
}

func start() {
    print("start")
    // 동기 context에서 비동기 함수를 호출할때 Task 로 묶는다
    Task {
        let result = await networkTask(5)
        print("network task end:", result)
    }
    simpleWork()
}
 start()
 */

//: ### 비동기 함수를 순차적으로 실행
/*
Task {
    await networkTask(1)
    await networkTask(2)
    await networkTask(3)
}
*/

//: ### 비동기 함수를 동시에(concurrecy) 실행
// 비동기 함수들을 동시에 실행하고, 결과를 모두 받아올때까지 기다린다(await)
// (참고: playground 환경에서는 실행되지 않음)
/*
var task = Task {
    async let sec1 = networkTask(1)
    async let sec2 = networkTask(2)
    async let sec3 = networkTask(3)
    // networkTask 의 반환값이 없더라도 async let 을 써야함

    let result = await (sec1, sec2, sec3)
    print(result)
}

// 작업 취소하기
task.cancel()
*/



//: #example: 비동기 작업이 cancel 되었을때 처리
enum NetworkError: String, Error {
    case failConnection = "연결 실패"
    case cancel = "사용자 취소"
}
/*
var task = Task<UInt64, Error>?

func networkTask(_ second: UInt64) async throws -> UInt64 {
    do {
        try await Task.sleep(nanoseconds: 1000 * 1000 * 1000 * second)
    } catch {
        // 작업이 취소되면 error 로 들어옴
        print(error)
        throw error
    }
    print(second)
    return second
}

func simpleWork() {
    print("simple-work")
}


task = Task {
    // 1. sec1, sec2, sec3 은 비동기적으로 작업을 진행
    // => 어느작업이 먼저 끝날지 알수없다(OS 의 영역)
    async let sec1 = networkTask(1)
    async let sec2 = networkTask(2)
    async let sec3 = networkTask(3)
        
    // 2. 모든 비동기 작업이 끝났을때, sum 을 받아올수 있다
    var sum: UInt64 = 0
    do {
        sum = try await (sec1 + sec2 + sec3)
    } catch {
        throw NetworkError.failConnection
    }
    
    // 3. 작업이 취소되었는지 체크해서, 최소되었다면 0 반환
//    if task.isCancelled {
//        return 0
//    }
//    guard task?.isCancelled == false else {
//        return 0
//    }
    
    do {
        try Task.checkCancellation()
    } catch {
        throw NetworkError.cancel
    }
    
    print(sum)
    return sum
}

func touchedCancelButton() {
    task.cancel()
}

//: ### 비동기 작업들의 결과값 가져오기
Task {
    // 에러처리없이 값만 가져올 경우
    try await task?.value
    
    // 에러처리가 필요한 경우
    do {
        let result = try await task?.result.get()
        print(result)
    } catch let error as NetworkError {
        print(error.rawValue)
    }
//    } catch NetworkError.failConnection {
//        print("failConnection 에러처리")
//    }
}

*/



//: ### throw 대신, 내가 만든 에러타입으로 반환하기
func networkTask(_ second: UInt64) async -> Result<UInt64, NetworkError> {
    do {
        try await Task.sleep(nanoseconds: 1000 * 1000 * 1000 * second)
    } catch {
        // 작업이 취소되면 error 로 들어옴
        print(error)
        return .failure(.cancel)
    }
    print(second)
    return .success(second)
}

Task {
    let response = await networkTask(3)
    switch response {
    case .success(let value):
        print(value)
    case .failure(let error):
        print(error)
    }
}
