//
//  Update_AppointmentVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/16/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "Update_AppointmentVC.h"

@interface Update_AppointmentVC ()

@end

@implementation Update_AppointmentVC

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
    
    [CommonFunction setNavToController:self title:@"Update Appoinment" isCrossBusston:false];
    
   
    
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark - btnAction

- (IBAction)btnAction_Udate:(id)sender {
    
}

- (IBAction)btnAction_Terms:(id)sender {
    if (_btn_Terms.isSelected) {
        [_btn_Terms setSelected:false];
    }else{
        [_btn_Terms setSelected:true];
    }
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
