//
//  Update_AppointmentVC.h
//  AdVok8
//
//  Created by shubham gupta on 4/16/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Update_AppointmentVC : UIViewController
@property (nonatomic, strong) Appointment* data;
@property (weak, nonatomic) IBOutlet UIButton *btn_Terms;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_appointment;

@end
