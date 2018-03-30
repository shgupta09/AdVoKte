//
//  CaseListVC.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/30/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseListVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *traillinfConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btn_CancelSearch;
@property (weak, nonatomic) IBOutlet UITextField *txt_Search;

@end
