//
//  LCWeakProxyViewController.m
//  LCKit_Example
//
//  Created by lattecat on 2020/3/12.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCWeakProxyViewController.h"
#import <LCKit/LCWeakProxy.h>

@interface LCWeakProxyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *normalTimerBtn;
@property (weak, nonatomic) IBOutlet UIButton *weakProxyTimerBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopTimerBtn;

@property (nonatomic, strong) NSTimer                  *timer;

@end

@implementation LCWeakProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)normalTimerStart:(id)sender {
    self.stopTimerBtn.enabled = YES;
    self.weakProxyTimerBtn.enabled = NO;
    
    // 会有循环引用问题，(VC -> timer, timer -> VC，这两个造成了循环引用), RunLoop 引用 Timerr
    self.timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (IBAction)weakProxyTimerStart:(id)sender {
    self.stopTimerBtn.enabled = YES;
    self.normalTimerBtn.enabled = NO;
    
    // 不会有循环引用问题，(VC -> timer, timer -> proxy, proxy 弱-> VC，因为弱引用的存在，没有形成循环引用), RunLoop 引用 Timer
    LCWeakProxy *proxy = [LCWeakProxy weakProxyWithTarget:self];
    self.timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:2.0 target:proxy selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (IBAction)stopTimer:(id)sender {
    self.stopTimerBtn.enabled = NO;
    self.normalTimerBtn.enabled = YES;
    self.weakProxyTimerBtn.enabled = YES;
    
    // 使 RunLoop 对 Timer 的引用断开
    [self.timer invalidate];
    
//    // 普通 timer 如果手动设置为 nil，控制器也会执行 dealloc 方法
//    self.timer = nil;
}

- (void)timerAction {
    NSLog(@"Nice to meet you ^_^");
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    
    // 普通的 Timer 如果不手动设置为 nil，那么不会进入 dealloc 方法
    // 使 RunLoop 对 Timer 的引用断开
    [self.timer invalidate];
}

@end
