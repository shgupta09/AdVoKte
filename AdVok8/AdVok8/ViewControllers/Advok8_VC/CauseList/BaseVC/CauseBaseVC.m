//
//  CauseBaseVC.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/30/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CauseBaseVC.h"
#import "DailyCauseListVc.h"
#import "CaseListVC.h"

@interface CauseBaseVC ()

@end

@implementation CauseBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    [self setUpDataContainer];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- other methods
-(void)setUpDataContainer{
    [CommonFunction setCornerRadius:_view_FirstSelection Radius:2];
    [CommonFunction setCornerRadius:_view_SecondSelection Radius:2];
    DailyCauseListVc* firstView = [[DailyCauseListVc alloc] initWithNibName:@"DailyCauseListVc" bundle:nil];
    [self addChildViewController:firstView];                 // 1
    firstView.view.frame = _view_Container_First.bounds;
    [_view_Container_First addSubview:firstView.view];
    [firstView didMoveToParentViewController:self];
    
    CaseListVC* secondView = [[CaseListVC alloc] initWithNibName:@"CaseListVC" bundle:nil];
    [self addChildViewController:secondView];                 // 2
    secondView.view.frame = _view_Container_Second.bounds;
    [_view_Container_Second addSubview:secondView.view];
    [secondView didMoveToParentViewController:self];
    if (_isFirstSelected) {
        [self firstSelected];
    }else{
        [self secondSelected];
    }
}

#pragma mark- Btn Actions

- (IBAction)btnAction_First:(id)sender {
    [self firstSelected];
}

- (IBAction)btnAction_Second:(id)sender {
    [self secondSelected];
}
-(void)firstSelected{
    _view_Container_First.hidden = false;
    _view_Container_Second.hidden = true;
    _view_SecondSelection.hidden = true;
    _view_FirstSelection.hidden = false;
}
-(void)secondSelected{
    _view_Container_First.hidden = true;
    _view_Container_Second.hidden = false;
    _view_SecondSelection.hidden = false;
    _view_FirstSelection.hidden = true;
}

- (IBAction)btnAction_Back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
