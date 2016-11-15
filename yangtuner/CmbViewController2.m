//
//  CmbViewController.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/9.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "CmbViewController.h"
#import <WebKit/WebKit.h>
#import <cmbkeyboard/CMBWebKeyboard.h>
#import <cmbkeyboard/NSString+Additions.h>


@interface CmbViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation CmbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
//    return;
    
////    // 创建配置
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    // 创建UserContentController（提供JavaScript向webView发送消息的方法）
//    WKUserContentController* userContent = [[WKUserContentController alloc] init];
//    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
//    [userContent addScriptMessageHandler:self name:@"NativeMethod"];
//    // 将UserConttentController设置到配置文件
//    config.userContentController = userContent;
//    // 高端的自定义配置创建WKWebView
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:config];
//    // 设置访问的URL
//    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com"];
//    // 根据URL创建请求
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    // WKWebView加载请求
//    [webView loadRequest:request];
//
    
    
//    NSURL *url = [NSURL URLWithString:@"http://61.144.248.29:801/netpayment/BaseHttp.dll?MB_EUserPay"];
//    NSMutableData *postBody=[NSMutableData data];
//    NSString *formData = [NSString stringWithFormat:@"jsonRequestData=%@", self.payInfo];
//     NSLog(@"formData:%@",formData);
//    [postBody appendData:[formData dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:postBody];
//    
//   
//    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    _webView.UIDelegate = self;
//    _webView.navigationDelegate = self;
//    [self.view addSubview:_webView];
//    
//    [_webView loadRequest:request];
//    [self test:@{@"jsonRequestData":self.payInfo}];
    [self test2];
}


-(void)test2{
        NSURL *url = [NSURL URLWithString:@"http://61.144.248.29:801/netpayment/BaseHttp.dll?MB_EUserPay"];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
    NSMutableData *postBody=[NSMutableData data];
    NSString *formData = [NSString stringWithFormat:@"jsonRequestData=%@", self.payInfo];
    NSLog(@"formData:%@",formData);
    [postBody appendData:[formData dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSLog(@"%ld-%@", (long)[response statusCode],[NSString stringWithUTF8String:[respData bytes]]);
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *str = [[NSString alloc] initWithData:respData encoding:encode];
     NSLog(@"html=%@", str);
    if ([response statusCode] == 200) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_webView loadData:respData MIMEType:@"text/html" characterEncodingName:@"GBK" baseURL:url];
        });
    }
    

    
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
        
//        [_webView loadRequest:request];
}

#define POST_BOUNDS @"------------7d33a816d302b6"

-(void)test:(NSDictionary *)dicData{
    
        NSURL *url = [NSURL URLWithString:@"http://61.144.248.29:801/netpayment/BaseHttp.dll?MB_EUserPay"];
                NSMutableString *bodyContent = [NSMutableString string];
        for(NSString *key in dicData.allKeys){
            id value = [dicData objectForKey:key];
            [bodyContent appendFormat:@"--%@\r\n",POST_BOUNDS];
            [bodyContent appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            [bodyContent appendFormat:@"%@\r\n",value];
        }
        [bodyContent appendFormat:@"--%@--\r\n",POST_BOUNDS];
     NSLog(@"%@",bodyContent);
        NSData *bodyData=[bodyContent dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        [request addValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",POST_BOUNDS] forHTTPHeaderField:@"Content-Type"];
        [request addValue: [NSString stringWithFormat:@"%zd",bodyData.length] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:bodyData];
//    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    _webView.UIDelegate = self;
//    _webView.navigationDelegate = self;
//    [self.view addSubview:_webView];
//    
//    [_webView loadRequest:request];
        NSLog(@"请求的长度%@",[NSString stringWithFormat:@"%zd",bodyData.length]);
        __autoreleasing NSError *error=nil;
        __autoreleasing NSURLResponse *response=nil;
        NSLog(@"输出Bdoy中的内容>>\n%@",[[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding]);
        NSData *reciveData= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if(error){
            NSLog(@"出现异常%@",error);
        }else{
            NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
            if(httpResponse.statusCode==200){
                NSLog(@"服务器成功响应!>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
                
            }else{
                NSLog(@"服务器返回失败>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
                
            }
            
        }
    }


-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)_webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    
    if ([request.URL.host isCaseInsensitiveEqualToString:@"cmbls"]) {
        CMBWebKeyboard *secKeyboard = [CMBWebKeyboard shareInstance];
        [secKeyboard showKeyboardWithRequest:request];
        secKeyboard.webView = self.webView;
        
        UITapGestureRecognizer* myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self.view addGestureRecognizer:myTap]; //这个可以加到任何控件上,比如你只想响应WebView，我正好填满整个屏幕
        myTap.delegate = self;
        myTap.cancelsTouchesInView = NO;
        return NO;
    }
    
    //
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
}

#pragma mark - dealloc
- (void)dealloc
{
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
}
#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
//    // 如果响应的地址是百度，则允许跳转
//    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
//        
        // 允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
//        return;
//    }
//    // 不允许跳转
//    decisionHandler(WKNavigationResponsePolicyCancel);
}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
//    // 如果请求的是百度地址，则延迟5s以后跳转
//    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
//        
//        //        // 延迟5s之后跳转
//        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //
//        //            // 允许跳转
//        //            decisionHandler(WKNavigationActionPolicyAllow);
//        //        });
//        
//        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//    }
//    // 不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
}


@end
