//
//  Update_AppointmentVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "Update_AppointmentVC.h"
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
    _lblUsername.text = [NSString stringWithFormat:@"%@ %@",_data.fname,_data.lname];
    _lblDate.text = _data.date;
    _lblTime.text = _data.time;
    _lblStatus.text = _data.Status;
    _lblDescription.text = _data.desc;
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark - btnAction

- (IBAction)btnAction_Udate:(id)sender {
    Update_AppointmentVC *vc = [[Update_AppointmentVC alloc]initWithNibName:@"Update_AppointmentVC" bundle:nil];
    vc.data = _data;
    [self.navigationController pushViewController:vc animated:true];
}


@end
