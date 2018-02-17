//
//  RegisterStep1ViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 17/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldBaselineWithLeftRight.h"

@interface RegisterStep1ViewController : UIViewController
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtFirstName;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtEmailAddress;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtMobile;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtPassword;

@property (weak, nonatomic) NSString* userType;
@end
