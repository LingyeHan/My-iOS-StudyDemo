//
//  SingleResponsibilityPrinciple.swift
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/24.
//

import Foundation

/**
 单一职责原则
 
 理解：不同的类具备不同的职责，各司其职。做系统设计是，如果发现有一个类拥有了两种职责，那么就要问一个问题：可以将这个类分成两个类吗？如果真的有必要，那就分开，千万不要让一个类干的事情太多。

 总结：一个类只承担一个职责

 例子：我们设计一个订单列表，列表分为待支付、待收货、已收货等列表，那我们是写一个类，使用if判断是哪个类型，然后请求相应的数据，还是写多个类，分别执行各自的功能呢。很多人会觉的写一个类比较省事，但是过多的判断条件，各种职责冗余到一个类中真的好吗，如果待支付列表需要加一些特殊的功能呢，待收货也需要加一些功能呢，那这个类是不是变得条件判断异常的多。所以还是写成多个类，实现各自的逻辑比较好。其实另外我们写列表的Cell，也是一个道理，分成几种类型的Cell去写，而不是一个Cell实现几种类型。
 */

//订单列表
class OrderList: NSObject {
    //待支付
    var waitPayList: WaitPayList?
    //待收货
    var waitGoodsList: WaitGoodsList?
    //已收货
    var receivedGoodsList: ReceivedGoodsList?
}
class WaitPayList: NSObject {
    
}
class WaitGoodsList: NSObject {
    
}
class ReceivedGoodsList: NSObject {
    
}
