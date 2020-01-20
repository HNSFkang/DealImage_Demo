//
//  EditPictureVC.m
//  DealImage_Demo
//
//  Created by CarShare on 2018/10/15.
//  Copyright © 2018年 CarShare. All rights reserved.
//

#import "EditPictureVC.h"

#import "UIImage+SubImage.h"

@interface EditPictureVC ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageV;
@property (nonatomic, strong) UIImageView *testResultImageV;//选择框
@property (nonatomic, strong) UIView *selectBoxView;//选择框
@end

@implementation EditPictureVC{
    UIImageOrientation _imageOrientation;
    UIImage *_newImage;
    CGPoint _originPoint;
    CGPoint _endPoint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIImage *picImage = [UIImage imageNamed:@"pic.jpg"];
//    _pictureImageV.image = picImage;
    _newImage = [UIImage imageNamed:@"pic.jpg"];
    
}
//取消
- (IBAction)cancleEditVC:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
//旋转
- (IBAction)rotatePicture:(UIButton *)sender {
    
    self.selectBoxView.frame = CGRectZero;
    
    _newImage = _pictureImageV.image;
    
    _pictureImageV.transform = CGAffineTransformRotate(_pictureImageV.transform, -M_PI_2);
    
    double rotationZ = [[_pictureImageV.layer valueForKeyPath:@"transform.rotation.z"] doubleValue];
    
    _pictureImageV.image = [self fixOrientation:_pictureImageV.image];
    
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,_pictureImageV.image.size.width, _pictureImageV.image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(rotationZ);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, _pictureImageV.image.scale);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap,rotationZ);
    CGContextScaleCTM(bitmap, 1, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-_pictureImageV.image.size.width / 2, -_pictureImageV.image.size.height / 2, _pictureImageV.image.size.width, _pictureImageV.image.size.height), [_pictureImageV.image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _newImage = newImage;
    
    _pictureImageV.transform = CGAffineTransformIdentity;
    _pictureImageV.image = _newImage;
    //把最终的图片存到相册看看是否成功
//    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    [self testShowResultImage:newImage];
   
}
//裁剪
- (IBAction)tailorPicture:(UIButton *)sender {
    
    _newImage = _pictureImageV.image;
    if (_newImage) {
        CGFloat scaleW = _newImage.size.width/_pictureImageV.frame.size.width;
        CGFloat scaleH = _newImage.size.height / _pictureImageV.frame.size.height;
        CGRect selectRect = self.selectBoxView.frame;
        selectRect.origin.x *= scaleW;
        selectRect.origin.y *= scaleH;
        selectRect.size.width *= scaleW;
        selectRect.size.height *= scaleH;
        UIImage *subImage = [_newImage subImageWithRect:selectRect];
        [self testShowResultImage:subImage];
        _newImage = subImage;
        NSLog(@"%@",self.selectBoxView);
    }
}

//涂抹
- (IBAction)scrawlPicture:(UIButton *)sender {
    self.selectBoxView.frame = CGRectZero;
    
}
//完成
- (IBAction)finishEditPicture:(UIButton *)sender {
    if (_imageResult) {
        _imageResult(_newImage);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)testShowResultImage:(UIImage *)image {
    
    self.testResultImageV.image = image;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint originPoint = [self pointWithTouches:touches];
    _originPoint = CGPointMake(originPoint.x - _pictureImageV.frame.origin.x, originPoint.y - _pictureImageV.frame.origin.y);
    NSLog(@"originPoint :\n %f==%f",_originPoint.x,_originPoint.y);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint endPoint = [self pointWithTouches:touches];
    if (CGRectContainsPoint(_pictureImageV.frame, endPoint)) {
        CGFloat boxView_W = endPoint.x - _pictureImageV.frame.origin.x - _originPoint.x;
        CGFloat boxView_H = endPoint.y - _pictureImageV.frame.origin.y - _originPoint.y;
        self.selectBoxView.frame = CGRectMake(_originPoint.x, _originPoint.y, boxView_W, boxView_H);
        [self tailorPicture:nil];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint viewPoint = [self pointWithTouches:touches];
    if (CGRectContainsPoint(_pictureImageV.frame, viewPoint)) {
//        NSLog(@"viewPoint x:%f,y:%f",viewPoint.x,viewPoint.y);
        CGFloat boxView_W = viewPoint.x - _pictureImageV.frame.origin.x - _originPoint.x;
        CGFloat boxView_H = viewPoint.y - _pictureImageV.frame.origin.y - _originPoint.y;
        
        self.selectBoxView.frame = CGRectMake(_originPoint.x, _originPoint.y, boxView_W, boxView_H);
    }
}
- (CGPoint)pointWithTouches:(NSSet <UITouch *>*)touches {
    UITouch *touch = touches.anyObject;
    return [touch locationInView:self.view];
}
- (UIView *)selectBoxView{
    if (!_selectBoxView) {
        _selectBoxView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _selectBoxView.backgroundColor = [UIColor clearColor];
        _selectBoxView.layer.borderWidth = 1;
        _selectBoxView.layer.borderColor = [UIColor redColor].CGColor;
        
        [_pictureImageV addSubview:_selectBoxView];
    }
    return _selectBoxView;
}
- (UIImageView *)testResultImageV{
    if (!_testResultImageV) {
        UIImageView *resultImageV = [[UIImageView alloc] init];
        resultImageV.frame = CGRectMake(0, 40, 100, 100);
        resultImageV.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:resultImageV];
        _testResultImageV = resultImageV;
    }
    return _testResultImageV;
}
- (UIImage *)fixOrientation:(UIImage *)origiImage {
    
    // No-op if the orientation is already correct
    if (origiImage.imageOrientation == UIImageOrientationUp) return origiImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (origiImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, origiImage.size.width, origiImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, origiImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, origiImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (origiImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, origiImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, origiImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, origiImage.size.width, origiImage.size.height,
                                             CGImageGetBitsPerComponent(origiImage.CGImage), 0,
                                             CGImageGetColorSpace(origiImage.CGImage),
                                             CGImageGetBitmapInfo(origiImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (origiImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,origiImage.size.height,origiImage.size.width), origiImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,origiImage.size.width,origiImage.size.height), origiImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
