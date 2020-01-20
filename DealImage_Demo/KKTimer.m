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

@property (nonatomic, assign) NSTimeInterval timeNum;

@end


@implementation KKTimer

/// 实例化计时器
/// @param totalTime 倒计时 总时间
/// @param time 倒计时时间间隔
/// @param remindBlock 倒计时时间回调
+ (instancetype)timerWithTotalTime:(NSTimeInterval)totalTime
                      timeInterval:(NSTimeInterval)time
                      remindCountBlock:(void (^)(NSTimeInterval num))remindBlock{
    KKTimer *remindTimer = [[KKTimer alloc] init];
    remindTimer.totalTime = totalTime;
    remindTimer.timeNum = totalTime;
    remindTimer.timeInterval = time;
    
    __weak typeof(remindTimer) weakKKTimer = remindTimer;
    remindTimer.kTimer = [NSTimer scheduledTimerWithTimeInterval:time repeats:true block:^(NSTimer * _Nonnull timer) {
        [weakKKTimer remindTimeCount:nil];
        remindBlock(remindTimer.timeNum);
    }];
    
    return remindTimer;
}
/// 实例化计时器
/// @param totalTime 倒计时 时间
/// @param time 计时器时间间隔
/// @param delegate 代理对象
- (instancetype)initTimerWithTotalTime:(NSTimeInterval)totalTime
                          timeInterval:(NSTimeInterval)time
                              delegate:(nonnull id)delegate{
    
    KKTimer *remindTimer = [[KKTimer alloc] init];
    remindTimer.totalTime = totalTime;
    remindTimer.timeNum = totalTime;
    remindTimer.timeInterval = time;
    remindTimer.delegate = delegate;
    [remindTimer configTimerRemind];
    
    return remindTimer;
}
/// 配置定时器并开始计时
- (void)configTimerRemind {
    _kTimer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(remindTimeCount:) userInfo:nil repeats:true];
}


- (void)remindTimeCount: (NSTimer *)timer {
    _timeNum -= 1;
    if (_timeNum <= 0){
        _timeNum = _totalTime;
        [self stopRemindTimer];
        _kTimer = nil;
    }
    NSLog(@"%f== reduce num",_timeNum);
    [self respondKTimerDelegate];
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
