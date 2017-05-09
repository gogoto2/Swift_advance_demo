//: Playground - noun: a place where people can play

import UIKit

var array = "========= Array ========="

var fibs = [0, 1, 1, 2, 3, 5]
fibs.append(8)
fibs.append(contentsOf: [13, 21, 34])

// removeLast -> non optional
// popLast & first & last-> optional

let testArray01 = fibs.map{
    return $0 * $0
}
testArray01

extension Sequence {
    
    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        
        for element in reversed() where predicate(element) {
            
            return element
        }
        
        return nil
    }
}

let names = ["Paula", "Elena", "Zoe"]

let mactch = names.last { $0.hasPrefix("a") }
mactch

let reduce = names.reduce("") { (initial, element) -> String in
    return initial + element
}
reduce

extension Array {
    
    func map2<T>(_ transform: (Element) -> T) -> [T] {
        
        return reduce([]) { (a: [T], element: Element) -> [T] in
             return a + [transform(element)]
        }
    }
}

let n = fibs.map2 { (item) -> Int in
    return item * item
}
n


var slice = "========= Slice ========="

let slice01 = fibs[4..<fibs.endIndex]
type(of: slice01)
let array01 = Array(slice01)
type(of: array01)


var dictionary = "========= Dictionary ========="

enum Setting {
    
    case text(String)
    case int(Int)
    case bool(Bool)
}

let defaultSettings: [String: Setting] = [
    "Mode": .bool(true),
    "Name": .text("roni")
]

let dicValue = defaultSettings["name"]
type(of: dicValue)

var variableSetting = defaultSettings
variableSetting["Name"] = .text("mars")
variableSetting["Mode"] = .bool(false)
variableSetting
defaultSettings

variableSetting.updateValue(.text("devzheng"), forKey: "Name")
variableSetting


extension Dictionary {
    
    /// 字典合并 
    /// arg: 要合并的字典
    mutating func merge<S>(_ other: S) where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
            
            for (k, v) in other {
                
                self[k] = v
            }
        
    }
    
    // 用序列来创建字典
    init<S: Sequence> (_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        
        self = [:]
        self.merge(sequence)
    }
    
    //
    func mapValue<NewValue>(_ transform: (Value) -> NewValue) -> [Key: NewValue] {
        
        return Dictionary<Key, NewValue>(map{ (key, value) in
            return (key, transform(value))
        })
    }
}

let  overrideSettings: [String: Setting] = [
    "Age": .int(25),
    "Name": .text("zwx"),
    "Mode": .bool(true)
]

variableSetting.merge(overrideSettings)
variableSetting
let defaultAlarms = (1..<5).map { (key: "Alarm \($0)", value: false) }
let alarmsDictionary = Dictionary(defaultAlarms)



let hashable = "======== Hashable ========"

// Hashable 本身是对 Equatable 的扩展,因此需要对 == 运算符进行重载
// 由本身就是 Hashable 的数据类型组成的类型来说，将成员的哈希值进行“异或” (XOR) 运算往往是一个不错的起点

let set = "======== Set ========"

// Set comform to ExpressibleByArrayLiteral
let naturals: Set = [1, 2, 3, 2]
naturals // 快速找到 + 避免重复

// 代数

let iPods: Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffle", "iPod classic"]

let discontinuedIPods: Set = ["iPod mini", "iPod classic"]

let currentiPods = iPods.subtracting(discontinuedIPods) // 补集

let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
let iPodsWithTouch = iPods.intersection(touchscreen) // 交集

var discontinued: Set = ["iBooks", "Powerbook", "Power mac"]
discontinued.formUnion(discontinuedIPods) // 并集

extension Sequence where Iterator.Element: Hashable {
    
    func unique() -> [Iterator.Element] {
        
        var seen: Set<Iterator.Element> = []
        
        return filter{ (item) -> Bool in
            if seen.contains(item) {
                return false
            }else {
                seen.insert(item)
                return true
            }
        }
    }
}

[1, 2, 3, 12, 1, 3, 4, 5, 6, 4, 6].unique()







