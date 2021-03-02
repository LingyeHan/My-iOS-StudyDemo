//
//  Student.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/1.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import <objc/runtime.h>

@implementation Student

+ (void)load {
    NSLog(@"I am Student..Load Function!");
    //实现personSay与studentSay方法的交换
    Method personMethod = class_getInstanceMethod([Person class], NSSelectorFromString(@"personSay"));
    Method studentMethod = class_getInstanceMethod([Student class], NSSelectorFromString(@"studentSay"));
    
    method_exchangeImplementations(personMethod, studentMethod);
}

+ (void)initialize
{
    NSLog(@"I am %@..%s Function!", [self class], __FUNCTION__);
    if (self == [Person class]) {

    }
}

- (void)studentSay { NSLog(@"I am a Student"); }

@end
