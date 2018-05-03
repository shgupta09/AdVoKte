//
//  AdvocProfileTableViewCell.h
//  AdVok8
//
//  Created by Shagun Verma on 04/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvocProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtFirstName;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtLastName;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtEmailID;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtContactNumber;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtGender;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtFDOB;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtBarcode;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtDescription;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtConsultancyFees;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtAdvocateType;


@end
