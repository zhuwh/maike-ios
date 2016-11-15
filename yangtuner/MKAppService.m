//
//  MKAppService.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/8.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MKAppService.h"
#import "MKAppleApi.h"
#import <UIKit/UIKit.h>
#import "UIViewController+Utils.h"

@interface MKAppService()

@property (strong,nonatomic) MKAppleApi* api ;

@end

@implementation MKAppService

SingletonM(Instance)

-(instancetype)init{
    if (self = [super init]) {
        _api = [MKAppleApi new];
    }
    return self;
}

-(void) checkAppUpdate{

    NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
     NSLog(@"%@",currentVersion);
    
    dispatch_semaphore_t disp = dispatch_semaphore_create(0);
    [_api getAppVersionInfo:^(BOOL isSuccess, id message) {
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isSuccess) {
                
                NSString* version = message[@"version"];
                NSString* releaseNotes = message[@"releaseNotes"];
                NSString* trackViewUrl = message[@"trackViewUrl"];
         
                if ([currentVersion isEqualToString:version]) {
                     NSLog(@"%@",@"最近版本");
                }else{
                     NSLog(@"%@",@"有新版本");
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"升级" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                                            [self jumpAppStore:trackViewUrl];
                                        }];
                    [UIViewController alertWithTitle:[NSString stringWithFormat:@"新版本 %@",version] message:releaseNotes okAction:okAction cancelAction:cancelAction textAlignment:NSTextAlignmentLeft];
                    
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"新版本 %@",version] message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
//                    /* 
//                     * 修改message 为左对齐
//                     */
//                    UIView *messageParentView = [self getParentViewOfTitleAndMessageFromView:alertController.view];
//                    if (messageParentView && messageParentView.subviews.count > 1) {
//                        UILabel *messageLb = messageParentView.subviews[1];
//                        messageLb.textAlignment = NSTextAlignmentLeft;
//                    }
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"升级" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//                        [self jumpAppStore:trackViewUrl];
//                    }];
//                    [alertController addAction:cancelAction];
//                    [alertController addAction:okAction];
//                    [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:nil];
                   
                }
            }
        });
        dispatch_semaphore_signal(disp);
    }];
    dispatch_semaphore_wait(disp, DISPATCH_TIME_FOREVER);
}

///*
// * 查找 UIAlertController 中 message的ParentView
// */
//- (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
//    for (UIView *subView in view.subviews) {
//        if ([subView isKindOfClass:[UILabel class]]) {
//            return view;
//        }else{
//            UIView *resultV = [self getParentViewOfTitleAndMessageFromView:subView];
//            if (resultV) return resultV;
//        }
//    }
//    return nil;
//}

/*
 * 跳转到AppStore
 */
-(void) jumpAppStore:(NSString*) trackViewUrl{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
}

@end
