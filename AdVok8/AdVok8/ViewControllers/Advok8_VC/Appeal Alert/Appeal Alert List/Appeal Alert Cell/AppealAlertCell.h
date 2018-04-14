//
//  AppealAlertCell.h
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppealAlertCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lbltopLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblBottomLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblBottomRight;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end
