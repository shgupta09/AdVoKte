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

@end
