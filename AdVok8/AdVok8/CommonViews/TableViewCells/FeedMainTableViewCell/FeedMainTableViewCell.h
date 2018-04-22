//
//  FeedMainTableViewCell.h
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnUserImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserType;
@property (weak, nonatomic) IBOutlet UILabel *lblPostCreatedTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPostNote;
@property (weak, nonatomic) IBOutlet UIImageView *lblPostImage;
@property (weak, nonatomic) IBOutlet UILabel *lblLikes;
@property (weak, nonatomic) IBOutlet UILabel *lblComments;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_postImageHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblHeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_stackview_height;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfilePic;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UIButton *btnImageToZoom;
@property (weak, nonatomic) IBOutlet UIButton *btnLikes;
@property (weak, nonatomic) IBOutlet UIButton *btnComments;

@end
