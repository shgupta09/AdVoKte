//
//  BaseHomeViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 07/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "BaseHomeViewController.h"

@interface BaseHomeViewController ()
{
    SWRevealViewController *revealController;
    BOOL isOpen;
    UIView *tempView;
    UITapGestureRecognizer *singleFingerTap;
}
@end

@implementation BaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LegislateBaseViewController* vc = [[LegislateBaseViewController alloc] initWithNibName:@"LegislateBaseViewController" bundle:nil];
    
    [self addChildViewController:vc];                 // 1
    vc.view.bounds = _containerView.bounds;                 //2
    [_containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)revealAction:(id)sender {
    //    self.view.userInteractionEnabled = false;
    self.navigationController.navigationBar.userInteractionEnabled = true;
    
    
    if (isOpen) {
        
        [revealController revealToggle:nil];
        
        [tempView removeGestureRecognizer:singleFingerTap];
        [tempView removeFromSuperview];
        isOpen = false;
    }
    else{
        
        [revealController revealToggle:nil];
        tempView.frame  =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
        [tempView addGestureRecognizer:singleFingerTap];
        [self.view addSubview:tempView];
        isOpen = true;
    }
    
}

- (IBAction)btnLegislate:(id)sender {
}



@end
