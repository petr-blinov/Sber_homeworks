import UIKit


// MARK: 1. Abstract Factory

// Абстрактная фабрика - порождающий паттерн проектирования, который позволяет создавать связанные объекты, не привязываеясь к конкретным классам


// Создаем протоколы продуктов
protocol Sofa {
    var name: String {get}
    var description: String {get}
}
protocol Armchiar {
    var name: String {get}
    var description: String {get}
}
protocol Table {
    var name: String {get}
    var description: String {get}
}

// Семейство Classic
class SofaClassicStyle: Sofa {
    var name: String = "Диван"
    var description: String = "Диван, классический стиль"
}
class ArmchiarClassicStyle: Armchiar {
    var name: String = "Кресло"
    var description: String = "Кресло в классическом стиле"
}
class TableClassicStyle: Table {
    var name: String = "Стол"
    var description: String = "Стол в классическом стиле"
}

//  Семейство Retro
class SofaRetroStyle: Sofa {
    var name: String = "Диван"
    var description: String = "Диван, ретро стиль"
}
class ArmchiarRetroStyle: Armchiar {
    var name: String = "Кресло"
    var description: String = "Кресло в стиле ретро"
}
class TableRetroStyle: Table {
    var name: String = "Стол"
    var description: String = "Стол в стиле ретро"
}

//  Семейство Modern
class SofaModernStyle: Sofa {
    var name: String = "Диван"
    var description: String = "Диван в современном стиле"
}
class ArmchiarModernStyle: Armchiar {
    var name: String = "Кресло"
    var description: String = "Кресло в современном стиле"
}
class TableModernStyle: Table {
    var name: String = "Стол"
    var description: String = "Стол в современном стиле"
}

// Создаем протокол абстрактной фабрики
protocol AbstractFactory {
    func createSofa() -> Sofa
    func createArmchair() -> Armchiar
    func createTable() -> Table
}

// Создаем фабрики семейств
class ClassicFactory: AbstractFactory {
    func createSofa() -> Sofa {
        print("Произведен диван в классическом стиле")
        return SofaClassicStyle()
    }
    func createArmchair() -> Armchiar {
        print("Произведено кресло в классическом стиле")
        return ArmchiarClassicStyle()
    }
    func createTable() -> Table {
        print("Произведен стол в классическом стиле")
        return TableClassicStyle()
    }
}
class RetroFactory: AbstractFactory {
    func createSofa() -> Sofa {
        print("Произведен диван в ретро стиле")
        return SofaRetroStyle()
    }
    func createArmchair() -> Armchiar {
        print("Произведено кресло в ретро стиле")
        return ArmchiarRetroStyle()
    }
    func createTable() -> Table {
        print("Произведен стол в ретро стиле")
        return TableRetroStyle()
    }
}
class ModernFactory: AbstractFactory {
    func createSofa() -> Sofa {
        print("Произведен диван в современном стиле")
        return SofaModernStyle()
    }
    func createArmchair() -> Armchiar {
        print("Произведено кресло в современном стиле")
        return ArmchiarModernStyle()
    }
    func createTable() -> Table {
        print("Произведен стол в современном стиле")
        return TableModernStyle()
    }
}

var modernSofa = ModernFactory().createSofa()
var modernArmchair = ModernFactory().createArmchair()
var modernTable = ModernFactory().createTable()




// MARK: 2. Builder

// Строитель - порождающий паттерн проектирования, который позволяет создавать сложные объекты пошагово

class Pizza {
    
    var pizzaBase: String = ""
    var sause: String = ""
    var cheese: String = ""
    var groundBeef: String = ""
    var chicken: String = ""
    var ham: String = ""
    var mushrooms: String = ""
    var olives: String = ""
    var onions: String = ""
    var peppers: String = ""
    var pepperoni: String = ""
    var basil: String = ""
    var salami: String = ""
    var sausage: String = ""
    var tomatoes: String = ""
}

class PizzaMaker {
    
    enum pizzaTypes {
        case margarita
        case mushroomsPizza
        case chickenPizza
        case pepperoniPizza
        case beefPizza
    }
    
    func makePizza(ofType: pizzaTypes) -> Pizza {
        let pizza = Pizza()
        
        switch ofType {
        
        case .margarita:
            pizza.pizzaBase = "Берем основу для пиццы"
            pizza.sause = "Наносим соус на основу"
            pizza.cheese = "Добавляем сыр"
            pizza.basil = "Добавляем базилик"

        case .mushroomsPizza:
            pizza.pizzaBase = "Берем основу для пиццы"
            pizza.sause = "Наносим соус на основу"
            pizza.cheese = "Добавляем сыр"
            pizza.mushrooms = "Добавляем грибы"
            pizza.onions = "Добавляем лук"

        case .chickenPizza:
            pizza.pizzaBase = "Берем основу для пиццы"
            pizza.sause = "Наносим соус на основу"
            pizza.cheese = "Добавляем сыр"
            pizza.chicken = "Добавляем курицу"
            pizza.tomatoes = "Добавляем помидорку"
            
        case .pepperoniPizza:
            pizza.pizzaBase = "Берем основу для пиццы"
            pizza.sause = "Наносим соус на основу"
            pizza.cheese = "Добавляем сыр"
            pizza.pepperoni = "Добавляем пепперони"
            
        case .beefPizza:
            pizza.pizzaBase = "Берем основу для пиццы"
            pizza.sause = "Наносим соус на основу"
            pizza.cheese = "Добавляем сыр"
            pizza.groundBeef = "Добавляем говяжий фарш"
            pizza.onions = "Добавляем лук"
            pizza.peppers = "Добавляем острый перец"
            pizza.olives = "Добавляем оливки"
        }
        return pizza
    }
}

let pizzaMaker = PizzaMaker()

let margaritaPizza = pizzaMaker.makePizza(ofType: .margarita)
let mushroomsPizza = pizzaMaker.makePizza(ofType: .mushroomsPizza)
let beefPizza = pizzaMaker.makePizza(ofType: .beefPizza)

