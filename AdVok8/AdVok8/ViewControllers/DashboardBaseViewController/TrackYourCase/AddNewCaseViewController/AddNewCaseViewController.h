//
//  AddNewCaseViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 06/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewCaseViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_DateOfJudgement;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_Fourm;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CaseNo;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CaseYear;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CourtName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txt_CaseType;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtCaseDescription;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtCaseAct;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtPetitionerName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtRespondentName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtResponAdvocateName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtDateOfFiling;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtLastListingDate;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtUpcomingHearingDate;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtCaseDisposalDate;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtCaseStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_viContainerAdditionalField;
@property (weak, nonatomic) IBOutlet UIButton *btnAdditionalFields;
@property (weak, nonatomic) IBOutlet UIView *viContainerAdditionalFields;

@end
