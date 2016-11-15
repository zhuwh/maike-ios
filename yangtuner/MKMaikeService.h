//
//  MKMaikeService.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/11.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKSingleton.h"
#import "MKService.h"

@interface MKMaikeService : NSObject

SingletonH(Instance)

-(void) getCmbPayInfo:(NSString*)orderSn cb:(SERVICE_CALLBACK)cb;

@end

