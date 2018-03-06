//
//  LawyerListVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LawyerListVC.h"
#import "ListCell.h"
#import "SelectedLawyerVC.h"
@interface LawyerListVC ()

@end

@implementation LawyerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"Tax Lawyer" isCrossBusston:false isAddRightButton:false];

    [_tblView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil]forCellReuseIdentifier:@"ListCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"ListCell"];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ListCell"];
    }
    cell.lblName.text = [cell.lblName.text uppercaseString];
    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.view.layer.shadowOffset = CGSizeMake( 0, 0);
    cell.view.layer.shadowOpacity = 0.4;
    cell.view.layer.shadowRadius = 4.0;
    [cell.lblEducation setText:@"N/A"];
    [cell.lblExperience setText:@"N/A"];
    [cell.lblSepcialization setText:@"N/A"];
    [cell.lblLocation setText:@"N/A"];
    [cell.lblCost setText:@"N/A"];
    
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.view.bounds];
//    cell.view.layer.masksToBounds = NO;
//    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;
//    cell.view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//    cell.view.layer.shadowOpacity = 0.5f;
//    cell.view.layer.shadowPath = shadowPath.CGPath; UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectedLawyerVC *lawyerVcOBJ = [[SelectedLawyerVC alloc]initWithNibName:@"SelectedLawyerVC" bundle:nil];
    [self.navigationController pushViewController:lawyerVcOBJ animated:true];
}


@end
