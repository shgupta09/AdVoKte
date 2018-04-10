//
//  AppointmentListViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 05/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppointmentListViewController.h"

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
    
    Case* data = [Case new];
    data = [arrData objectAtIndex:indexPath.row];

    cell.lblUserName.text = data.PetitionerName;
    cell.lblDate.text = data.upcominghearingDate;
    cell.lblTime.text = data.upcominghearingDate;
    cell.lblStatus.text = data.st;


    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//


#pragma mark - API related

-(void)hitApiToGetAllAppointment{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:@"" forKey:@"advid"];
    [dict setValue:@"Pending" forKey:@"st"];
    
    [parameter setObject:dict forKey:@"_case"];
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_CASE_LIST]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    tempArray = [json objectForKey:@"_special"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Case *dataObj = [Case new];
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
