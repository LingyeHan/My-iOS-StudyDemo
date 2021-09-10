//
//  Algorithm.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/4/21.
//

#import "Algorithm.h"
#import "Sort.h"
@interface NSObject (Sark)
//+ (void)foo;
//- (void)foo;
@end

@implementation NSObject (Sark)
- (void)foo {
    NSLog(@"IMP: -[NSObject (Sark) foo]");
}
@end


@implementation Algorithm

- (void)run {
    Sort *sort = [[Sort alloc] init];
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@7, @3, @1, @9, @5]];
    NSLog(@"待排序数组: [%@]", [array componentsJoinedByString:@", "]);
//    [sort bubbleSort:array];
//    [sort quickSort:array left:0 right:(int)array.count-1];
//    NSLog(@"快速排序: [%@]", [array componentsJoinedByString:@", "]);
//    [sort selectionSort:array];
//    NSLog(@"选择排序: [%@]", [array componentsJoinedByString:@", "]);
    
//    [sort heapSort:array]; // 难点
//    NSLog(@"堆排序: [%@]", [array componentsJoinedByString:@", "]);
    
    [sort insertionSort:array];
    NSLog(@"插入排序: [%@]", [array componentsJoinedByString:@", "]);
    
    // 测试代码
    [NSObject foo];
//    [[NSObject new] performSelector:@selector(foo)];
}

@end
