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
         recoundNum:(float)num;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KKTimer : NSObject

// 倒计时 时间
@property (nonatomic, assign) float remindSecond;

// 代理对象
@property (nonatomic, weak) id<KKTimerDelegate> delegate;

/// 实例化计时器
/// @param time 倒计时 时间
/// @param delegate 计时delegate代理对象

+ (instancetype)timerCountDownWithTime:(float)time
                              delegate:(nonnull id)delegate
                      remindCountBlock:(void(^)(float remindTime))remindBlock;

/// 实例化计时器
/// @param time 倒计时 时间
/// @param target 计时target
/// @param delegate 代理对象
+ (instancetype)initTimerCountDownWithTime:(float)time
                                    target:(nonnull id)target
                                  delegate:(nonnull id)delegate;
/// 停止定时器计时
- (void)stopRemindTimer;

@end

NS_ASSUME_NONNULL_END
