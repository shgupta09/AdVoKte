//
//  TaskListVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "TaskListVC.h"
#import "TaskListCell.h"
@interface TaskListVC ()

@end

@implementation TaskListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Task List" isCrossBusston:false];
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
    
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
