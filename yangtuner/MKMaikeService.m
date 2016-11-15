//
//  MKMaikeService.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/11.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MKMaikeService.h"
#import "MKMaikeApi.h"

@interface MKMaikeService()

@property (strong,nonatomic) MKMaikeApi* api ;

@end


@implementation MKMaikeService

SingletonM(Instance)
-(instancetype)init{
    if (self = [super init]) {
        _api = [MKMaikeApi new];
    }
    return self;
}

-(void) getCmbPayInfo:(NSString*)orderSn cb:(SERVICE_CALLBACK)scb{
    [self.api getCmbPayInfo:orderSn cb:^(BOOL isSuccess, id message) {
        if (scb) {
            scb(isSuccess,message);
        }
    }];
}

@end
