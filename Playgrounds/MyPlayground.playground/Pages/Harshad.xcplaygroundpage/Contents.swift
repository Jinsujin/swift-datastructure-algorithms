import Cocoa

var str = "Hello, playground"

print(str)

let x = 18

print( x%10 )
print( x/10 )

func 하샤드검사(_ x: Int) -> Bool {
    var n = x
    var sum = 0
    
    while(n > 0){
        sum += n % 10
        n = n/10
    }
    print(n)
    return (x % sum == 0)
}

print(하샤드검사(x))
