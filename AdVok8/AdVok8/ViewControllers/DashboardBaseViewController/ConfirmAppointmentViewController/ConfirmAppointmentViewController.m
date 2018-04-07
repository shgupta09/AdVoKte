//
//  ConfirmAppointmentViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 07/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "ConfirmAppointmentViewController.h"

@interface ConfirmAppointmentViewController ()

@end

@implementation ConfirmAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"Appointment" isCrossBusston:false];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
