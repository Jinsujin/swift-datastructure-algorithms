//: [Previous](@previous)

import Foundation

/*: ## CasePath
 
 */



struct User {
    var id: Int
    let isAdmin: Bool
    var name: String
}

\User.id as WritableKeyPath<User, Int>
\User.isAdmin as KeyPath<User, Bool>
\User.name

var user = User(id: 12, isAdmin: true, name: "Rosa")
user[keyPath: \.id]

user[keyPath: \.id] = 55
user.id = 89


// KeyPath 는 getter/setter 기능을 자유롭게 전달할 수 있다.
// 두 객체간의 바인딩 관계 설정에 사용할 수 있다


class Label: NSObject {
    @objc dynamic var font = "Helvetica"
    @objc dynamic var fontSize = 10
    @objc dynamic var text = ""
}

class Model: NSObject {
    @objc dynamic var userName = ""
}
let model = Model()
let label = Label()

// model 이 변경되면 label 이 자동으로 업데이트된다
//bind(model: model, \.userName, to: label, \.text)


/**
 Combine framework 에서 bind 와 유사한 기능을 수행할 수 있다
 */

import Combine

let subject = PassthroughSubject<String, Never>()
subject.assign(to: \.text, on: label)

subject.send("MaTh_FaN96")
label.text // "MaTh_FaN96"


//[1,2,3].reduce(into: <#T##Result#>, <#T##(Result, Self.Element) -> Void#>)
[1,2,3].reduce(into: 0) { $0 += $1 }
[1,2,3].reduce(into: 0, +=)


typealias Reducer<Value, Action> = (inout Value, Action) -> Void

func pullback<GlobalValue, LocalValue, Action>(
  reducer: @escaping Reducer<LocalValue, Action>,
  value: WritableKeyPath<GlobalValue, LocalValue>
) -> Reducer<GlobalValue, Action> {
  return { globalValue, action in
//      var localValue = globalValue[keyPath: value]
//      reducer(&localValue, action)
//      globalValue[KeyPath: value] = localValue
      reducer(&globalValue[keyPath: value], action)
  }
}

let counterReducer: Reducer<Int, Void> = { count, _ in count += 1 }

// 구조체에서 field 를 추출하여 클로저를 만든다
pullback(reducer: counterReducer, value: \User.id)


/*: # CasePath
 열거형에 대한 KeyPath
 
 */

// WritableKeyPath 를 단순하게 나타내면 다음과 같다:
struct _WritableKeyPath<Root, Value> {
  let get: (Root) -> Value
  let set: (inout Root, Value) -> Void
}



struct CasePath<Root, Value> {
    // 열거형에서 값을 추출: 실패할 수 있으므로 Optional
  let extract: (Root) -> Value?
    
    // case 에서 Value 를 가져와 Root 열거형에 포함
    let embed: (Value) -> Root
}

//let successCasePath: CasePath<Result<Success, Failure>, Success>


extension Result {
  static var successCasePath: CasePath<Result, Success> {
    CasePath<Result, Success>(
      extract: { result -> Success? in
        if case let .success(value) = result {
          return value
        }
        return nil
    },
      embed: Result.success
    )
  }

  static var failureCasePath: CasePath<Result, Failure> {
    CasePath<Result, Failure>(
      extract: { result -> Failure? in
        if case let .failure(value) = result {
          return value
        }
        return nil
    },
      embed: Result.failure
    )
  }
}

Result<Int, Error>.successCasePath // CasePath<Result<Int, Error>, Int>
Result<Int, Error>.failureCasePath // CasePath<Result<Int, Error>, Error>

/*: ## KeyPath 연결하기
 */
extension _WritableKeyPath {
  func appending<AppendedValue>(path: _WritableKeyPath<Value, AppendedValue>) -> _WritableKeyPath<Root, AppendedValue> {
    return _WritableKeyPath<Root, AppendedValue>(
      get: { root in path.get(self.get(root)) },
      set: { root, appendedValue in
        var value = self.get(root)
        path.set(&value, appendedValue)
        self.set(&root, value)
    })
  }
}

struct Location {
  var name: String
}

struct GameUser {
  var location: Location
}



// WritableKeyPath<GameUser, String>
(\GameUser.location).appending(path: \Location.name)


\GameUser.self
\Int.self


/**
 
 
 */

enum Authentication {
  case authenticated(AccessToken)
  case unauthenticated
}

struct AccessToken {
  var token: String
}


let users = [
  User(
    id: 1,
    isAdmin: true,
    name: "Blob"
  ),
  User(
    id: 2,
    isAdmin: false,
    name: "Blob Jr."
  ),
  User(
    id: 3,
    isAdmin: true,
    name: "Blob Sr."
  ),
]

func allProperties(_ value: Any) -> [String] {
    let mirror = Mirror(reflecting: value)
    return mirror.children.compactMap { child in child.label }
}

allProperties(user) // ["id", "isAdmin", "name"]


// (nil, {id 1, isAdmin true, name "Blob"})
Mirror(reflecting: users).children.first!



let auth = Authentication.authenticated(AccessToken(token: "deadbeef"))

