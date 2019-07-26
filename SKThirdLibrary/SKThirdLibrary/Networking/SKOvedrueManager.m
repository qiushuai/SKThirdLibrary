//
//  SKOvedrueManager.m
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/24.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKOvedrueManager.h"
#import "SKBasicNetWorking.h"
#import "AppDelegate.h"
//#import "RPBaseNavigationController.h"

//#import "RPWechatLoginVC.h"
//#import "RPPhoneLoginVC.h"
@implementation SKOvedrueManager

    static id _instace = nil;
    
+ (instancetype)sharedOvedrueManager
    {
        return [[self alloc] init];
    }
    
- (instancetype)init
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instace = [super init];
        });
        return _instace;
    }
    
+ (id)allocWithZone:(struct _NSZone *)zone
    {
        if (_instace == nil) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                _instace = [super allocWithZone:zone];
            });
        }
        return _instace;
    }
    
- (void)showInObject:(id)responseObject
    {
        
        if (!responseObject) return;
        
        NSNumber *code = responseObject[@"code"];       //  NSLog(@"code = %@", code);
        if ([code integerValue] == SKRequestNotLogin) {
            
            NSLog(@"class - %@",[self getCurrentVC]);
            
//            /** 避免重复显示 */
//            if ([SKAlertTools isAlertShowNow]) {
//                return;
//            }
//            [SKAlertTools showArrayAlertWith:[self getCurrentVC]
//                                       title:@"下线通知"
//                                     message:@"您的账号在其他设备登录，请重新登录"
//                               callWYckBlock:^(NSInteger btnIndex)
//             {
//
//                 //跳转到登录页
//                 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                 SKLoginViewController *dtlVc = [[SKLoginViewController alloc] init];
//                 SKBaseNavigationController *loginController = [[SKBaseNavigationController alloc] initWithRootViewController:dtlVc];
//                 [appDelegate.window setRootViewController:loginController];
//             } cancelButtonTitle:@"去登录"
//                       otherButtonTitleArray:nil
//                       otherButtonStyleArray:nil];
        }
    }
    
    
    /** 获取当前屏幕显示的viewcontroller */
- (UIViewController *)getCurrentVC
    {
        UIViewController* activityViewController = nil;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if(window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow *tmpWin in windows)
            {
                if(tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }
        
        NSArray *viewsArray = [window subviews];
        if([viewsArray count] > 0)
        {
            UIView *frontView = [viewsArray objectAtIndex:0];
            
            id nextResponder = [frontView nextResponder];
            
            if([nextResponder isKindOfClass:[UIViewController class]])
            {
                activityViewController = nextResponder;
            }
            else
            {
                activityViewController = window.rootViewController;
            }
        }
        
        return activityViewController;
    }

@end
