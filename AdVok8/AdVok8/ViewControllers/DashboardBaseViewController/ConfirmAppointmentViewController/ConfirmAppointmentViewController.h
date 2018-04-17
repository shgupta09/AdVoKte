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

@end
