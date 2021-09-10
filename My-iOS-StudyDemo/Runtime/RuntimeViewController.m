//
//  RuntimeViewController.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/4/1.
//

#import "RuntimeViewController.h"
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import <objc/message.h>

/**
 讲一下OC的消息机制
 1、OC中的方法调用其实都是转成了 objc_msgSend 函数的调用，给 receiver （方法调用者）发送一条消息；
 2、objc_msgSend底层有3大阶段：
 1) 消息发送（当前类、父类中找）
 2) 动态解析
 3) 消息转发
 
 iOS APP运行时Crash自动修复系统:
 https://cloud.tencent.com/developer/article/1639841
 */


@interface MessageForwarding : NSObject
@property (weak, nonatomic) NSObject *target;

- (void)implMethod;
- (void)unImplMethod;
- (void)mustHas;

@end

@implementation MessageForwarding

void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@"%@ has added", NSStringFromSelector(_cmd));
}

- (void)implMethod {
    NSLog(@"%s", __FUNCTION__);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"1 -- %s: %@", __FUNCTION__, NSStringFromSelector(sel));
    return [super resolveClassMethod:sel];
}
//+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector {
//
//}
//+ (IMP)instanceMethodForSelector:(SEL)aSelector {
//
//}

// 会执行2次: 如果在forwardingTargetForSelector并未返回能接受该 selector的对象，那么resolveInstanceMethod会再次被触发
// 这一次，如果仍然不添加selector，程序就会报异常
+ (BOOL)resolveInstanceMethod:(SEL)sel { // 1
    NSLog(@"1 -- %s: %@", __FUNCTION__, NSStringFromSelector(sel));
    
    if (sel == @selector(mustHas)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        //YES，那运行时系统就会重新启动一次消息发送的过程
        return YES;//NO !实测效果一样。运行时就会移到下一步，消息转发
    }
    return [super resolveInstanceMethod:sel];//YES/NO 效果一样
}

// Fast forwarding 只要这个方法返回的不是nil和self，整个消息发送的过程就会被重启，当然发送的对象会变成你返回的那个对象。 否则，就会继续Normal Fowarding。这里叫Fast，只是为了区别下一步的转发机制。因为这一步不会创建任何新的对象，但Normal forwarding转发会创建一个NSInvocation对象，相对Normal forwarding转发更快点，所以这里叫Fast forwarding
- (id)forwardingTargetForSelector:(SEL)aSelector { // 2
    NSLog(@"2 -- %s: %@", __FUNCTION__, NSStringFromSelector(aSelector));
    // 将消息转发给一个对象，开销较小，并且被重写的概率较低，适合重写
    // 适合构建装饰器
    // 返回一个能够处理这个消息的对象
//    if (selector == @selector(test)) {
//        return [[OtherClass alloc] init];
//    }
    
    return [super forwardingTargetForSelector:aSelector];// return nil
}

/* Normal forwarding 这一步是Runtime最后一次给你挽救的机会。
 首先它会发送-methodSignatureForSelector:消息获得函数的参数和返回值类型。
 如果-methodSignatureForSelector:返回nil，Runtime则会发出-doesNotRecognizeSelector:消息，程序这时也就挂掉了。
 如果返回了一个函数签名，Runtime就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象
*/
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector { // 3
    NSLog(@"3 -- %s: %@", __FUNCTION__, NSStringFromSelector(aSelector));
    //return [NSObject instanceMethodSignatureForSelector:@selector(init)];
    
    // 要求返回方法签名: 返回 值类型、参数类型
//    if (aSelector == sel_registerName("method")) {
        //v16@0:8：v代表void, 传俩参数16字节, @代表id类型从 0开始, :代表一个 selector 从8开始。有参数的话就是 v@:i
//        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
//    }
    
    return [super methodSignatureForSelector:aSelector];
}
// methodSignatureForSelector 如果返回了方法签名，就会包装成NSInvocation
// (`NSInvocation` 封装了方法调用：方法调用者、方法名、方法参数)
- (void)forwardInvocation:(NSInvocation *)anInvocation { // 4
    NSLog(@"Last -- %s: %@", __FUNCTION__, anInvocation);
    // NSInvocation将消息转发给多个对象，调用开销较大，需要创建新的NSInvocation对象，并且forwardInvocation的函数经常被使用者调用，来做多层消息转发选择机制，不适合多次重写
    // 以后的方法调用者就是 OtherClass 的对象
//    anInvocation.target = [[OtherClass alloc] init];
//    [anInvocation invoke];// 开始调用方法
//    // 第2种写法
//    [anInvocation invokeWithTarget:[[OtherClass alloc] init]];
//    // 获取参数
//    [anInvocation getArgument:NULL atIndex:2];// 这里应该从2开始，才是我们自己传的参数;
    
    [super forwardInvocation:anInvocation];
}

