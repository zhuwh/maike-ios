//
//  UIViewController+Utils.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/14.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+(UIViewController*) currentViewController;
+(void) alertWithTitle:(NSString*)title message:(NSString*)message okAction:(UIAlertAction*)okAction cancelAction:(UIAlertAction*)cancelAction textAlignment:(NSTextAlignment)textAlignment;

@end
