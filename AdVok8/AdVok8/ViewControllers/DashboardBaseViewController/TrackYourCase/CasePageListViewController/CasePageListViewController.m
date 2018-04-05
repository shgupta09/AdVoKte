//
//  CasePageListViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 06/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CasePageListViewController.h"

@interface CasePageListViewController ()

@end

@implementation CasePageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"Cause List" isCrossBusston:false];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}

- (IBAction)btnAddClicked:(id)sender {
    AddNewCaseViewController* vc = [[AddNewCaseViewController alloc] initWithNibName:@"AddNewCaseViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

@end
