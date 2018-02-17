//
//  LoginViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = false;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [CommonFunction colorWithHexString:@"28328C"];
    
    [self.navigationController setTitle:@"Login"];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Button Actions
- (void)backTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnLoginClicked:(id)sender {
}
- (IBAction)btnRegister:(id)sender {
    RegisterStep1ViewController* vc = [[RegisterStep1ViewController alloc] initWithNibName:@"RegisterStep1ViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

@end