let mirror = Mirror(reflecting: auth) // Mirror for Authentication
//dump(mirror.children.first!)
//▿ (2 elements)
//  ▿ label: Optional("authenticated")
//    - some: "authenticated"
//  ▿ value: __lldb_expr_54.AccessToken
//    - token: "deadbeef"


mirror.children.first!.value as? AccessToken


//func extract<Root, Value>(from root: Root) -> Value? {
//    let mirror = Mirror(reflecting: root)
//    guard let child = mirror.children.first else { return nil }
//    return child.value as? Value
//}

//extract(from: auth) as AccessToken? // AccessToken

enum Example {
    case foo(Int)
    case bar(Int)
}
//extract(from: Example.foo(2)) as Int? // 2


//func extract<Root, Value>(case: String, from root: Root) -> Value? {
//    let mirror = Mirror(reflecting: root)
//    guard let child = mirror.children.first else { return nil }
//    guard `case` == child.label else { return nil }
//    return child.value as? Value
//}

//extract(case: "foo", from: Example.foo(2)) as Int? // 2
//extract(case: "bar", from: Example.foo(2)) as Int? // nil


func extractHelp<Root, Value>(
    case: (Value) -> Root,
    from root: Root
) -> Value? {
    let mirror = Mirror(reflecting: root)
    guard let child = mirror.children.first else { return nil }
    // 값을 가져온다:
    // .foo(2) 에서 "2"
    guard let value = child.value as? Value else {
        return nil
    }
    let newRoot = `case`(value) // foo(2)
    let newMirror = Mirror(reflecting: newRoot) // Example
    guard let newChild = newMirror.children.first else { return nil }
    // newChild = (label: Optional("foo"), value: 2)
    guard newChild.label == child.label else { return nil }
    return value
}

//extract(case: Authentication.authenticated, from: auth) // AccessToken
//extract(case: Example.foo, from: .foo(2)) // 2

extractHelp(case: Result<Int, Error>.success, from: .success(11)) // 11


extension CasePath {
    init(_ embed: @escaping (Value) -> Root) {
        self.embed = embed
        self.extract = { root in extractHelp(case: embed, from: root) }
    }
}

CasePath(Example.foo)
CasePath(Result<Int, Error>.success)

struct Address {
    var city: String
    var country: String
}

struct Citizen {
    var id: Int
    var isAdmin: Bool
    var address: Address
    var name: String
}

let citizen = Citizen(id: 1, isAdmin: false, address: Address(city: "Busan", country: "Orange"), name: "Rosa")

let locationCountryCasePath = CasePath<Address, String>(
    { country in Address(city: "KK", country: country) }
)

locationCountryCasePath.extract(citizen.address) // "Busan"


CasePath(Optional<Int>.some)
// CasePath<Optional<Int>, Int>

CasePath(DispatchTimeInterval.seconds)
// CasePath<Dispatch.DispatchTimeInterval, Int>

CasePath(Subscribers.Completion<Error>.failure)
// CasePath<Combine.Subscribers.Completion<Error>, Error>


prefix operator /
prefix func / <Root, Value> (
    case: @escaping (Value) -> Root
) -> CasePath<Root, Value> {
    CasePath(`case`)
}

/Optional<Int>.some

enum LoadState<A> {
    case loading
    case loaded(Result<A, Error>)
}


let states: [LoadState<Int>] = [
    .loaded(.success(1)),
    .loaded(.failure(NSError(domain: "", code: 400))),
    .loading,
    .loaded(.success(2)),
]

let tokens = states.compactMap {
    if case let .loaded(.success(token)) = $0 {
        return token
    }
    return nil
}

print(tokens) // [1, 2]


precedencegroup Composition {
    associativity: right
}
infix operator ..: Composition

func .. <A,B,C> (
    lhs: CasePath<A, B>,
    rhs: CasePath<B, C>
) -> CasePath<A, C> {
    lhs.appending(path: rhs)
}

prefix operator ^
prefix func ^ <Root, Value>(
    _ kp: KeyPath<Root, Value>
) -> (Root) -> Value {
    return { root in root[keyPath: kp] }
}

extension CasePath/*<Root, Value>*/ {
  func appending<AppendedValue>(
    path: CasePath<Value, AppendedValue>
  ) -> CasePath<Root, AppendedValue> {
    CasePath<Root, AppendedValue>(
      extract: { root in
        self.extract(root).flatMap(path.extract)
    },
      embed: { appendedValue in
        self.embed(path.embed(appendedValue))
    })
  }
}



let states2: [LoadState<Authentication>] = [
  .loading,
  .loaded(.success(.authenticated(AccessToken(token: "deadbeef")))),
  .loaded(.failure(NSError(domain: "", code: 1, userInfo: [:]))),
  .loaded(.success(.authenticated(AccessToken(token: "cafed00d")))),
  .loaded(.success(.unauthenticated))
]

//states2
//  .compactMap(^(/LoadState.loaded .. /Result.success .. /Authentication.authenticated))

//states
//    .compactMap(^(/LoadState.loaded .. /Result.success))
