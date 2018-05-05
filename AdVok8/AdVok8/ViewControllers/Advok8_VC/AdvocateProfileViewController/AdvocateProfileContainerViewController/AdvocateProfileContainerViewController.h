//
//  AdvocateProfileContainerViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

extern ADRegistrationModel* global_advocate_profileObj;


@interface AdvocateProfileContainerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnAvailability;
@property (weak, nonatomic) IBOutlet UIButton *btnAchievement;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_activeTab;

@end
