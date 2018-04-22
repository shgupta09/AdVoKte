//
//  TaskListVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "TaskListVC.h"
#import "TaskListCell.h"
#import "CreateTaskVC.h"
#import "TaskDetailVC.h"
#import "Event.h"

@interface TaskListVC ()
{
    NSMutableArray* arrData;
    LoderView *loderObj;
}

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

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

#pragma mark- Navigation
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Task List" isCrossBusston:false];
    arrData = [[NSMutableArray alloc ] init];

    [self hitApiToGetAllTaskList];
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
    return [arrData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskListCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"TaskListCell"];
    if (cell == nil) {
        cell = [[TaskListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TaskListCell"];
    }
    cell.imgView_Profile.hidden = true;
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    Event* event = [arrData objectAtIndex:indexPath.row];
    
    cell.lblHeading.text = event.EventName;
    cell.lblDateRange.text = [NSString stringWithFormat:@"%@ - %@",event.StartAt,event.EndAt];
    cell.lblTimeRange.text = [NSString stringWithFormat:@"%@ - %@",event.StartTime,event.EndTime];
    cell.lblRange.text = event.Location;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskDetailVC *createTaskObj = [[TaskDetailVC alloc]initWithNibName:@"TaskDetailVC" bundle:nil];
    createTaskObj.eventObj = [arrData objectAtIndex:indexPath.row];;
    [self.navigationController pushViewController:createTaskObj animated:true];
}

#pragma mark - btn Action

- (IBAction)btnAction_Add_Task:(id)sender {
    CreateTaskVC *createTaskObj = [[CreateTaskVC alloc]initWithNibName:@"CreateTaskVC" bundle:nil];
    createTaskObj.isCreateTask = true;
    [self.navigationController pushViewController:createTaskObj animated:true];
}

#pragma mark - API related

-(void)hitApiToGetAllTaskList{
    
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_TASK_LIST]  postResponse:dict postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"objEvent"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Event *dataObj = [Event new];
                        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                            @try {
                                [dataObj setValue:obj forKey:(NSString *)key];
                                
                            } @catch (NSException *exception) {
                                NSLog(exception.description);
                                //  Handle an exception thrown in the @try block
                            } @finally {
                                //  Code that gets executed whether or not an exception is thrown
                            }
                        }];
                        
                        [arrData addObject:dataObj];
                    }];
                    [_tblView reloadData];
                }else
                {
                    //                    [self addAlertWithTitle:AlertKey andMessage:[responseObj valueForKey:@"message"] isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
                    [self removeloder];
                    //                    [self removeloder];
                }
                [self removeloder];
                
            }
            else
            {
                [self  removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];

            }
            
        }];
    } else {
        [self removeloder];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
    }
}


-(void)addLoder{
    self.view.userInteractionEnabled = NO;
    //  loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
    loderObj = [[LoderView alloc] initWithFrame:self.view.frame];
    loderObj.lbl_title.text = @"Please wait...";
    [self.view addSubview:loderObj];
}

-(void)removeloder{
    //loderObj = nil;
    [loderObj removeFromSuperview];
    //[loaderView removeFromSuperview];
    self.view.userInteractionEnabled = YES;
}

@end


