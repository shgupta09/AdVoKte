//
//  AddNewCaseViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 06/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AddNewCaseViewController.h"

@interface AddNewCaseViewController ()

@end

@implementation AddNewCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"Register a Case" isCrossBusston:false];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}

@end
