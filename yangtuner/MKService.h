//
//  MKService.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/11.
//  Copyright © 2016年 maikevip. All rights reserved.
//


typedef void (^SERVICE_CALLBACK)(BOOL isSuccess, id message);
typedef void (^SERVICE_CALLBACK2)(NSDictionary *resultDic);


@protocol MKServiceProtocol <NSObject>

@required
- (void)mkServiceCallBack:(BOOL)isSuccess message:(id)message;

@end

