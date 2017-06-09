//: Playground - noun: a place where people can play

import UIKit

var str = "Strut and Class"

/*:
 * ## struct and class
 * 1. struct or enum is value semantics, class is reference semantics
 * 2. value semantics has only one owner, reference senmantics can have many owners
 * 3. when a object need specific lifecycle, you should use Class, we can init it, change it, delloc it in lifecycle
 * 4. Immutablility makes code thread safe, becase we can not change what can be safely share between threads
 */

var mutableArray = [1, 2, 3]
for _ in mutableArray {
    
    mutableArray.removeAll()
    
    // removeAll() 执行了三次, for 循环通过迭代器实现, 而迭代器持有的是数组的一个独立的复制,所以 mutableArray 的改变并不会影响循环
    // NSMutableArray 的迭代器是基于原始的数组工作的....所以如果是 NSMutableArray 必然导致 crash
}

mutableArray.withUnsafeBufferPointer { (buffer) -> String in
    return String(describing: buffer.baseAddress)
}

// reference
let mArray: NSMutableArray = [1, 2, 3, 4]
let oArray = mArray
mArray.add(4)
oArray


/*:
 * ## struct
 * 1. 自动按照成员变量添加 initilizer method
 * <#item2#>
 * <#item3#>
 */

struct Point {
    var x: Int
    var y: Int
    
}

extension Point {
    
    static let origin = Point(x: 0, y: 0)
}

struct Size {
    var width: Int
    var height: Int
    
}


struct Rectangle {
    var origin: Point
    var size: Size
    
}
extension Rectangle {
    
    init(x: Int = 0, y: Int = 0, width: Int, height: Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
    
}

var screen  = Rectangle(x: 2, y: 9, width: 20, height: 40){
    
    willSet{
        print("will change")
        
    }
    didSet{
        print(oldValue)
        print(screen)
    }
    
}

screen.size = Size(width: 100, height: 100)

var screens = [screen]{
    didSet{
      print("screens hava changed")
    }
}


screens[0].size = Size(width: 1000, height: 20000)


extension Point{
    
    static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

screen.origin + Point(x: 10, y: 10)

extension Rectangle {
    
    mutating func translate(by offset: Point) {
        
        origin = origin + offset
    }
    
    // 提供一个非 mutating 的版本
    func translated(by offset: Point) -> Rectangle{
        var copy = self
        copy.translate(by: offset)
        return copy
    }
}

screen.translate(by: Point(x: -10, y: -10))
screen.translated(by: Point(x: 10, y: 10))
screen