// 触发崩溃
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"崩溃 -- %s: %@", __FUNCTION__, NSStringFromSelector(aSelector));
}

@end

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //NSLog(@"[self class] %@", NSStringFromClass([self class]));
        // 本质是一个编译器标示符，和 self 是指向的同一个消息接受者
        // 而当使用 super时，则从父类的方法列表中开始找。然后调用父类的这个方法
        // 调用 [super class]时，会转化成 objc_msgSendSuper函数
        NSLog(@"[super class] %@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MessageForwarding *mf = [[MessageForwarding alloc] init];
//    [mf mustHas];
    
    NSObject *obj = [[NSObject alloc] init];
    NSLog(@"class对象占用: %zd", class_getInstanceSize([NSObject class]));
    NSLog(@"class对象占用: %zd", class_getInstanceSize([obj class]));
    NSLog(@"class对象占用: %zd", class_getInstanceSize(object_getClass(obj)));
    NSLog(@"obj指针对象占用: %zd", malloc_size((__bridge const void *)obj));
    
    NSLog(@"meta-class对象: %@", object_getClass([NSObject class]));
    NSLog(@"meta-class对象: %@", [[NSObject class] class]);
    NSLog(@"是否meta-class对象: %d", class_isMetaClass([[NSObject class] class]));
    
    // runtime 写法:
//    Person *person = [[Person alloc] init];
    // 方法1：强转函数指针
//     NSString *name = ((NSString *(*)(id,SEL,NSString *)) objc_msgSend)(person, @selector(getName:), @"lee");

//    ((void(*)(id, SEL, id))objc_msgSend)(obj, prop.setterSel, nil);
    //    objc_msgSend(mf, sel_registerName("mustHas"));
    //     id returnValue = objc_msgSend(objc, @selector(functionName), param);
    //    mf = objc_msgSend(mf, sel_registerName("init"));
    // 使用 objc_msgSend(id self, SEL op, ...) 需要设置Build Settings选项 Enable Strict Checking of objc_msgSend Calls = NO
    
//    Class class = objc_getClass("MessageForwarding");
//    SEL sel = sel_registerName("alloc");// 或 @selector(alloc)
//    MessageForwarding *mf1 = objc_msgSend(class, sel);
//    objc_msgSend(mf1, sel_registerName("implMethod"));
    
//    [mf unImplMethod];
//    [mf performSelector:@selector(unImplMethod)];
//    [mf implMethod];
}

//static void _I_Student_test(Student * self, SEL _cmd) {
//    Food *food = ((Food *(*)(id, SEL))(void *)objc_msgSend)((id)((Food *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Food"), sel_registerName("alloc")), sel_registerName("init"));
//    ((NSString *(*)(id, SEL, NSString *))(void *)objc_msgSend)((id)food, sel_registerName("print:"), (NSString *)&__NSConstantStringImpl__var_folders_z1_kqmk71dj0bsfwdf1x1zgwd3h0000gp_T_Student_967bef_mi_1);
//}

@end



