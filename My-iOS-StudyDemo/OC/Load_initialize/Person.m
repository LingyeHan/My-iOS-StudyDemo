//
//  Person.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/1.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@implementation Person

// load调用时机比较早,当load调用时,其他类可能还没加载完成,运行环境不安全.
// load方法是线程安全的，它内部使用了锁，所以我们应该避免线程阻塞在load方法中
+ (void)load {
    @autoreleasepool {
        NSLog(@"I am %@..Load Function!", [self class]);
    }
}

// initialize方法主要用来对一些不方便在编译期初始化的对象进行赋值。
// 比如NSMutableArray这种类型的实例化依赖于runtime的消息发送，所以显然无法在编译器初始化
// static int someNumber = 0;
// static NSMutableArray *someArray;
+ (void)initialize
{
    NSLog(@"Person..initialize!");
    // 防止子类未实现initialize()导致父类initialize中代码多次执行
    if (self == [Person class]) {
        NSLog(@"I am %@..initialize only once Function!", [self class]);
    }
    
    // 不方便编译期复制的对象在这里赋值
//    someArray = [[NSMutableArray alloc] init];
}

- (void)personSay {
    NSLog(@"I am a Person");
}

@end
