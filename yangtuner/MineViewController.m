//
//  MineViewController.m
//  yangtuner
//
//  Created by zhuwh on 2016/11/8.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#import "MineViewController.h"
#import "UIView+SDAutoLayout.h"
#import "MKConstants.h"

#import <AlipaySDK/AlipaySDK.h>

#import "MKAppService.h"
#import "MKMaikeService.h"
#import "MKPayService.h"

#import "UIButton+Vertical.h"
#import "CmbViewController.h"



@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnWaitPay;
@property (weak, nonatomic) IBOutlet UIButton *btnWaitReceive;
@property (weak, nonatomic) IBOutlet UIButton *btnWaitAppraisal;
@property (weak, nonatomic) IBOutlet UIButton *btnRefund;

@property (strong,nonatomic) MKAppService *appService;
@property (strong,nonatomic) MKMaikeService *maikeService;
@property (strong,nonatomic) MKPayService *payService;

@end

@implementation MineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.appService = [MKAppService sharedInstance];
    self.maikeService = [MKMaikeService sharedInstance];
    self.payService = [MKPayService sharedInstance];
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footerView;
    [self setTopButton:_btnWaitPay section:0];
    [self setTopButton:_btnWaitReceive section:1];
    [self setTopButton:_btnWaitAppraisal section:2];
    [self setTopButton:_btnRefund section:3];
   
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)setTopButton:(UIButton*) button section:(NSInteger)section{
    float width = MK_SCREEN_WIDTH/4;
    button.frame = CGRectMake(0+section*width,button.frame.origin.y,width,button.frame.size.height);
    [button vertical];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (IBAction)waitPayAction:(id)sender {
    NSString* test = @"out_trade_no=20161105190834941000&partner=2088121539433230&service=create_forex_trade_wap&_input_charset=utf-8&subject=333&rmb_fee=100.0&sign=68b8dfec88a197a222765ad94732cb3d&return_url=http://mk_api.tunnel.yangtuner.com/mk/alipay/return&currency=NZD&notify_url=http://mk_api.tunnel.yangtuner.com/h5/notify&sign_type=MD5";
    NSString* alipayScheme = @"test";
    [[AlipaySDK defaultService] payOrder:test fromScheme:alipayScheme callback:^(NSDictionary *resultDic) {
        if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
            NSLog(@"%@",@"=======支付成功");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付成功" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//            // optional - add more buttons:
//            [alert show];
        } else {
            NSLog(@"%@",@"=======支付失败");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付失败" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//            // optional - add more buttons:
//            [alert show];
        }
    }];
}
- (IBAction)waitReceiveAction:(id)sender {
    [_appService checkAppUpdate];
}
- (IBAction)waitAppraisalAction:(id)sender {

//    WeakSelf;
    [self.maikeService getCmbPayInfo:@"20161118152230387951" cb:^(BOOL isSuccess, id message) {
        if(isSuccess){
            [self.payService cmbPay:message callback:^(NSDictionary *resultDic) {
                if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
                     NSLog(@"%@",@"=======支付成功");
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付成功" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//                    // optional - add more buttons:
//                    [alert show];
                } else {
                     NSLog(@"%@",@"=======支付失败");
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付失败" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//                    // optional - add more buttons:
//                    [alert show];
                }
            }];
        }
    }];
}


- (IBAction)refundAction:(id)sender {
    UIViewController* vc = [[UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil] instantiateInitialViewController];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController: vc animated:YES];
}

@end
