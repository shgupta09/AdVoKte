//
//  NoOfLikesViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 21/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoOfLikesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property  (strong, nonatomic) NSString* postId;
@end
