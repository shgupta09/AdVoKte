//
//  FeedDetailViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 14/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) NSString *postId;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIView *viewTxtComment;
@property (weak, nonatomic) IBOutlet UITextField *txtComment;

@end
