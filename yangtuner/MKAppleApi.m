//
//  MKAppleApi.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/8.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MKAppleApi.h"
#import "MKConstants.h"

#define API_URL @"http://itunes.apple.com/cn/"

@implementation MKAppleApi

-(void) getAppVersionInfo:(API_CALLBACK)cb{
    
    NSString* url_string = [NSString stringWithFormat:@"%@lookup?id=1143462604",API_URL];
    NSURL * url = [NSURL URLWithString:url_string];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            NSLog(@"response : %@", response);
            
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                //解析NSData数据
                NSDictionary *result =
                [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                NSLog(@"%@",result);
                if (!jsonError) {
                    int resultCount = [[NSString stringWithFormat:@"%@", result[@"resultCount"]] intValue];
                    if (resultCount>0) {
                        NSDictionary* resultTopOne = result[@"results"][0];
                        if (cb) {
                            cb(true,resultTopOne);
                        }
                    }
                }
            }
            
        }else{
            NSString* errorMsg = MK_ERROR_MSG(error);
            NSLog(@"%@",errorMsg);
            if (cb) {
                cb(false,errorMsg);
            }
            
        }
    }];
    [task resume];
}

@end
