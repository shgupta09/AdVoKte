//
//  TaskListCell.h
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_Profile;

@property (weak, nonatomic) IBOutlet UILabel *lblHeading;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblDateRange;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblTimeRange;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblRange;

@end
