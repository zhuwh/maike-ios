//
//  MKCmbApi.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/10.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKApi.h"

@interface MKCmbApi : NSObject

-(void) pay:(NSString*) payInfo cb:(API_CALLBACK)cb;

@end
