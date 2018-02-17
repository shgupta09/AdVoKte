//
//  RegisterStep1ViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 17/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "RegisterStep1ViewController.h"

@interface RegisterStep1ViewController ()

@end

@implementation RegisterStep1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setTitle:[NSString stringWithFormat:@"%@ Register",_userType]];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)btnSendOTPClicked:(id)sender {
    
}



@end
