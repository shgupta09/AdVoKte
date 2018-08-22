//
//  AdvocAchievementTableViewCell.h
//  AdVok8
//
//  Created by Shagun Verma on 04/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvocAchievementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtEduDegreeName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtEduFromYear;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtEduToYear;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtEduCollege;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtMemMembershipPost;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtMemDuration;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtMemCompanyName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtExpDegree;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtExpDuration;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtExpCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

@end
