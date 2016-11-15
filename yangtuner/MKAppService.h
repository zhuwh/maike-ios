//
//  MKAppService.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/8.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKSingleton.h"

@interface MKAppService : NSObject

SingletonH(Instance)

-(void) checkAppUpdate;

@end
