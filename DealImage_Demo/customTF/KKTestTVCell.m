//
//  KKTestTVCell.m
//  DealImage_Demo
//
//  Created by CarShare on 2020/1/21.
//  Copyright © 2020 CarShare. All rights reserved.
//

#import "KKTestTVCell.h"

#import "KKCustomTV.h"

@interface KKTestTVCell () <UITextViewDelegate>

@end

@implementation KKTestTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    // 即将编辑时 把这个当做 点击 响应使用代理或者block 传出去
    
    //返回false 切断 tv 的编辑响应 阻止键盘弹出、tv变成第一响应者
    return  false;
}

- (KKCustomTV *)tv{
    if (!_tv){
        _tv = [[KKCustomTV alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        _tv.backgroundColor = [UIColor cyanColor];
        _tv.delegate = self;
    }
    return _tv;
}


@end
