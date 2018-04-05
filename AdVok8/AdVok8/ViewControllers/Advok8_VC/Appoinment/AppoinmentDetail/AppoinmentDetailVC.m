//
//  AppoinmentDetailVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppoinmentDetailVC.h"

@interface AppoinmentDetailVC ()

@end

@implementation AppoinmentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Navigation
-(void)setUpData{
   
    [CommonFunction setNavToController:self title:@"Appoinment" isCrossBusston:false];
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark - btnAction

- (IBAction)btnAction_Udate:(id)sender {
}


@end
