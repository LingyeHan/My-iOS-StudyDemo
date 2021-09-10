//
//  GCDViewController.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/4/8.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    DispatchQueue.main.async {
//        // crash 线程卡死，当前线程会导致死锁
//        DispatchQueue.main.sync {
//            print("a123")
//        }
//        print("a456") //1
//    }
    
//    [self group_sync_n_async];
//
    [self barrier_async_insert_middle_task];
//    [self barrier_sync];
}

/*
 如何用GCD同步若干个异步调用？
 如: 根据若干个url异步加载多张图片，然后在都下载完成后合成一张整图
 */
- (void)group_sync_n_async {
    // 创建队列组
    dispatch_group_t group =  dispatch_group_create();
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // 往队列组中添加耗时操作
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行耗时的异步操作 1");
        sleep(2);
    });
    // 往队列组中添加耗时操作
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行耗时的异步操作 2");
        sleep(1);
    });

    // 当并发队列组中的任务执行完毕后才会执行这里的代码
    dispatch_group_notify(group, queue, ^{
        // 如果这里还有基于上面两个任务的结果继续执行一些代码，建议还是放到子线程中，等代码执行完毕后在回到主线程

        // 回到主线程
        dispatch_group_async(group, dispatch_get_main_queue(), ^{
            // 执行相关代码...
            NSLog(@"回到主线程执行相关代码...");
        });
    });
}

/*
 并行的任务中插入中间任务
 barrier_async会将queue中barrier前面添加的任务block只添加不执行,继续添加barrier的block,再添加barrier后面的block,同时不影响主线程(或者操作添加任务的线程)中代码的执行!
 */
- (void)barrier_async_insert_middle_task {
    dispatch_queue_t queue = dispatch_queue_create("barrier_async.test", DISPATCH_QUEUE_CONCURRENT);//这个函数的第一个参数queue不能是全局的并发队列

    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    NSLog(@"before");
    // 在它前面的任务执行结束后它才执行，在它后面的任务等它执行完成后才会执行
    // 异步派发
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier_async-----%@", [NSThread currentThread]);
    });
    NSLog(@"after");
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}
/*
 barrier_sync会将queue中barrier前面添加的任务block全部执行后,再执行barrier任务的block,再执行barrier后面添加的任务block
 */
- (void)barrier_sync {
    dispatch_queue_t queue = dispatch_queue_create("barrier_sync.test", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            sleep(3);
            NSLog(@"test1");
        });
        dispatch_async(queue, ^{
            NSLog(@"test2");
        });
        dispatch_sync(queue, ^{
            NSLog(@"test3");
        });
        // 同步派发
        dispatch_barrier_sync(queue, ^{
            sleep(1);
            for (int i = 0; i<50; i++) {
                if (i == 10 ) {
                    NSLog(@"barrier_sync1");
                }else if(i == 20){
                    NSLog(@"barrier_sync2");
                }else if(i == 40){
                    NSLog(@"barrier_sync3");
                }
            }
        });
        NSLog(@"before");
        dispatch_async(queue, ^{
            NSLog(@"test4");
        });
        NSLog(@"after");
        dispatch_async(queue, ^{
            NSLog(@"test5");
        });
        dispatch_async(queue, ^{
            NSLog(@"test6");
        });
  
}

@end
