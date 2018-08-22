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

    [_btnUser setSelected:true];
    [self.navigationController setTitle:@"Register"];
    
//    [CommonFunction setNavToController:self title:@"Register" isCrossBusston:true isAddRightButton:false];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - btn Actions
- (IBAction)btnNextClicked:(id)sender {
    RegisterStep1ViewController* vc = [[RegisterStep1ViewController alloc] initWithNibName:@"RegisterStep1ViewController" bundle:nil];
    if (_btnUser.state == UIControlStateSelected){
        vc.userType = @"User";
    }
    else
    {
        vc.userType = @"Advocate";
    }
    [self.navigationController pushViewController:vc animated:true];

}

- (IBAction)btnUserClicked:(id)sender {
    [_btnUser setSelected:true];
    [_btnAdvocate setSelected:false];
}
- (IBAction)btnAdvocateClciked:(id)sender {
    [_btnUser setSelected:false];
    [_btnAdvocate setSelected:true];
}


@end
