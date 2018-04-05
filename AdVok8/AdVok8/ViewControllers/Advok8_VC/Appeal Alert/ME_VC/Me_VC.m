//
//  Me_VC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "Me_VC.h"

@interface Me_VC ()

@end

@implementation Me_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark- Navigation
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Me" isCrossBusston:false];
}

-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - BtnAction

- (IBAction)btnAction_ViewProfile:(id)sender {
    
}
- (IBAction)btnAction_MyActivity:(id)sender {
    ProfileVC *profileObj = [[ProfileVC alloc]initWithNibName:@"ProfileVC" bundle:nil];
    profileObj.isFromMyActivity = true;
    [self.navigationController pushViewController:profileObj animated:true];
}



@end
