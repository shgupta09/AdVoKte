//
//  LoginViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignableButton.h"
#import "TextFieldBaselineWithLeftRight.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet DesignableButton *btnLogin;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sc_userType;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtUsername;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtPassword;

@end
