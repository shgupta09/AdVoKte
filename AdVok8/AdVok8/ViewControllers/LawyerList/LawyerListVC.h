//
//  LawyerListVC.h
//  AdVok8
//
//  Created by shubham gupta on 3/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawyerListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end
