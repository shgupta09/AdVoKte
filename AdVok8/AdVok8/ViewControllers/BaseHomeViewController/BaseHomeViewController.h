//
//  BaseHomeViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 07/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldBaselineWithLeftRight.h"
@interface BaseHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtEnquiry;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtMobile;
@property (weak, nonatomic) IBOutlet TextFieldBaselineWithLeftRight *txtFirstName;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *containerViewDashboard;
@property (weak, nonatomic) IBOutlet UIView *vi_activeLegislate;
@property (weak, nonatomic) IBOutlet UIView *vi_activeDashboard;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cont_bottomToSuperview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_tblHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchContent;
@property (strong, nonatomic) IBOutlet UIView *popUpView;
@end
