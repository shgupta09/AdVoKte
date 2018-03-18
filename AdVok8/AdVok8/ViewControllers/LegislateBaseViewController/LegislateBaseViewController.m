//
//  LegislateBaseViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 07/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LegislateBaseViewController.h"

@interface LegislateBaseViewController ()<UITabBarDelegate>

@end

@implementation LegislateBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _containerFeed.hidden = false;
    _containerLibrary.hidden = true;
    _containerJournal.hidden = true;
    _containerPost.hidden = true;
    
    [self addViewControllersToContainerViews];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom functions

-(void) addViewControllersToContainerViews{
    FeedViewController* vc = [[FeedViewController alloc] initWithNibName:@"FeedViewController" bundle:nil];
    
    [self addChildViewController:vc];                 // 1
    vc.view.frame = _containerFeed.bounds;
    [_containerFeed addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    LibraryViewController* vc1 = [[LibraryViewController alloc] initWithNibName:@"LibraryViewController" bundle:nil];
    
    [self addChildViewController:vc1];                 // 1
    vc1.view.frame = _containerLibrary.bounds;
    [_containerLibrary addSubview:vc1.view];
    [vc1 didMoveToParentViewController:self];
    
    JournalViewController* vc2 = [[JournalViewController alloc] initWithNibName:@"JournalViewController" bundle:nil];
    
    [self addChildViewController:vc2];                 // 1
    vc2.view.frame = _containerJournal.bounds;
    [_containerJournal addSubview:vc2.view];
    [vc2 didMoveToParentViewController:self];
    
    PostViewController* vc3 = [[PostViewController alloc] initWithNibName:@"PostViewController" bundle:nil];
    
    [self addChildViewController:vc3];                 // 1
    vc3.view.frame = _containerPost.bounds;
    [_containerPost addSubview:vc3.view];
    [vc3 didMoveToParentViewController:self];
    
}



#pragma mark - Tab Bar deegate methods

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    switch (item.tag) {
        case 1000:
        {
            _containerFeed.hidden = false;
            _containerLibrary.hidden = true;
            _containerJournal.hidden = true;
            _containerPost.hidden = true;
        }
            break;
        case 1001:
        {
            _containerFeed.hidden = true;
            _containerLibrary.hidden = false;
            _containerJournal.hidden = true;
            _containerPost.hidden = true;

        }
            break;
        case 1002:
        {
            _containerFeed.hidden = true;
            _containerLibrary.hidden = true;
            _containerJournal.hidden = false;
            _containerPost.hidden = true;

        }
            break;
        case 1003:
        {
            _containerFeed.hidden = true;
            _containerLibrary.hidden = true;
            _containerJournal.hidden = true;
            _containerPost.hidden = false;

        }
            break;

        default:
            break;
    }
}



@end
