//
//  DBVC.h
//  AdVok8
//
//  Created by shubham gupta on 8/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZAccordionTableView.h"

@interface DBVC : UIViewController<UITableViewDataSource,UITableViewDelegate,FZAccordionTableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *LBL_TIMER;
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tblView;

@end
