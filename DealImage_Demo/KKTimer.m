//
//  KKTimer.m
//  DealImage_Demo
//
//  Created by CarShare on 2020/1/15.
//  Copyright © 2020 CarShare. All rights reserved.
//

#import "KKTimer.h"

@interface KKTimer ()

@property (nonatomic, strong) NSTimer *kTimer;

@property (nonatomic, assign) float timeNum;

@end


@implementation KKTimer

/// 实例化计时器
/// @param time 倒计时 时间
/// @param delegate 计时target
+ (instancetype)timerCountDownWithTime:(float)time
                              delegate:(id)delegate
                      remindCountBlock:(void (^)(float))remindBlock{
    KKTimer *remindTimer = [[KKTimer alloc] init];
    remindTimer.remindSecond = time;
    remindTimer.timeNum = time;
    remindTimer.delegate = delegate;
    remindTimer.kTimer = [NSTimer scheduledTimerWithTimeInterval:time repeats:false block:^(NSTimer * _Nonnull timer) {
        NSLog(@"---0---");
    }];
    
    return remindTimer;
}
/// 实例化计时器
/// @param time 倒计时 时间
/// @param target 计时target
/// @param delegate 代理对象
+ (instancetype)initTimerCountDownWithTime:(float)time
                                    target:(nonnull id)target
                                  delegate:(nonnull id)delegate{
    KKTimer *remindTimer = [[KKTimer alloc] init];
    remindTimer.remindSecond = time;
    remindTimer.timeNum = time;
    remindTimer.delegate = delegate;
    [remindTimer configTimerRemindTarget:target];
    
    return remindTimer;
}
/// 配置定时器并开始计时
- (void)configTimerRemindTarget: (nonnull id)target {
    _kTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:target selector:@selector(remindTimeCount:) userInfo:nil repeats:false];
}


- (void)remindTimeCount: (NSTimer *)timer {
    _timeNum -= 1;
    if (_timeNum <= 0){
        _timeNum = _remindSecond;
        [self stopRemindTimer];
        _kTimer = nil;
    }
}
/// 停止定时器计时
- (void)stopRemindTimer{
    [_kTimer invalidate];
}
// 响应定时器代理
- (void)respondKTimerDelegate {
    if (_delegate && [_delegate respondsToSelector:@selector(remindTimer:recoundNum:)]){
        [_delegate remindTimer:self recoundNum:_timeNum];
    }
}

@end
