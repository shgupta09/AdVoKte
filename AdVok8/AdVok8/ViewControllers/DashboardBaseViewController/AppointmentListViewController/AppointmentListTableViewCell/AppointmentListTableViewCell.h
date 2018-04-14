//
//  AppointmentListTableViewCell.h
//  AdVok8
//
//  Created by Shagun Verma on 05/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftImageWithLabel.h"

@interface AppointmentListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblDate;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblTime;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIView *viContainer;

@end
