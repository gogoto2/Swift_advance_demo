//: Playground - noun: a place where people can play

import UIKit

var str = "可选值的 flatMap"


/// 函数参数的返回值也是一个数组

let stringNumbers = ["1", "2", "3", "foo"]
let x = stringNumbers.first.map{ Int($0) }
x
type(of: x)

// flatMap 将结果展平为单个可选值
let y = stringNumbers.first.flatMap{ Int($0) }
y
type(of: y)

//let urlString = "http://www.objc.io/logo.png"
//let view = URL(string: urlString)
//    .flatMap { try? Data(contentsOf: $0) }
//    .flatMap { UIImage(data: $0) }
//    .map { UIImageView(image: $0) }
//if let view = view {
//    print("=======")
//}

// 使用 flatMap 过滤 nil

let nilEmpty = stringNumbers.flatMap { Int($0) }
nilEmpty




//infix operator !!
//func !! <T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
//    if let x = wrapped { return x }
//    fatalError(failureText())
//}
//
//
//infix operator !?
//func !?<T: ExpressibleByIntegerLiteral>(wrapped: T?, failureText: @autoclosure () -> String) -> T
//{
//    assert(wrapped != nil, failureText())
//    return wrapped ?? 0
//}
//
//func !?<T: ExpressibleByArrayLiteral>(wrapped: T?, failureText: @autoclosure () -> String) -> T
//{
//    assert(wrapped != nil, failureText())
//    return wrapped ?? []
//}
//
//func !?<T: ExpressibleByStringLiteral>(wrapped: T?, failureText: @autoclosure () -> String) -> T
//{
//    assert(wrapped != nil, failureText)
//    return wrapped ?? ""
//}
//
//func !?(wrapped: ()?, failureText: @autoclosure () -> String) {
//    assert(wrapped != nil, failureText)
//}


