//
//  ProfileCell.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/7/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView_Profile;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCountFollowers;
@property (weak, nonatomic) IBOutlet UILabel *lblCountFollowing;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_Background;
@property (weak, nonatomic) IBOutlet UIButton *btnFollowers;
@property (weak, nonatomic) IBOutlet UIButton *btnFollowing;



@end
