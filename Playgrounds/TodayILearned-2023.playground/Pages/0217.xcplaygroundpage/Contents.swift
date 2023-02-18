//: [Previous](@previous)

import UIKit
import Combine

// <Output, FailType>
// ## example1: [1,2,3] 배열의 요소를 하나씩 내보내서 이벤트 처리하기
var myPublisher: Publishers.Sequence<[Int], Never> = [1,2,3].publisher

// Never 는 publisher 에서 에러를 발생시키지 않는다!
myPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error):
        print(error)
    }
}, receiveValue: { value in
    print(value)
})
//1
//2
//3
//완료

//: ## Notification Center 로 publisher 만들기
// Rx 의 disposable 과 유사: 하나의 publisher 만 관리할때
var subscription: AnyCancellable?
// Rx 의 disposableBag 과 유사: 여러개의 publisher 를 관리할때 사용
var subscriptionSet = Set<AnyCancellable>()

// 고유한 키값을 사용: 대부분 앱 id 를 사용
var myNoti = Notification.Name("com.rosa.customNoti")
var defaultPublisher = NotificationCenter.default.publisher(for: myNoti)

// notification center 로 보낸 이벤트를 받을려면, publisher 를 반드시 구독해야한다!
// Publisher.sink 를 사용해 구독
subscription = defaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error):
        print(error)
    }
    
}, receiveValue: { outputValue in
    print("receiveValue", outputValue)
})
//.store(in: &subscriptionSet)

// 여러개의 subscription 을 한꺼번에 메모리에 날리기 위해
subscription?.store(in: &subscriptionSet)

// notification center 에게 이벤트를 보냄
NotificationCenter.default.post(Notification(name: myNoti))

// 이벤트 처리 후, 메모리에서 해제하기 위해 cancel() 호출
subscription?.cancel()


//------------------------------------------//
//: ## key-value observing(KVO): 키와 값을 관찰
class Friend {
    var name = "짱구" {
        didSet {
            print("Friend.name didSet: ", name)
        }
    }
}

var zzanggu = Friend()

// publisher 생성하고 바로 assing 을 통해 구독할 수 있다
// "짱구" -> 구독하면서 값을 "철수"로 변경
// "zzanggu" 객체 인스턴스에 옵저빙이 된다. => zzanggu의 name 을 ["철수"]로 구독하게 됨
var friendSubscription: AnyCancellable = ["철수"].publisher.assign(to: \.name, on: zzanggu)
// Friend.name didSet:  철수



//------------------------------------------//
//: # WWDC- Combine
// Using Publishers with Combine
var trickNoti = Notification.Name("com.rosa.trickNoti")
//let trickNamePublisher = NotificationCenter.default.publisher(for: trickNoti)
//    .map { notification in
//        return notification.userInfo["data"] as! Data
//    }
//    .decode(type: MagicTrick.self, decoder: JSONDecoder())
//    .catch {
//        return Just(MagicTrick.placeholder)
//    }

/**
 Notification --> Data ----> MagicTrick---> MagicTrick
 Never              Never        Error                Never
 
 Nofification     map            decode          catch
  Publisher                                               Just / placeholder
 
 
 
 Upstream  ----> flatMap[Just -- decode -- catch] ----> Subscriber
 publisher
 
 */

// flatMap 적용: fail 이 되지 않는다는 것을 보장할 수 있다
//let trickNamePublisher = NotificationCenter.default.publisher(for: trickNoti)
//    .map { notification in
//        return notification.userInfo["data"] as! Data
//    }
//    .flatMap { data in
//        return Just(data)
//            .decode(type: MagicTrick.self, decoder: JSONDecoder())
//            .catch {
//                return Just(MagicTrick.placeholder)
//            }
//    }
//    .publisher(for: \.name) // String, Never
//    .receive(on: RunLoop.main)
    

// Sceheduled Operators
// delay, debounce, throttle, receive(on:), subscribe(on:)


//: [Next](@next)
