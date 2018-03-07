//
//  ProfileCell.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/7/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "ProfileCell2.h"

@implementation ProfileCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    _imgView_Profile.layer.borderColor = [[UIColor whiteColor] CGColor];
    _imgView_Profile.layer.borderWidth = 2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
