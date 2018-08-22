//
//  AppAppealVC.h
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppAppealVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_DateOfJudgement;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_Fourm;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CaseNo;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CaseYear;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CourtName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CaseType;

@end
