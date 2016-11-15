//
//  MKPayService.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/11.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MKPayService.h"
#import "MKCmbApi.h"
#import "MKMaikeApi.h"
#import "CmbViewController.h"
#import "UIViewController+Utils.h"

@interface MKPayService()

@property (strong,nonatomic) MKCmbApi* cmbApi ;
@property (strong,nonatomic) MKMaikeApi* maikeApi ;

@end


@implementation MKPayService
SingletonM(Instance)

-(instancetype)init{
    if (self = [super init]) {
        _cmbApi = [MKCmbApi new];
        _maikeApi = [MKMaikeApi new];
    }
    return self;
}

-(void) cmbPay:(NSString*) payInfo callback:(SERVICE_CALLBACK2)callback{
    CmbViewController* vc = [CmbViewController new];
    vc.payInfo = payInfo;
    vc.callback = callback;
    vc.hidesBottomBarWhenPushed=YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIViewController currentViewController] navigationController] pushViewController: vc animated:YES];
    });
}
@end
