//
//  User_Profile_VC.h
//  AdVok8
//
//  Created by shubham gupta on 4/14/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User_Header.h"
#import "User_Profile_Cell.h"
@interface User_Profile_VC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tblView;

@end
