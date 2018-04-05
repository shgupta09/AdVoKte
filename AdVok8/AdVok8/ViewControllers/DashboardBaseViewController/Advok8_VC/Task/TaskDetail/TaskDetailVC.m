//
//  TaskDetailVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "TaskDetailVC.h"
#import "CreateTaskVC.h"

@interface TaskDetailVC ()

@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark- Navigation
-(void)setUpData{
    NSArray *ar = [[NSArray alloc]initWithObjects:@"ds",@"sd", nil];
    [CommonFunction setNavToController:self title:@"Task" isCrossBusston:false rightNavArray:ar];
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rightBarAction:(id)sender{
    if (((UIBarButtonItem *)sender).tag == 0) {
        CreateTaskVC *createTaskObj = [[CreateTaskVC alloc]initWithNibName:@"CreateTaskVC" bundle:nil];
        createTaskObj.isCreateTask = false;
        [self.navigationController pushViewController:createTaskObj animated:true];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
