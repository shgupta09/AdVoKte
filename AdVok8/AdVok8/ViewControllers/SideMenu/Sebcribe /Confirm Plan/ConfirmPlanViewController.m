//
//  ConfirmPlanViewController.m
//  AdVok8
//
//  Created by shubham gupta on 7/28/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//
//#import <InstaMojoiOS/InstaMojoiOS-Swift.h>

#import "ConfirmPlanViewController.h"
@interface ConfirmPlanViewController (){
    LoderView *loderObj;
}
@end

@implementation ConfirmPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Subscription Plan" isCrossBusston:false];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - btn Action

- (IBAction)btnAction_payNow:(id)sender {
    
//    [[IMConfiguration sharedInstance] setupOrderWithPurpose:@"buying" buyerName:@"Shardul" emailId:@"tester@gmail.com" mobile:@"7875432991" amount:@"20" environment:EnvironmentProduction on:nil completion:^(BOOL success, NSString * _Nonnull message) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController:alert animated:true completion:nil];
//        });
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
