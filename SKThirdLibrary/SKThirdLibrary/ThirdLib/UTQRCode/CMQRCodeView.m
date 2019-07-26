//
//  CMQRCodeView.m
//  CMKit
//
//  Created by jon on 16/10/25.
//  Copyright © 2016年 jon. All rights reserved.
//

#import "CMQRCodeView.h"
#import <AVFoundation/AVFoundation.h>


@interface CMQRCodeView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureMetadataOutput *output;

/** 捕捉会话 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 预览图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
/** 扫描线 */
@property (nonatomic, strong) UIImageView *lineImgV;

@property (nonatomic, assign) CGRect scanBorderRect;

/*
 *添加view 的Controller 用于弹出提示
 */
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation CMQRCodeView

- (instancetype) initWithFrame:(CGRect)frame scanBorderRect:(CGRect)scanBorderRect viewController:(UIViewController *)vc{
    if (self = [super initWithFrame:frame]) {
        
        self.scanBorderRect = scanBorderRect;
        self.viewController = vc;
        [self scanQRCode];
        
        
    }
    return self;
}
/*添加视图*/
- (void)showView{
    [self resetContentViewMask];
    [self setupScanBorder];
    [self start];
}
/*初始化扫描设备*/
- (void)scanQRCode{
    if ([self isCameraPermissionAvailable]) {
        // 1. 创建捕捉会话
        self.session = [[AVCaptureSession alloc] init];
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        // 2. 添加输入设备(数据从摄像头输入)
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [self.session addInput:input];
        
        // 3. 添加输出数据接口
        self.output = [[AVCaptureMetadataOutput alloc] init];
        // 设置输出接口代理
        
        [self.output setMetadataObjectsDelegate:self queue:dispatch_queue_create(nil, nil)];
        [self.output setRectOfInterest:CGRectMake(self.scanBorderRect.origin.y/CGRectGetHeight(self.frame),self.scanBorderRect.origin.x/CGRectGetWidth(self.frame),self.scanBorderRect.size.width/CGRectGetHeight(self.frame),self.scanBorderRect.size.width/CGRectGetWidth(self.frame))];
        [self.session addOutput:self.output];
        // 3.1 设置输入元数据的类型(类型是二维码数据)
        // 注意，这里必须设置在addOutput后面，否则会报错
        [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]];
        
        // 4.添加扫描图层
        self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.videoPreviewLayer.frame = self.frame;
        [self.layer addSublayer:self.videoPreviewLayer];
        
        [self showView];
       
    }
    
}
/*开始扫描*/
- (void)start{
    
    [self addAnimation];
    [self.session startRunning];
}
/*停止扫描*/
- (void)stop{
    [self.session stopRunning];
    self.session = nil;
}

/**

 *  添加扫码动画
 */
- (void)addAnimation{
    self.lineImgV.hidden = NO;
    CABasicAnimation *animation = [self moveYTime:2 rep:OPEN_MAX];
    [self.lineImgV.layer addAnimation:animation forKey:@"LineAnimation"];
}
- (CABasicAnimation *)moveYTime:(float)time rep:(int)rep
{
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"position"];
    animationMove.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame)/2.0, self.scanBorderRect.origin.y)];
    animationMove.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame)/2.0, self.scanBorderRect.size.height+self.scanBorderRect.origin.y)];
    animationMove.duration = time;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    return animationMove;
}

/**
 *  去除扫码动画
 */
- (void)removeAnimation{
    [self.lineImgV.layer removeAnimationForKey:@"LineAnimation"];
    self.lineImgV.hidden = YES;
}
/*判断摄像头状态*/
- (BOOL)isCameraPermissionAvailable{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(authStatus == AVAuthorizationStatusDenied ||authStatus == AVAuthorizationStatusRestricted){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许APP访问您的相机." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self systemSettingView];
            }]];
            [self.viewController presentViewController:alert animated:YES completion:nil];
            
            return NO;
            
        }
        return YES;
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请使用真机" message:@"您的设备没有相机." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self.viewController presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }
    
    
}
/*打开系统设置*/
- (void)systemSettingView {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=10.0) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }
            
        }
}
/*设置扫描边框*/
- (void)setupScanBorder{
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:self.scanBorderRect];
    backImgV.image = [UIImage imageNamed:@""];
    [self addSubview:backImgV];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.scanBorderRect)+10, CGRectGetWidth(self.frame)-60, 60)];
    msg.backgroundColor = [UIColor clearColor];
    msg.textColor = [UIColor whiteColor];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.font = [UIFont systemFontOfSize:16];
    msg.text = @"将二维码放入框内,即可自动扫描";
    [self addSubview:msg];
    
    self.lineImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.scanBorderRect.origin.x, self.scanBorderRect.origin.y, CGRectGetWidth(self.frame)-80, 2)];
    self.lineImgV.image = [UIImage imageNamed:@""];
    self.lineImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.lineImgV.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lineImgV];
    
    
}
/*设置扫描边框*/
- (void)resetContentViewMask{
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.contentView.bounds];
//    UIBezierPath *clearPath = [[UIBezierPath bezierPathWithRect:self.scanBorderRect] bezierPathByReversingPath];
//    [path appendPath:clearPath];
//    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
//    shapeLayer.path = path.CGPath;
//    self.contentView.layer.mask = shapeLayer;
    
    //左侧的view
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMinX(self.scanBorderRect), KScreenHeight)];
    leftView.alpha = 0.5;
    leftView.backgroundColor = [UIColor blackColor];
    [self addSubview:leftView];
    //右侧的view
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.scanBorderRect), 0, KScreenWidth-CGRectGetMaxX(self.scanBorderRect), KScreenHeight)];
    rightView.alpha = 0.5;
    rightView.backgroundColor = [UIColor blackColor];
    [self addSubview:rightView];
    
    //最上部view
    UIImageView* upView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.scanBorderRect), 0, CGRectGetWidth(self.scanBorderRect), CGRectGetMinY(self.scanBorderRect))];
    upView.alpha = 0.5;
    upView.backgroundColor = [UIColor blackColor];
    [self addSubview:upView];
    
    //底部view
    UIImageView * downView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.scanBorderRect), CGRectGetMaxY(self.scanBorderRect), CGRectGetWidth(self.scanBorderRect), (KScreenHeight-CGRectGetMaxY(self.scanBorderRect)))];
    
    downView.alpha = 0.5;
    downView.backgroundColor = [UIColor blackColor];
    [self addSubview:downView];

    
    
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count) {// 扫描到了数据
        [self stop];
        dispatch_async(dispatch_get_main_queue(), ^{
           [self removeAnimation];
        });
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"----%@",object);
        if ([[object type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSString * result = object.stringValue;
            self.resultBlock(result,YES);
            NSLog(@"__%@",result);
        } else {
            NSLog(@"不是二维码");
            self.resultBlock(@"不是二维码",NO);
        }

    }else{
        NSLog(@"没有扫描到数据");
        self.resultBlock(@"没有扫描到数据",NO);
    }
}

- (void)dealloc{
    NSLog(@"dealloc");
}
@end
