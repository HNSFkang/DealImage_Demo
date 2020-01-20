//
//  ViewController.m
//  DealImage_Demo
//
//  Created by CarShare on 2018/10/15.
//  Copyright © 2018年 CarShare. All rights reserved.
//

#import "ViewController.h"

#import "EditPictureVC.h"

#import "KKTimer.h"

@interface ViewController () <KKTimerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *resultImageV;

@property (weak, nonatomic) IBOutlet UIButton *remindTimeBtn;

@property (nonatomic, strong) KKTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)editThePicture:(UIButton *)sender {
    EditPictureVC *editVC = [[EditPictureVC alloc] init];
    editVC.imageResult = ^(UIImage * _Nonnull resultImage) {
        self->_resultImageV.image = resultImage;
    };
    
    [self presentViewController:editVC
                       animated:YES
                     completion:nil];
}

- (IBAction)remindTimeAction:(UIButton *)sender {
    NSString *btnTitle = sender.currentTitle;
    if ([btnTitle containsString:@"开始"]){
        [KKTimer timerWithTotalTime:10.0 timeInterval:1.0 remindCountBlock:^(NSTimeInterval num) {
            [self remindTimer:nil recoundNum:num];
        }];
//        _timer = [[KKTimer alloc] initTimerWithTotalTime:10.0 timeInterval:1.0 delegate:self];
    }
    
}
#pragma mark - KKTimer Delegate
- (void)remindTimer:(KKTimer *)kkTimer recoundNum:(NSTimeInterval)num{
    
    _remindTimeBtn.enabled = num == 10;
    NSString *btnTitle = num == 10 ? @"开始倒计时" : [NSString stringWithFormat:@"倒计时：%f",num];
    [_remindTimeBtn setTitle:btnTitle forState:UIControlStateNormal];
}

@end
