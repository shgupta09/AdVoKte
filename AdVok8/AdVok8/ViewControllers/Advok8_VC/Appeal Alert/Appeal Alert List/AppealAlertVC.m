//
//  AppealAlertVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppealAlertVC.h"
#import "AppealAlertCell.h"
#import "AppAppealVC.h"
@interface AppealAlertVC ()

@end

@implementation AppealAlertVC

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
    [CommonFunction setNavToController:self title:@"Appeal Alert" isCrossBusston:false];
    [self setUpTableView];
}
-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}
#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"AppealAlertCell" bundle:nil]forCellReuseIdentifier:@"AppealAlertCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppealAlertCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"AppealAlertCell"];
    if (cell == nil) {
        cell = [[AppealAlertCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AppealAlertCell"];
    }
    
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TaskDetailVC *createTaskObj = [[TaskDetailVC alloc]initWithNibName:@"TaskDetailVC" bundle:nil];
//    [self.navigationController pushViewController:createTaskObj animated:true];
}

#pragma mark - btn Action

- (IBAction)btnAction_Add_Task:(id)sender {
    AppAppealVC *createTaskObj = [[AppAppealVC alloc]initWithNibName:@"AppAppealVC" bundle:nil];
    [self.navigationController pushViewController:createTaskObj animated:true];
}


@end
