//
//  MKMaikeApi.m
//  yangtuner
//
//  Created by zhuwh on 16/11/7.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MKMaikeApi.h"
#import "MKConstants.h"

#define API_URL @"http://192.168.1.211:8088/"


@implementation MKMaikeApi

-(void) getAlipayPayInfo:(NSString*) key cb:(API_CALLBACK)cb{
    
    NSString* url_string = [NSString stringWithFormat:@"%@users/mk/alipayByParam?orderSn=20161105190834941000&orderName=333&macId&token=123",API_URL];
    NSURL * url = [NSURL URLWithString:url_string];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
//    [request addValue:@"sogoureader_ios/3.5.3" forHTTPHeaderField:@"appversion"];
//    [request addValue:@"sogoureader_ios/3.5.3" forHTTPHeaderField:@"User-Agent"];
    
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
                    BOOL success = [result[@"sucess"] boolValue];
                    if (success) {
                        NSString* payInfo = result[@"data"];
                        if (cb) {
                            cb(true,payInfo);
                        }
                    }else{
                        NSString* errorInfo = result[@"error"];
                        if (cb) {
                            cb(false,errorInfo);
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

-(void) getCmbPayInfo:(NSString*) orderSn cb:(API_CALLBACK)cb{
    
    NSString* url_string = [NSString stringWithFormat:@"%@users/pay/cmb/prepay?token=123&orderSn=%@",API_URL,orderSn];
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
                    BOOL success = [result[@"success"] boolValue];
                    if (success) {
                        NSString* payInfo = result[@"data"];
                        if (cb) {
                            cb(true,payInfo);
                        }
                    }else{
                        NSString* errorInfo = result[@"error"];
                        if (cb) {
                            cb(false,errorInfo);
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

+(void) getMenuWithKey:(NSString*) key cb:(API_CALLBACK)cb{
    
    NSString* url_string = [NSString stringWithFormat:@"%@/b/m?bkey=%@&v=0&uid=AADB8D064053BA132C7477906A533FF3@visitor.com&token=2578e1eb26b5b246dfba58b070dd1452&eid=1136",API_URL,key];
    NSURL * url = [NSURL URLWithString:url_string];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"sogoureader_ios/3.5.3" forHTTPHeaderField:@"appversion"];
    [request addValue:@"sogoureader_ios/3.5.3" forHTTPHeaderField:@"User-Agent"];
    
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            NSLog(@"response : %@", response);
            
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                //删除第一行
                Byte* bytes = ((Byte*)([data bytes]));
                int index = 0;
                for (int i =0; i<15; i++) {
                    //            NSLog(@"%d",*(bytes+i));
                    if (*(bytes+i)==10) {
                        index = i;
                    }
                }
                NSData *data1 = [data subdataWithRange:NSMakeRange(0, index)];
                NSString* crc = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
                NSLog(@"crc:%@",crc);
                NSMutableData *mdata = [NSMutableData dataWithData:data];
                [mdata replaceBytesInRange:NSMakeRange(0, index) withBytes:NULL length:0];//删除索引0到索引index的数据
                //解析NSData数据
                NSDictionary *notesJSON =
                [NSJSONSerialization JSONObjectWithData:mdata
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                NSLog(@"%@",notesJSON);
                if (!jsonError) {
                    NSString* status = [notesJSON objectForKey:@"status"];
                    
                    if([status isEqualToString:@"suc"]){
                        NSArray* chapter = [notesJSON objectForKey:@"chapter"];
                        if (cb) {
                            cb(true,chapter);
                        }
                        else{
                            if (cb) {
                                cb(false,[NSString stringWithFormat:@"status is %@",status ]);
                            }
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

+(void) downloadChapterWithKey:(NSString*) key md5:(NSString*) md5 count:(NSUInteger)count cb:(API_CALLBACK)cb{
    
   
}

@end
