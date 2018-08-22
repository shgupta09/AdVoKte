//
//  AppoinmentDetailVC.h
//  AdVok8
//
//  Created by shubham gupta on 4/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppoinmentDetailVC : UIViewController

@property (nonatomic, strong) Appointment* data;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@end
