//
//  LiskovSubstitutionPrinciple.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/24.
//

import Foundation

/**
 里氏替换原则
 
 理解：一个对象在其出现的任何地方，都可以用子类实例做替换，并且不会导致程序的错误。换句话说，当子类可以在任意地方替换基类且软件功能不受影响时，这种继承关系的建模才是合理的。

 总结：子类可以扩展父类的方法，但不应该复写父类的方法。

 例子：我们定义汽车的基类，基类里面有行驶的方法，现在我们有个宝马车，宝马车继承汽车基类，也有行驶方法。现在我们想知道宝马车的行驶速度是多少，该怎么设计呢。

 修改之前
 class Car {
     func run() {
         print("汽车跑起来了")
     }
 }
 class BaoMaCar: Car {
     override func run() {
         super.run()
         
         print("当前行驶速度是80Km/h")
     }
 }
 可以看到我们重写了run方法，增加了汽车行驶速度的逻辑，这样是不满足的里氏替换原则的。因为所有基类Car替换成子类BaoMaCar，run方法的行为跟以前不是一模一样了。

 修改之后
 */
class LSPCar {
    func run() {
        print("汽车跑起来了")
    }
}
class BaoMaCar: LSPCar {
    func showSpeed() {
        print("当前行驶速度是80Km/h")
    }
}
