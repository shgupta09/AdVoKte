//
//  AccordionHeaderView.h
//  FZAccordionTableViewExample
//
//  Created by Krisjanis Gaidis on 6/7/15.
//  Copyright (c) 2015 Fuzz Productions, LLC. All rights reserved.
//

#import "FZAccordionTableView.h"

static const CGFloat kDefaultAccordionHeaderViewHeight = 60.0;
static NSString *const kAccordionHeaderViewReuseIdentifier = @"AccordionHeaderViewReuseIdentifier";

@interface AccordionHeaderView : FZAccordionTableViewHeaderView
@property (weak, nonatomic) IBOutlet UILabel *lbl_headerTitle;
@property (weak, nonatomic) IBOutlet UIView *view;

@end

