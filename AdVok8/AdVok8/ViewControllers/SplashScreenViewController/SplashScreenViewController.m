//
//  SplashScreenViewController.m
//  TatabApp
//
//  Created by Shagun Verma on 23/09/17.
//  Copyright © 2017 Shagun Verma. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "AppDelegate.h"
@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = true;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidLoad];
    
    sleep(1);
    RearViewController *rearViewController = [[RearViewController alloc]initWithNibName:@"RearViewController" bundle:nil];
    SWRevealViewController *mainRevealController;
    BaseHomeViewController *frontViewController = [[BaseHomeViewController alloc]initWithNibName:@"BaseHomeViewController" bundle:nil];
        mainRevealController = [[SWRevealViewController alloc]initWithRearViewController:rearViewController frontViewController:frontViewController];
   
    mainRevealController.delegate = self;
    mainRevealController.view.backgroundColor = [UIColor clearColor];
    mainRevealController.frontViewShadowRadius = 0;
    mainRevealController.frontViewShadowColor = [UIColor clearColor];
    //            [frontViewController.view addSubview:[CommonFunction setStatusBarColor]];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainRevealController];
    nav.navigationBarHidden = true;
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = nav;

    
    
}


@end
