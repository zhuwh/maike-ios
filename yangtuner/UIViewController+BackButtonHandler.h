//
//  UIViewController+BackButtonHandler.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/14.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
-(BOOL)navigationShouldPopOnBackButton;
@end
@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>
@end
