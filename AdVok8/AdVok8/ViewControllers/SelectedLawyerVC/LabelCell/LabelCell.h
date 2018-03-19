//
//  LabelCell.h
//  AdVok8
//
//  Created by shubham gupta on 3/3/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_first;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Second;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Third;
@property (weak, nonatomic) IBOutlet UIView *separatorView1;
@property (weak, nonatomic) IBOutlet UIView *separatorView2;
@property (weak, nonatomic) IBOutlet UIView *separatorView3;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSecond;

@end
