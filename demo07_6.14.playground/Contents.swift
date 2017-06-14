//: Playground - noun: a place where people can play

import UIKit

var str = "函数"

let i = 1
type(of: i)

let myArray = [3, 1, 2]
myArray.sorted()
myArray

var myArray02 = [3, 1, 2]
myArray02.sort()
myArray02

 
final class Person: NSObject {
    @objc var first: String
    @objc var last: String
    @objc var yearOfBirth: Int
    init(first: String, last: String, yearOfBirth: Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOfBirth
    }
}
let people = [
    Person(first: "Jo", last: "Smith", yearOfBirth: 1970),
    Person(first: "Joe", last: "Smith", yearOfBirth: 1970),
    Person(first: "Joe", last: "Smyth", yearOfBirth: 1970),
    Person(first: "Joanne", last: "smith", yearOfBirth: 1985),
    Person(first: "Joanne", last: "smith", yearOfBirth: 1970),
    Person(first: "Robert", last: "Jones", yearOfBirth: 1970),
]

let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last), ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
let firstDescriptor =  NSSortDescriptor(key: #keyPath(Person.first), ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
let yearDescriptor =  NSSortDescriptor(key: #keyPath(Person.yearOfBirth), ascending: true)

let  descriptors = [lastDescriptor, firstDescriptor, yearDescriptor]
(people as NSArray).sortedArray(using: descriptors)
