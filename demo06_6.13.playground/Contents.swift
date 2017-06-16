//: Playground - noun: a place where people can play

import UIKit

var str = "闭包和可变性"

var i = 0

func uniqueInterger() -> Int{
    i += 1
    return i
}


uniqueInterger()
uniqueInterger()
uniqueInterger()

var otherFunction = uniqueInterger
otherFunction()


// 循环引用

class View{
    
    var window: Window
    init(window: Window) {
        self.window = window
    }
    
    deinit {
        print("Deinit View")
    }
}

class Window{
    
    weak var rootView: View?
    deinit {
        print("Deinit Window")
    }
    
    var onRatate:(()->())?
}

var window: Window? = Window()
var view: View? = View(window: window!)
window?.rootView = view!

window?.onRatate = { [weak view] in
    
    print(view ?? "")
}

window = nil
view = nil


