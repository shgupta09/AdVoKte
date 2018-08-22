//
//  User_Header.h
//  AdVok8
//
//  Created by shubham gupta on 4/14/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZAccordionTableView.h"

static const CGFloat kDefaulAUser_HeaderHeight = 30.0;
static NSString *const kUser_HeaderReuseIdentifier = @"User_HeaderReuseIdentifier";


@interface User_Header : FZAccordionTableViewHeaderView

@property (weak, nonatomic) IBOutlet UILabel *lbl_headerTitle;


@end
