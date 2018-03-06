//
//  SelectedLawyerVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/3/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "SelectedLawyerVC.h"
#import "ProfileCell.h"
@interface SelectedLawyerVC ()

@end

@implementation SelectedLawyerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"" isCrossBusston:false isAddRightButton:false];
    [_tblView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil]forCellReuseIdentifier:@"ProfileCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    if (cell == nil) {
        cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProfileCell"];
    }

    
    //    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.view.bounds];
    //    cell.view.layer.masksToBounds = NO;
    //    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;
    //    cell.view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    //    cell.view.layer.shadowOpacity = 0.5f;
    //    cell.view.layer.shadowPath = shadowPath.CGPath; UITableViewCellSelectionStyleNone;
    return cell;
}

@end
