//
//  MKPayService.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/11.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKSingleton.h"
#import "MKService.h"

@interface MKPayService : NSObject
SingletonH(Instance)

-(void) cmbPay:(NSString*) payInfo callback:(SERVICE_CALLBACK2)callback;

@end
