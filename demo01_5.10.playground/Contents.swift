//: Playground - noun: a place where people can play

import UIKit

let title = "======== 集合类型协议 ========"


let sequence = "======== Sequence ========"

// 满足 Sequence 协议 => 提供一个返回 iterator 的 makeIterator() 方法

let iterator = "======== Iterator ========"
// Iterator => 1. 知道序列元素的类型 2. 提供访问下一个元素的方法 next() which is the only method that IteratorProtocol has. ps: 'next()' will return nil when sequence exhausted

// in swift, for 循环是 while　模拟的

let sequenceExample = [1, 2, 3, 4, 5]
var iteratorForSE = sequenceExample.makeIterator()
while let ele = iteratorForSE.next() {
    print("\(ele)====")
}


struct ConstantIterator: IteratorProtocol {
    
    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
}

var constantIterator = ConstantIterator()
var y = 0
while let x = constantIterator.next(),  y < 10 {
    print("\(x) ====")
    y += 1
}

// Fibonacci
struct FibsIterator: IteratorProtocol {
    
    typealias Element = Int
    var state = (0, 1)
    
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}
var fibsIterator = FibsIterator()
while let x = fibsIterator.next(), x < 20{
    print("\(x) +++++++")
}

// return all prefixs of string
struct PrefixIterator: IteratorProtocol {
    typealias Element = String
    
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        
        offset = string.startIndex
    }
    
    mutating func next() -> String? {
        guard offset < string.endIndex else {
            return nil
        }
        
        offset = string.index(after: offset)
        return string[string.startIndex..<offset]
    }
    
}

struct PrefixSequence: Sequence {
    
    let string: String
    
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

for prefix in PrefixSequence(string: "Hello") {
    print(prefix)
}

var prefixIte = PrefixSequence(string: "Hello").makeIterator()
while let item = prefixIte.next() {
    print("====\(item)")
}

// 值语义的迭代器
let seq = stride(from: 0, to: 10, by: 1)
var exm01 = seq.makeIterator()
exm01.next()
exm01.next()
var exm02 = exm01
exm01.next()
exm01.next()
// exm03 和 exm04 的结果一样...他们已经不是同一个迭代器了
exm02.next()
exm02.next()

// 引用语义的迭代器
var exm03 = AnyIterator(exm01)
exm03.next()
var exm04 = exm03
exm04.next()
exm03.next()
// exm03 和 exm04 是封装在AnyIterator中的 exm01 的引用,,是同一个迭代器
exm04.next()




