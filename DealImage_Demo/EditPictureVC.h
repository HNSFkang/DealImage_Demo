//
//  EditPictureVC.h
//  DealImage_Demo
//
//  Created by CarShare on 2018/10/15.
//  Copyright © 2018年 CarShare. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EditImageResult)(UIImage *resultImage);

@interface EditPictureVC : UIViewController

@property (nonatomic, copy) EditImageResult imageResult;

@end

NS_ASSUME_NONNULL_END
