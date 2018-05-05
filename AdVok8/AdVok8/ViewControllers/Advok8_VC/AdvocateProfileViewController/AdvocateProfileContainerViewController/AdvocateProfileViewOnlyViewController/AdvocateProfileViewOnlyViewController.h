//
//  AdvocateProfileViewOnlyViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 05/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvocateProfileViewOnlyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic,strong) ADRegistrationModel *obj;

@end
