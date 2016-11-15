//
//  MKCmbApi.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/10.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MKCmbApi.h"
#import "MKConstants.h"

#define API_URL @"http://61.144.248.29:801/"
//#define boundary @"AaB03xmark" //设置边界 参数可以随便设置

@implementation MKCmbApi

-(void) pay:(NSString*) payInfo cb:(API_CALLBACK)cb{
    NSString* url_string = [NSString stringWithFormat:@"%@netpayment/BaseHttp.dll?MB_EUserPay",API_URL];
    NSURL * url = [NSURL URLWithString:url_string];
    NSMutableData *postBody=[NSMutableData data];
    NSString *formData = [NSString stringWithFormat:@"jsonRequestData=%@", payInfo];
    [postBody appendData:[formData dataUsingEncoding:NSUTF8StringEncoding]];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postBody];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            
            NSLog(@"response : %@", httpResp);
            
            if (httpResp.statusCode == 200) {
                 NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                
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
