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
@property (strong , nonatomic) CaseList *dataObj ;

@property (strong , nonatomic) CauseListModel *causeListObj ;




//caseView
@property (weak, nonatomic) IBOutlet UILabel *lblC3;
@property (weak, nonatomic) IBOutlet UILabel *lblC4;

@property (weak, nonatomic) IBOutlet UILabel *lblC1;
@property (weak, nonatomic) IBOutlet UILabel *lblC2;

//DailyCauseLIst
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;

@end
