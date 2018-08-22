//
//  JournalViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "JournalViewController.h"

@interface JournalViewController ()
{
NSArray* arrCategories;
}
@end

@implementation JournalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrCategories = [[NSArray alloc] initWithObjects:@"Tax",@"Criminal",@"Civil",@"Marriage",@"Divorce",@"Company",@"Constitutional",@"Immigration",@"Trademark",@"Human Rights",@"Media and Entertainment",@"Sports",@"Environment",@"Consumer",@"Industrial and Labour",@"Insurance",@"Family",@"Arbitration",@"Property",@"Traffic and Accident",@"Document Drafting",@"Cheque Bounce", nil];
    
    [_tblView registerNib:[UINib nibWithNibName:@"JournalMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"JournalMainTableViewCell"];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrCategories.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JournalMainTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"JournalMainTableViewCell"];
    
    if (cell == nil) {
        cell = [[JournalMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JournalMainTableViewCell"];
    }
    
    cell.lblTitle.text = [arrCategories objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JournalFeedsViewController* vc ;
    vc = [[JournalFeedsViewController alloc] initWithNibName:@"JournalFeedsViewController" bundle:nil];
    vc.postSubType = [arrCategories objectAtIndex:indexPath.row];
    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
    [self.navigationController presentViewController:navCon animated:true completion:nil];

}


@end
