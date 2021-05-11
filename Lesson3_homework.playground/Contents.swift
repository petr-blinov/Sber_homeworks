import UIKit

class SomeClass<T> {
    var value: T
    init(_ value: T) {
        self.value = value
    }
}

struct SomeStruct<T> {
    var reference: SomeClass<T>
    init(_ val:T) {
        reference = SomeClass(val)
    }

    var value: T {
        get {
            return reference.value
        }
        set {
            guard isKnownUniquelyReferenced(&reference) else {
                reference = SomeClass(newValue)
                return
        }
            reference.value = newValue
        }
    }
}
