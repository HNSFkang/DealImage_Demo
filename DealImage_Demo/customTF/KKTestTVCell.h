//
//  KKTestTVCell.h
//  DealImage_Demo
//
//  Created by CarShare on 2020/1/21.
//  Copyright © 2020 CarShare. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKCustomTV;

NS_ASSUME_NONNULL_BEGIN

typedef void(^TVActionBlock)(NSInteger index);

@interface KKTestTVCell : UITableViewCell

@property (nonatomic, strong) KKCustomTV *tv;

@end

NS_ASSUME_NONNULL_END
