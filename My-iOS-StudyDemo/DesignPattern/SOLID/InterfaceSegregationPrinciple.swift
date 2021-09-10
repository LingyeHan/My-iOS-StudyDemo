//
//  InterfaceSegregationPrinciple.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/24.
//

import Foundation

/**
 接口隔离原则
 
 理解：一个类实现的接口中，包含了它不需要的方法。将接口拆分成更小和更具体的接口，有助于解耦，从而更容易重构、更改。

 总结：对象不应被强迫依赖它不使用的方法。

 例子：我们定义一个汽车接口，要求实现run等方法。

 修改之前
 protocol ICar {
     func run()
     func showSpeed()
     func playMusic()
 }
 class Car: ICar {
     func run() {
         print("汽车跑起来了")
     }
     
     func showSpeed() {
         print("当前行驶速度是80Km/h")
     }
     
     func playMusic() {
         print("播放音乐")
     }
 }
 
 可以看到我们定义Car实现了ICar的接口，但是并不是每个车都有播放音乐的功能的，这样对于一般的低端车没有这个功能，对于他们来说，这个接口的设计就是冗余的。
 接口隔离原则的要求我们，建立单一接口，不要建立庞大臃肿的接口，尽量细化接口，接口中的方法尽量少。这通过分散定义多个接口，可以预防外来变更的扩散，提高系统的灵活性和可维护性。
 
 修改之后
 */
protocol IProfessionalCar {
    //具备一般功能的车
    func run()
    func showSpeed()
}
protocol IEntertainingCar {
    //具备娱乐功能的车
    func run()
    func showSpeed()
    func playMusic()
}
class SangTaNaCar: IProfessionalCar {
    //桑塔纳轿车
    func run() {
        print("汽车跑起来了")
    }
    
    func showSpeed() {
        print("当前行驶速度是80Km/h")
    }
}
class BaoMaX3Car: IEntertainingCar {
    //宝马轿车
    func run() {
        print("汽车跑起来了")
    }
    
    func showSpeed() {
        print("当前行驶速度是80Km/h")
    }
    
    func playMusic() {
        print("播放音乐")
    }
}
