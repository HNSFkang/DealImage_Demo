//
//  KKTimer.h
//  DealImage_Demo
//
//  Created by CarShare on 2020/1/15.
//  Copyright © 2020 CarShare. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KKTimer;

@protocol KKTimerDelegate <NSObject>
/// 倒计时
/// @param kkTimer 计时器
/// @param num 倒计时数
- (void)remindTimer:(KKTimer *_Nullable)kkTimer
         recoundNum:(NSTimeInterval)num;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KKTimer : NSObject

// 倒计时 总时间
@property (nonatomic, assign) NSTimeInterval totalTime;
// 倒计时 时间间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;

// 代理对象
@property (nonatomic, weak) id<KKTimerDelegate> delegate;

/// 实例化计时器
/// @param totalTime 倒计时 总时间
/// @param time 倒计时时间间隔
/// @param remindBlock 倒计时时间回调
+ (instancetype)timerWithTotalTime:(NSTimeInterval)totalTime
                      timeInterval:(NSTimeInterval)time
                      remindCountBlock:(void (^)(NSTimeInterval num))remindBlock;

/// 实例化计时器
/// @param totalTime 倒计时 时间
/// @param time 计时器时间间隔
/// @param delegate 代理对象
- (instancetype)initTimerWithTotalTime:(NSTimeInterval)totalTime
                          timeInterval:(NSTimeInterval)time
                              delegate:(nonnull id)delegate;
/// 停止定时器计时
- (void)stopRemindTimer;

@end

NS_ASSUME_NONNULL_END
