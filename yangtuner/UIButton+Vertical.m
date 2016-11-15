//
//  UIButton+VerticalImageAndTitle.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/8.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "UIButton+Vertical.h"

@implementation UIButton (Vertical)

-(void) vertical{
    CGFloat totalHeight = (self.imageView.frame.size.height + self.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [self setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - self.imageView.frame.size.height), 0.0, 0.0, -self.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width, -(totalHeight - self.titleLabel.frame.size.height),0.0)];
}

@end
