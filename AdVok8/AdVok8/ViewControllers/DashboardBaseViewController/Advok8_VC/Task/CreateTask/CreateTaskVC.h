//
//  CreateTaskVC.h
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTaskVC : UIViewController
@property(nonatomic) BOOL isCreateTask;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_title;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_Matter;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_Description;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_StartDate;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_EndDate;
@property (weak, nonatomic) IBOutlet UIButton *btn_Save_Update;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Description;

@property (weak, nonatomic) IBOutlet UISwitch *btn_AllDay;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_Location;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint2;

@property (weak, nonatomic) IBOutlet UILabel *lbl_StartTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_EndTime;
@property (weak, nonatomic) IBOutlet UIButton *btn_EndTime;
@property (weak, nonatomic) IBOutlet UIButton *btn_StartTime;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_endTime;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_startTime;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end
