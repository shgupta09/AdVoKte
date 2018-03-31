//
//  CasePageVC.h
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZAccordionTableView.h"
#import "AccordionHeaderView.h"

@interface CasePageVC : UIViewController<UITableViewDataSource,UITableViewDelegate,FZAccordionTableViewDelegate>
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (nonatomic) BOOL isFromDailyCauseList;
@property (weak, nonatomic) IBOutlet UIView *view_DailyCause;
@property (weak, nonatomic) IBOutlet UIView *view_Case;

@end
