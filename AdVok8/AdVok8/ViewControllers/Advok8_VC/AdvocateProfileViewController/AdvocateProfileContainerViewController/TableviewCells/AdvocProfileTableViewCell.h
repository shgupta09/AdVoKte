//
//  AdvocProfileTableViewCell.h
//  AdVok8
//
//  Created by Shagun Verma on 04/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvocProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtFirstName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtLastName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtEmailID;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtContactNumber;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtGender;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtFDOB;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtBarcode;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtDescription;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtConsultancyFees;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtAdvocateType;


@end



