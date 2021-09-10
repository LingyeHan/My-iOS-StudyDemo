//
//  RunLoopViewController.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/3/29.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *autoreleaseStr;
@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 主线程中打印的mainRunLoop, currentRunLoop内存地址是相同的
    // Core Foundation (CGRunLoop 线程安全)
    NSLog(@"CFRunLoop: %p ---- %p", CFRunLoopGetCurrent(), CFRunLoopGetMain());
    // Foundation (NSRunLoop 不线程安全)
    NSLog(@"NSRunLoop: %p ---- %p", [NSRunLoop currentRunLoop], [NSRunLoop mainRunLoop]);
    
    // 创建一个子线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
    
    [self testObjDealloc];
    
    NSString *temp = @"hello";
    @autoreleasepool {
        //self.autoreleaseStr = temp;
        NSLog(@"autoreleasepool viewDidLoad: %@", temp);
    }
    NSLog(@"autoreleasepool viewDidLoad: %@", temp);
}

- (void)dealloc {
    NSLog(@"autoreleasepool dealloc: %@", _autoreleaseStr);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"autoreleasepool viewDidAppear: %@", _autoreleaseStr);
}

// 开启的子线程默认是没有runloop的
// 手动创建runloop对象, [NSRunLoop currentRunLoop]创建, 懒加载的创建方法,第一次访问创建,以后就不会创建了
- (void)run
{
    NSRunLoop *currentLoop = [NSRunLoop currentRunLoop];
    NSLog(@"Thread -- %p", currentLoop); //打印的内存地址和主线程的不同
}

- (void)testObjDealloc {
    NSArray *tmpArray = self.array;
    self.array = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        //[tmpArray class];
        NSLog(@"tmpArray: %@", [tmpArray class]);
    });
}

@end
