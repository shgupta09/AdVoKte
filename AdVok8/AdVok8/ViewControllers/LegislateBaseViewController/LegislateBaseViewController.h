//
//  LegislateBaseViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 07/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegislateBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UIView *containerFeed;
@property (weak, nonatomic) IBOutlet UIView *containerLibrary;
@property (weak, nonatomic) IBOutlet UIView *containerJournal;
@property (weak, nonatomic) IBOutlet UIView *containerPost;

@end
