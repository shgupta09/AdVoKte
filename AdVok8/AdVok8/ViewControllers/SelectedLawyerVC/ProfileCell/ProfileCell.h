//
//  ProfileCell.h
//  AdVok8
//
//  Created by shubham gupta on 3/3/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSepcialization;

@property (weak, nonatomic) IBOutlet UIImageView *img_Profile;

@end
