//
//  ChooseTypeViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 16/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignableButton.h"

@interface ChooseTypeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnAdvocate;
@property (weak, nonatomic) IBOutlet UIButton *btnUser;
@property (weak, nonatomic) IBOutlet DesignableButton *btnNext;
@end
