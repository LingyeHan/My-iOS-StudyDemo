//
//  Sort.h
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sort : NSObject

- (void)bubbleSort:(NSMutableArray *)array;

- (void)selectionSort:(NSMutableArray *)array;

- (void)quickSort:(NSMutableArray *)array left:(int)left right:(int)right;

- (void)heapSort:(NSMutableArray *)array;

- (void)insertionSort:(NSMutableArray *)array;

@end

NS_ASSUME_NONNULL_END
