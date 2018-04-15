//
//  AppealAlertVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppealAlertVC.h"
#import "AppealAlertCell.h"
#import "AppAppealVC.h"
#import "AppealAlertVC.h"
#import "AppealAlert.h"

@interface AppealAlertVC (){
    NSMutableArray* arrData;
    LoderView *loderObj;
}

@end

@implementation AppealAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    arrData = [[NSMutableArray alloc ] init];

    [self hitApiToGetAllAppealAlert];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Appeal Alert" isCrossBusston:false];
    [self setUpTableView];
}
-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}
#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"AppealAlertCell" bundle:nil]forCellReuseIdentifier:@"AppealAlertCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([arrData count]>0) {
        _lbl_NoData.hidden = true;
    }else{
        _lbl_NoData.hidden = false;
    }
    return [arrData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppealAlertCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"AppealAlertCell"];
    if (cell == nil) {
        cell = [[AppealAlertCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AppealAlertCell"];
    }
    
    AppealAlert* dataObj = [arrData objectAtIndex:indexPath.row];
    
    cell.lbltopLeft.text = dataObj.CourtName;
    cell.lblBottomLeft.text = dataObj.CaseType;
    cell.lblBottomRight.text = [NSString stringWithFormat:@"%@/%@", dataObj.CaseNo,dataObj.CaseYear];
    
    
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.btnDelete.tag = indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)delete:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure you want to delete this record?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self hitApiTodeleteAppealAlert:((UIButton *)sender).tag];
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];

    [alertController addAction:ok];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TaskDetailVC *createTaskObj = [[TaskDetailVC alloc]initWithNibName:@"TaskDetailVC" bundle:nil];
//    [self.navigationController pushViewController:createTaskObj animated:true];
}

#pragma mark - btn Action

- (IBAction)btnAction_Add_Task:(id)sender {
    AppAppealVC *createTaskObj = [[AppAppealVC alloc]initWithNibName:@"AppAppealVC" bundle:nil];
    [self.navigationController pushViewController:createTaskObj animated:true];
}


#pragma mark - API related

-(void)hitApiToGetAllAppealAlert{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];

    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"userId"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_APPEAL_ALERTS]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    tempArray = [json objectForKey:@"Data"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        AppealAlert *dataObj = [AppealAlert new];
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

-(void)hitApiTodeleteAppealAlert:(NSInteger )selectedIndex{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    
    [parameter setValue:((AppealAlert *)[arrData objectAtIndex:selectedIndex]).AppealId forKey:@"AppealId"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_Delete_APPEAL_ALERT]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[json valueForKey:@"ErrorMessage"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
                    [arrData removeObjectAtIndex:selectedIndex];
                    [_tblView reloadData];
                }else
                {
                    //                    [self addAlertWithTitle:AlertKey andMessage:[responseObj valueForKey:@"message"] isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
                    [self removeloder];
                    //                    [self removeloder];
                }
                [self removeloder];
                
            }else{
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
