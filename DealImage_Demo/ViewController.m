//
//  ViewController.m
//  DealImage_Demo
//
//  Created by CarShare on 2018/10/15.
//  Copyright © 2018年 CarShare. All rights reserved.
//

#import "ViewController.h"

#import "EditPictureVC.h"
#import "KKTestTVCell.h"
#import "KKTimer.h"
#import "KKCustomTV.h"

@interface ViewController () <KKTimerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *resultImageV;

@property (weak, nonatomic) IBOutlet UIButton *remindTimeBtn;

@property (nonatomic, strong) KKTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configTableView];
}
- (void)configTableView {
    CGRect screenBounds = UIScreen.mainScreen.bounds;
    CGRect tableFrame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[KKTestTVCell class] forCellReuseIdentifier:NSStringFromClass([KKTestTVCell class])];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKTestTVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KKTestTVCell class])];
    
    cell.tv.delegate = self;
    
    return cell;
}
#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat row_H = 70.0;
    return row_H;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = [UIColor whiteColor];
    return headerV;
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
        [KKTimer timerCountDownWithTime:1.0 delegate:self remindCountBlock:^(float remindTime) {
            NSLog(@"block======");
        }];
//        [KKTimer initTimerCountDownWithTime:1.0 target:self delegate:self];
    }
    
}
#pragma mark - KKTimer Delegate
- (void)remindTimer:(KKTimer *)kkTimer recoundNum:(float)num{

    NSLog(@"-delegate-----%f",num);
    
}

@end
