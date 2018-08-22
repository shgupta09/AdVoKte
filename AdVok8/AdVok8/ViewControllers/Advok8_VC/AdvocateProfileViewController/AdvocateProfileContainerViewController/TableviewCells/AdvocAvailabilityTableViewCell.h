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
@property (weak, nonatomic) IBOutlet UIView *viMonday;
@property (weak, nonatomic) IBOutlet UIView *vi_tuesday;
@property (weak, nonatomic) IBOutlet UIView *vi_wednesday;
@property (weak, nonatomic) IBOutlet UIView *vi_thurday;
@property (weak, nonatomic) IBOutlet UIView *vi_friday;
@property (weak, nonatomic) IBOutlet UIView *viSaturday;
@property (weak, nonatomic) IBOutlet UIView *viSunday;
@property (weak, nonatomic) IBOutlet UIButton *btnMonStart;
@property (weak, nonatomic) IBOutlet UIButton *btnMonEnd;

@property (weak, nonatomic) IBOutlet UIButton *btnTueStart;
@property (weak, nonatomic) IBOutlet UIButton *btnTueEnd;

@property (weak, nonatomic) IBOutlet UIButton *btnWedStart;
@property (weak, nonatomic) IBOutlet UIButton *btnWedEnd;

@property (weak, nonatomic) IBOutlet UIButton *btnThurStart;
@property (weak, nonatomic) IBOutlet UIButton *btnThursEnd;

@property (weak, nonatomic) IBOutlet UIButton *btnFriStart;
@property (weak, nonatomic) IBOutlet UIButton *btnFriEnd;

@property (weak, nonatomic) IBOutlet UIButton *btnSatStart;
@property (weak, nonatomic) IBOutlet UIButton *btnSatEnd;

@property (weak, nonatomic) IBOutlet UIButton *btnSunStart;
@property (weak, nonatomic) IBOutlet UIButton *btnSunEnd;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

@property (weak, nonatomic) IBOutlet UIStackView *stackViewAllSelectedTime;
@property (weak, nonatomic) IBOutlet UIButton *btnAllStartTime;
@property (weak, nonatomic) IBOutlet UIButton *btnAllEndTime;

@end
