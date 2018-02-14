//
//  LoginViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleNavBar];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation bar design methods
- (void)styleNavBar {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size., 64.0)];
    [newNavBar setTintColor:[UIColor whiteColor]];
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    newItem.title = @"Paths";
    
    // BackButtonBlack is an image we created and added to the app’s asset catalog
    UIImage *backButtonImage = [UIImage imageNamed:@"backButton"];
    
    // any buttons in a navigation bar are UIBarButtonItems, not just regular UIButtons. backTapped: is the method we’ll call when this button is tapped
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    
    // the bar button item is actually set on the navigation item, not the navigation bar itself.
    newItem.leftBarButtonItem = backBarButtonItem;
    
    [newNavBar setItems:@[newItem]];
    [self.view addSubview:newNavBar];
}

- (void)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
