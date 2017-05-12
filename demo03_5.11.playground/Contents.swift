//: Playground - noun: a place where people can play

import UIKit

var str = "可选值"

var characters: [Character] = ["a", "b", "c"]
//var firstChar = characters.first.map{ String($0) }
//
//
//// 打印变量地址
//withUnsafePointer(to: &firstChar) {
//    print("the address of \(firstChar) is : \($0)")
//}

var chars2 = characters

//var a = characters
//var b = chars2[0]

//withUnsafePointer(to: &characters) {
//    print("the address of  is : \($0)")
//}
//withUnsafePointer(to: &chars2) {
//    print("the address of  is : \($0)")
//}
//
//characters.withUnsafeBufferPointer()
//
//Array

//let ptr = UnsafeMutableBufferPointer<Int>(start: &test1, count: test1.count)
//print(ptr.baseAddress)
//
//let ptr02 = UnsafeMutableBufferPointer<Int>(start: &test2, count: test2.count)
//print(ptr02.baseAddress)
//
//let at1 = String(format: "%p", test1)
//let at2 = String(format: "%p", test2)

var test1 = [1, 2, 3]

var test2 = test1

// 获取变量地址
func address(_ p: UnsafePointer<Void>) -> String {
    
    let addr = unsafeBitCast(p, to: Int.self)
    return String(format: "%p", addr)
}

// 获取变量地址
func getBufferAddress<T>(_ array: [T]) -> String {
    
    return array.withUnsafeBufferPointer{ (buffer) in
        return String(describing: buffer.baseAddress)
    }
}
func getStringAddress(_ string: String) -> String {
    
    return String(format: "%p", string)
}

address(test1)
address(test2)

getBufferAddress(test1)

getBufferAddress(test2)

test2[0] = 3

getStringAddress(str)


address(test1)
address(test2)


getBufferAddress(test1)

getBufferAddress(test2)



