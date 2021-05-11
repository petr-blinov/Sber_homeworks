import UIKit

// Домашнее задание к лекции 5. Виды Method dispatch



// MARK: Direct dispatch

struct NumbersForDirect {
    
    let firstNumber: Double
    let secondNumber: Double
    
    func sum() -> Double {
        return firstNumber + secondNumber
    }
}
let twoNumbersDirect = NumbersForDirect(firstNumber: 4, secondNumber: 2.5)
twoNumbersDirect.sum()



// MARK: Witness Table dispatch

protocol Summable {
    func sum() -> Double
}
struct NumbersForWitness: Summable {
    
    let firstNumber: Double
    let secondNumber: Double
    
    func sum() -> Double {
        return firstNumber + secondNumber
    }
}
let twoNumbersWitness: Summable = NumbersForWitness(firstNumber: 5, secondNumber: 3.5) // принудительно кастим структуру к протоколу
twoNumbersWitness.sum()



// MARK: Virtual Table dispatch

class RectangleForVirtualTable {
    
    var width: Double
    var height: Double
    
    init (width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    func calculateArea() -> Double {
        return width * height
    }
}

let rectangleForVirtualTable = RectangleForVirtualTable(width: 3, height: 4)
rectangleForVirtualTable.calculateArea()



// MARK: Message dispatch

class RectangleForMessageDispatch: NSObject {
    
    @objc dynamic var width: Double
    @objc dynamic var height: Double
    
    @objc(initWithWidth::) dynamic init (width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    @objc dynamic func calculateArea() -> NSNumber {
        return NSNumber(floatLiteral: width * height)
    }
}

let rectangleForMessageDispatch  = RectangleForMessageDispatch(width: 5, height: 6)
rectangleForMessageDispatch.calculateArea()

