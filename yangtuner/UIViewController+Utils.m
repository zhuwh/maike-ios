//
//  UIViewController+Utils.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/14.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

+(UIViewController*) findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

+(UIViewController*) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

/*
 * 查找 UIAlertController 中 message的ParentView
 */
+ (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            return view;
        }else{
            UIView *resultV = [self getParentViewOfTitleAndMessageFromView:subView];
            if (resultV) return resultV;
        }
    }
    return nil;
}

+(void) alertWithTitle:(NSString*)title message:(NSString*)message okAction:(UIAlertAction*)okAction cancelAction:(UIAlertAction*)cancelAction textAlignment:(NSTextAlignment)textAlignment{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if(textAlignment!=NSTextAlignmentCenter){ //默认居中对齐
        /*
         * 修改message textAlignment
         */
        UIView *messageParentView = [self getParentViewOfTitleAndMessageFromView:alertController.view];
        if (messageParentView && messageParentView.subviews.count > 1) {
            UILabel *messageLb = messageParentView.subviews[1];
            messageLb.textAlignment = textAlignment;
        }
    }
    if (okAction) {
        [alertController addAction:cancelAction];
    }
    if (cancelAction) {
        [alertController addAction:okAction];
    }
    
    [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:nil];
}
@end

