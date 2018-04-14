//
//  AppointmentListViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 05/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppointmentListViewController.h"
#import "AppoinmentDetailVC.h"

@interface AppointmentListViewController (){
    NSMutableArray* arrData;
    LoderView *loderObj;
}

@end

@implementation AppointmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonFunction setNavToController:self title:@"Appointment" isCrossBusston:false];

    [_tblView registerNib:[UINib nibWithNibName:@"AppointmentListTableViewCell" bundle:nil]forCellReuseIdentifier:@"AppointmentListTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];
    
//    [self hitApiForAllPosts:@"0"];
    
     [self hitApiToGetAllAppointment];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentListTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentListTableViewCell"];
    
    if (cell == nil) {
        cell = [[AppointmentListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppointmentListTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Appointment* data = [Appointment new];
    data = [arrData objectAtIndex:indexPath.row];

    cell.lblUserName.text = data.fname;
    cell.lblDate.text = data.date;
    cell.lblTime.text = data.time;
    cell.lblStatus.text = data.Status;


    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_fromDashboard isEqualToString:@"Advocate"]){
        AppoinmentDetailVC *createTaskObj = [[AppoinmentDetailVC alloc]initWithNibName:@"AppoinmentDetailVC" bundle:nil];
        [self.navigationController pushViewController:createTaskObj animated:true];
    }
    else
    {
        
    }
}
//


#pragma mark - API related

-(void)hitApiToGetAllAppointment{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    [dict setValue:@"history" forKey:@"type"];
    
    [parameter setObject:dict forKey:@"_user"];
    
    NSString* apiHitName = @"";
    if ([[CommonFunction getValueFromDefaultWithKey:@"loginUsertype"]  isEqual:@"advocate"]&&[CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        apiHitName = @"get_AdvocateAppointment";
        NSMutableDictionary* dict = [NSMutableDictionary new];
        [dict setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"username"];
        
        [parameter setObject:dict forKey:@"_adv"];
    }
    else
    {
        apiHitName = API_GET_ALL_APPOINTMENTS_USER;
        NSMutableDictionary* dict = [NSMutableDictionary new];
        [dict setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
        [dict setValue:@"history" forKey:@"type"];
        
        [parameter setObject:dict forKey:@"_user"];

    }
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,apiHitName]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                       tempArray = [json objectForKey:@"app"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Appointment *dataObj = [Appointment new];
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
            
        }];
    } else {
        [self removeloder];
        //        [self addAlertWithTitle:AlertKey andMessage:Network_Issue_Message isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
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
