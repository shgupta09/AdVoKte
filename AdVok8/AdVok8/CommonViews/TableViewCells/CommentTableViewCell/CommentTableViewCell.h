//
//  CommentTableViewCell.h
//  AdVok8
//
//  Created by Shagun Verma on 06/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeAgo;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnreply;
@property (weak, nonatomic) IBOutlet UILabel *lblCountLikes;

@end
