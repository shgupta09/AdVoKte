//
//  AdvocAvailabilityTableViewCell.h
//  AdVok8
//
//  Created by Shagun Verma on 04/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvocAvailabilityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_stackViewWeekHeight;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtOfcAddress1;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtOfcAddress2;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtOfcPincode;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnDaysSelect;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnTimeForDayCollection;

@property (weak, nonatomic) IBOutlet UIButton *btnSameForAll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_mondayView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_tuesView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_wednesdayView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_thursView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_friView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_satView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_sunView_height;

@end
