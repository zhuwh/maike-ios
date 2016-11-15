//
//  MKMaikeApi.h
//  yangtuner
//
//  Created by zhuwh on 16/11/7.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKApi.h"

@interface MKMaikeApi : NSObject

+(void) getMenuWithKey:(NSString*) key cb:(API_CALLBACK)cb;
+(void) downloadChapterWithKey:(NSString*) key md5:(NSString*) md5 count:(NSUInteger)count cb:(API_CALLBACK)cb;

-(void) getAlipayPayInfo:(NSString*) key cb:(API_CALLBACK)cb;
-(void) getCmbPayInfo:(NSString*) key cb:(API_CALLBACK)cb;

@end
