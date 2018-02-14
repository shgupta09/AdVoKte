//
//  PostMainTableViewCell.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "PostMainTableViewCell.h"

@implementation PostMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _containerView.layer.borderColor = [[UIColor lightGrayColor] CGColor ];
    _containerView.layer.borderWidth = 0.6f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
