//
//  ChooseTypeViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 16/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "ChooseTypeViewController.h"

@interface ChooseTypeViewController ()

@end

@implementation ChooseTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [CommonFunction setNavToController:self title:@"Register" isCrossBusston:true isAddRightButton:false];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backTapped {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
