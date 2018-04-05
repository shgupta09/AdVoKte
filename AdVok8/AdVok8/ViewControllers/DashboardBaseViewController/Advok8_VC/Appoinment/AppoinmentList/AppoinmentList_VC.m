//
//  AppoinmentList_VC.m
//  AdVok8
//
//  Created by shubham gupta on 4/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppoinmentList_VC.h"
#import "TaskListCell.h"
#import "AppoinmentDetailVC.h"
@interface AppoinmentList_VC ()

@end

@implementation AppoinmentList_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- Navigation
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Appoinment" isCrossBusston:false];
    [self setUpTableView];
}
-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"TaskListCell" bundle:nil]forCellReuseIdentifier:@"TaskListCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskListCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"TaskListCell"];
    if (cell == nil) {
        cell = [[TaskListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TaskListCell"];
    }
    cell.imgView_Profile.hidden = FALSE;
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppoinmentDetailVC *createTaskObj = [[AppoinmentDetailVC alloc]initWithNibName:@"AppoinmentDetailVC" bundle:nil];
    [self.navigationController pushViewController:createTaskObj animated:true];
}


@end
