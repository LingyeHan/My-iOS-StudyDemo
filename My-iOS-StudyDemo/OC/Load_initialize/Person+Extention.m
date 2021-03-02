//
//  Person+Extention.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/1.
//

#import "Person+Extention.h"

@implementation Person (Category)

+ (void)load {
    NSLog(@"I am Person+Extention..Load Function!");
}

+ (void)initialize
{
    NSLog(@"I am Person+Extention..initialize Function!");
}

@end



@implementation Student (Category)

+ (void)load {
    NSLog(@"I am Student+Extention..Load Function!");
}

+ (void)initialize
{
    NSLog(@"I am Student+Extention..initialize Function!");
}

@end
