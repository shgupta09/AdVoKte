//
//  ListCell.h
//  AdVok8
//
//  Created by shubham gupta on 3/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftImageWithLabel.h"
@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblExperience;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblEducation;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblSepcialization;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblLocation;
@property (weak, nonatomic) IBOutlet LeftImageWithLabel *lblCost;

@end
