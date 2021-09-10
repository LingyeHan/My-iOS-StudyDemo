//
//  DependenceInversionPrinciple.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/24.
//

import Foundation

/**
依赖倒置原则

理解：高层模块不应该依赖低层模块，二者都应该依赖其抽象；抽象不应该依赖细节；细节应该依赖抽象。
总结：面向接口编程，提取出事务的本质和共性。
 
例子：我们给汽车加油，实现能够加90号的汽油，如果没有，就加93号的汽油。
修改之前
class Car {
    func refuel(_ gaso: Gasoline90) {
        print("加90号汽油")
    }
    
    func refuel(_ gaso: Gasoline93) {
        print("加93号汽油")
    }
}
class Gasoline90 {
    
}
class Gasoline93 {
    
}
上面这段代码有什么问题，可以看到Car高层模块依赖了底层模块Gasoline90和Gasoline93，这样写是不符合依赖倒置原则的
修改之后
class Car {
    func refuel(_ gaso: IGasoline) {
        print("加\(gaso.name)汽油")
    }
}
protocol IGasoline {
    var name: String { get }
}
class Gasoline90: IGasoline {
    var name: String = "90号"
}
class Gasoline93: IGasoline {
    var name: String = "93号"
}

修改之后我们高层模块Car依赖了抽象IGasoline
底层模块Gasoline90和Gasoline93也依赖了抽象IGasoline
这种设计是符合依赖倒置原则的。
 */

/**
迪米特法则 (Law Of Demeter)
 
理解：一个对象对另一个对象了解得越多，那么，它们之间的耦合性也就越强，当修改其中一个对象时，对另一个对象造成的影响也就越大。
总结：一个对象应该对其他对象保持最少的了解，实现低耦合、高内聚。

例子：实现一个给汽车加油的设计，使的我们可以随时保证加油的质量过关。
修改之前
*/
protocol IGasoline {
    var name: String { get }
    var isQuality: Bool { get }
}

class Gasoline90: IGasoline {
    var name: String = "90号"
    var isQuality: Bool = false
}
class Gasoline93: IGasoline {
    var name: String = "93号"
    var isQuality: Bool = true
}

class DICar {
    func refuel(_ gaso: IGasoline) {
        print("加\(gaso.name)汽油")
    }
}

class Person {
    var car: DICar?
    
    func refuel(_ gaso: IGasoline) {
        if gaso.isQuality == true {
            //如果汽油质量过关，我们就给汽车加油
            car?.refuel(gaso)
        }
    }
}
/*
可以看到上面有个问题，我们怎么知道汽油的质量是否过关呢，即时我们知道，加油判断油的质量这个事情也不应该由我们来做。

修改之后
*/
class LODPerson {
    //给车加油的人
    var car: DICar?
    
    func refuel(_ worker: WorkerInPetrolStation, _ gaso: IGasoline) {
        guard let car = car else { return }
        
        worker.refuel(car, gaso)
    }
}
class WorkerInPetrolStation {
    //加油站工作人员
    func refuel(_ car: DICar, _ gaso: IGasoline) {
        if gaso.isQuality == true {
            //如果汽油质量过关，我们就给汽车加油
            car.refuel(gaso)
        }
    }
}
/*
 可以看到这样我们就实现了低耦合，我们只需要知道有加油站工作人员和要加的汽油就行了，不需要知道太多汽油相关的知识，以及加油相关的操作流程，这些都交给了工作人员，这样是符合我们的迪米特原则的。
 */

/**
组合/聚合复用原则 (Composite/Aggregate Reuse Principle)CARP
 
理解：合成/聚合复用原则就是在一个新的对象里面使用一些已有的对象，使之成为新对象的一部分；
新的对象通过向这些对象的委派达到复用已有功能的目的。
它的设计原则是：要尽量使用合成/聚合，尽量不要使用继承。
总结：就是说要少用继承，多用合成关系来实现。

继承复用有一定的缺点：比如如果基类发生了改变，那么派生类的的实现就不得不发生改变；而且从超类继承而来的实现是静态的，不可能在运行时发生改变，因此它的灵活性差并最终会限制复用性。

使用组合/聚合复用原则就解决了继承复用的缺点。
*/
