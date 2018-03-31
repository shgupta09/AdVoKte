//
//  ProfileVC.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/7/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"My Activity" isCrossBusston:false];
    [self setUpTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}


#pragma mark- tableView delegate
-(void)setUpTableView{
    [_tbl_View registerNib:[UINib nibWithNibName:@"FeedMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeedMainTableViewCell"];
    [_tbl_View registerNib:[UINib nibWithNibName:@"ProfileCell2" bundle:nil]forCellReuseIdentifier:@"ProfileCell2"];
    _tbl_View.rowHeight = UITableViewAutomaticDimension;
    _tbl_View.estimatedRowHeight = 100;
    _tbl_View.multipleTouchEnabled = NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ProfileCell2 *cell = [_tbl_View dequeueReusableCellWithIdentifier:@"ProfileCell2"];
        if (cell == nil) {
            cell = [[ProfileCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProfileCell2"];
        }
        return cell;
    }else{
    FeedMainTableViewCell *cell = [_tbl_View dequeueReusableCellWithIdentifier:@"FeedMainTableViewCell"];
    if (cell == nil) {
        cell = [[FeedMainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FeedMainTableViewCell"];
    }
        return cell;
    }
    
   ProfileCell2 *cell = [_tbl_View dequeueReusableCellWithIdentifier:@"ProfileCell2"];
    return cell;
}

@end
