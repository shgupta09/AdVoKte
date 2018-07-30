//
//  SubscribeVC.m
//  AdVok8
//
//  Created by shubham gupta on 7/28/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "SubscribeVC.h"
#include "ConfirmPlanViewController.h"
#import "SubscribeCell.h"
@interface SubscribeVC (){
    NSMutableArray* arrData;
    LoderView *loderObj;
}

@end

@implementation SubscribeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}
-(void)backTapped{
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
}
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Subscription Plan" isCrossBusston:false];
    [self setUpTableView];
    arrData = [[NSMutableArray alloc ] init];
    
}

#pragma mark- tableView delegate
-(void)setUpTableView{
    [_tbl_View registerNib:[UINib nibWithNibName:@"SubscribeCell" bundle:nil]forCellReuseIdentifier:@"SubscribeCell"];
    _tbl_View.rowHeight = UITableViewAutomaticDimension;
    _tbl_View.estimatedRowHeight = 100;
    _tbl_View.multipleTouchEnabled = NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData count]+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubscribeCell *cell = [_tbl_View dequeueReusableCellWithIdentifier:@"SubscribeCell"];
 
    [CommonFunction setCornerRadius:cell.view Radius:10.0];
      cell.view2.layer.cornerRadius = 10;
       [CommonFunction setShadowOpacity:cell.view2];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConfirmPlanViewController* vc ;
    
    vc = [[ConfirmPlanViewController alloc] initWithNibName:@"ConfirmPlanViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}
@end
