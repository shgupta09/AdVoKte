//
//  BaseHomeViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 07/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "BaseHomeViewController.h"

@interface BaseHomeViewController ()<UISearchBarDelegate>
{
    SWRevealViewController *revealController;
    BOOL isOpen;
    UIView *tempView;
    UITapGestureRecognizer *singleFingerTap;
    UISearchBar *searchBar;
    
    UISearchDisplayController *searchDisplayController;

}
@end

@implementation BaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar.hidden = true;
    _containerViewDashboard.hidden = true;
    _vi_activeDashboard.hidden = true;

    LegislateBaseViewController* vc = [[LegislateBaseViewController alloc] initWithNibName:@"LegislateBaseViewController" bundle:nil];
    
    [self addChildViewController:vc];                 // 1
    vc.view.frame = _containerView.bounds;
    [_containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
   
    DashboardBaseViewController* vc1 = [[DashboardBaseViewController alloc] initWithNibName:@"DashboardBaseViewController" bundle:nil];
    
    [self addChildViewController:vc1];                 // 1
    vc1.view.frame = _containerViewDashboard.bounds;
    [_containerViewDashboard addSubview:vc1.view];
    [vc1 didMoveToParentViewController:self];

    
    revealController = [self revealViewController];
    singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(handleSingleTap:)];

    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,70,320,44)];
    [searchBar setShowsScopeBar:YES];
    [searchBar setScopeButtonTitles:[[NSArray alloc] initWithObjects:@"OBJ",@"C", nil]];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    [searchDisplayController setSearchResultsDelegate:self];
  
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search bar delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"test");
    //NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchBar];
    //newStories = [stories filteredArrayUsingPredicate:filterPredicate];
    //NSLog(@"newStories %@", newStories);
}

#pragma mark - Button Actions
//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    self.navigationController.navigationBar.userInteractionEnabled = true;
    if (isOpen){
        [revealController revealToggle:nil];
        [tempView removeGestureRecognizer:singleFingerTap];
        [tempView removeFromSuperview];
        isOpen = false;
    }
    
}

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
    _containerViewDashboard.hidden = true;
    _containerView.hidden = false;
    _vi_activeDashboard.hidden = true;
    _vi_activeLegislate.hidden = false;

}
- (IBAction)btnDashboard:(id)sender {
    _containerViewDashboard.hidden = false;
    _containerView.hidden = true;
    _vi_activeDashboard.hidden = false;
    _vi_activeLegislate.hidden = true;

}


- (IBAction)btnSearchClciked:(id)sender {
//    _searchBar.hidden = false;
}


@end
