//
//  ConfirmAppointmentViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 07/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmAppointmentViewController : UIViewController

@property (nonatomic, strong) NSString* dayString;
@property (nonatomic, strong) NSString* dateString;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblDayName;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblDate;
@property (nonatomic,strong) ADRegistrationModel *obj;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblLawyerName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtName;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtEmail;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtMobile;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtDescription;

@end
