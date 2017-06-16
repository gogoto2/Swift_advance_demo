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


/*:
 * ## Copy on write
 * 1. 集合类型都是通过这种技术实现的
 * 2. 当自己的类型内部含有一个或多个可变引用,同时你要保持值语义,并且避免不必要的复制时, 实现写时复制是有必要的
 */


// isKnownUniquelyReferenced(&<#T##object: AnyObject##AnyObject#>) : 检查引用的唯一性
// 但是对于 OC 的类,会直接返回 false

// 封装任意 OC 的对象到 Swift对象中
final class Box<T> {
    var unbox: T
    init(_ value: T) {
        self.unbox = value
    }
}

var x = Box(NSMutableData())
isKnownUniquelyReferenced(&x)
var y = x
isKnownUniquelyReferenced(&x)



struct Mydata {
    private var data: Box<NSMutableData>
    var dataForWriting: NSMutableData {
       mutating get{
            if !isKnownUniquelyReferenced(&data){
                 data = Box(data.unbox.mutableCopy() as! NSMutableData)
            }
           return data.unbox
        }
    }
    
    init(_ data: NSData) {
        self.data = Box(data.mutableCopy() as! NSMutableData)
    }
}

extension Mydata {
    
    mutating func append(_ other: Mydata){
        dataForWriting.append(other.data.unbox as Data)
    }
}


