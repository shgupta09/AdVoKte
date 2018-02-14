//
//  PostViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
{
    NSArray* arrTitles;
    NSArray* arrSubTitles;

}
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    arrTitles = [[NSArray alloc] initWithObjects:@"Whats's Happening",@"Publish an Article",@"Ask a question", nil];
    arrSubTitles = [[NSArray alloc] initWithObjects:@"Share your thoughts",@"Publish an interesting Article",@"Ask a leading question to the community and get answer", nil];

    [_tblView registerNib:[UINib nibWithNibName:@"PostMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"PostMainTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostMainTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"PostMainTableViewCell"];
    
    if (cell == nil) {
        cell = [[PostMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostMainTableViewCell"];
    }
    
    cell.lblTitle.text = [arrTitles objectAtIndex:indexPath.row];
    cell.lblSubtitle.text = [arrSubTitles objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
