//
//  CommentViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 05/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtComment;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end
