//
//  CmbViewController.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/9.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "CmbViewController.h"
#import "UIViewController+Utils.h"
#import "UIViewController+BackButtonHandler.h"
#import <cmbkeyboard/CMBWebKeyboard.h>
#import <cmbkeyboard/NSString+Additions.h>


@interface CmbViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic) BOOL isPayOk;

@end

@implementation CmbViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (BOOL)needBackItem
{
    return YES;
}


- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [super viewDidLoad];
    self.title=@"招行一网通支付";
    self.navigationController.navigationBar.topItem.title = @"返回";

    _webView = [[UIWebView alloc] init];
    _webView.frame = self.view.frame;
    [self.view addSubview:_webView];
    _webView.delegate = self; // self.wvDelegateColletion;
    
    NSURL *url = [NSURL URLWithString:@"http://61.144.248.29:801/netpayment/BaseHttp.dll?MB_EUserPay"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    NSMutableData *postBody=[NSMutableData data];
    NSString *formData = [NSString stringWithFormat:@"jsonRequestData=%@", self.payInfo];
    NSLog(@"formData:%@",formData);
    [postBody appendData:[formData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    [_webView loadRequest:request];
    
}

-(BOOL) navigationShouldPopOnBackButton ///在这个方法里写返回按钮的事件处理
{
    NSLog(@"%s",__func__);
    if (self.callback) {
        self.callback(@{@"resultStatus":self.isPayOk?@"9000":@"8000"});
    }
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
//    [self.tabBarController.tabBar setHidden:NO];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
//    [self reloadWebView];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    //    [self pb_setDesiredNavigaionBarType:self]
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
}

static BOOL FROM = FALSE;
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
 
     NSLog(@"-===============request : %@",[request.URL path]);
    if ([request.URL.host isCaseInsensitiveEqualToString:@"cmbls"]) {
        CMBWebKeyboard *secKeyboard = [CMBWebKeyboard shareInstance];
        [secKeyboard showKeyboardWithRequest:request];
        secKeyboard.webView = webView;
        
        UITapGestureRecognizer* myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self.view addGestureRecognizer:myTap]; //这个可以加到任何控件上,比如你只想响应WebView，我正好填满整个屏幕
        myTap.delegate = self;
        myTap.cancelsTouchesInView = NO;
        return NO;
    }
    else if([request.URL.query isCaseInsensitiveEqualToString:@"MB_EUserP_PayOK"]){
        self.isPayOk = YES;
    }
    
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Load webView error:%@", [error localizedDescription]);
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (FROM) {
        
        return;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView_
{
//    _secKeyboard.webView = _webView;
}





#pragma mark - dealloc
- (void)dealloc
{
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
}

@end
