//
//  MKIndexController.m
//  yangtuner
//
//  Created by zhuwh on 16/11/6.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MKIndexController.h"
#import "MKConstants.h"


#define kStoryboardKey          @"storyboard"
#define kControllerClassKey     @"ControllerClass"
#define kTitleKey               @"title"
#define kImgKey                 @"imageName"
#define kSelImgKey              @"selectedImageName"

@implementation MKIndexController

-(void) viewDidLoad{
    [self setupControllers];
}


-(void) setupControllers{
    
    NSArray *childItemsArray = @[
                                 @{kControllerClassKey  : @"UIViewController",
                                   kTitleKey  : @"洋屯儿",
                                   kImgKey    : @"ic_tab_home",
                                   kSelImgKey : @"ic_tab_home_p"},
                                 @{kControllerClassKey  : @"UIViewController",
                                   kTitleKey  : @"分类",
                                   kImgKey    : @"ic_tab_class",
                                   kSelImgKey : @"ic_tab_class_p"},
                                 @{kControllerClassKey  : @"UIViewController",
                                   kTitleKey  : @"活动",
                                   kImgKey    : @"ic_tab_act",
                                   kSelImgKey : @"ic_tab_act_p"},
                                 @{kControllerClassKey  : @"UIViewController",
                                   kTitleKey  : @"购物车",
                                   kImgKey    : @"ic_tab_shop",
                                   kSelImgKey : @"ic_tab_shop_p"},
                                 @{kStoryboardKey  : @"MineViewController",
                                   kTitleKey  : @"我的",
                                   kImgKey    : @"ic_tab_me",
                                   kSelImgKey : @"ic_tab_me_p"}];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController* vc = nil;
        if (dict[kControllerClassKey]) {
            vc = [NSClassFromString(dict[kControllerClassKey]) new];
        }else if (dict[kStoryboardKey]) {
            vc = [[UIStoryboard storyboardWithName:dict[kStoryboardKey] bundle:nil] instantiateInitialViewController];
        }
        if (!vc) {
            NSLog(@"VC is nil");
        }
//        if ([dict[kTitleKey] isEqualToString:@"书城"]) {
//            ((MKBookStoreController *)vc).url = [NSURL URLWithString:MK_STROE_URL];
//        }else if ([dict[kTitleKey] isEqualToString:@"发现"]) {a
//            ((MKBookStoreController *)vc).url = [NSURL URLWithString:MK_FIND_URL];
//        }
        vc.title = dict[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            MK_COLOR_TABITEM_TEXT_SELECT, NSForegroundColorAttributeName,
                                            nil] forState:UIControlStateSelected];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self addChildViewController:nav];
    }];
    [self setSelectedIndex:0];
    
}

@end
