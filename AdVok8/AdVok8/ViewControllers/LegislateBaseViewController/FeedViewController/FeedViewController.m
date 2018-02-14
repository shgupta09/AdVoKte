//
//  FeedViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tblView registerNib:[UINib nibWithNibName:@"FeedMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeedMainTableViewCell"];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedMainTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"FeedMainTableViewCell"];
    
    if (cell == nil) {
        cell = [[FeedMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedMainTableViewCell"];
    }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



@end
