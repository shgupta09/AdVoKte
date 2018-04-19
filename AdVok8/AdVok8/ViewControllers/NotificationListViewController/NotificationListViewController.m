//
//  NotificationListViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 20/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "NotificationListViewController.h"

@interface NotificationListViewController (){
    NSMutableArray* arrData;
    LoderView *loderObj;
}

@end

@implementation NotificationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [CommonFunction setNavToController:self title:@"Notifications" isCrossBusston:false];

    [_tblView registerNib:[UINib nibWithNibName:@"NotificationTableViewCell" bundle:nil]forCellReuseIdentifier:@"NotificationTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];
    
    [self hitApiForAllNotifications];
    
    // [self hitApitoDelete];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationTableViewCell"];
    
    if (cell == nil) {
        cell = [[NotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NotificationTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Notification* data = [Notification new];
    data = [arrData objectAtIndex:indexPath.row];
    
    cell.lblHeading.text = data.message;
    [cell.imgViewProfilePic sd_setImageWithURL:[CommonFunction getProfilePicURLString:data.UserID]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        FeedDetailViewController* vc ;
        vc = [[FeedDetailViewController alloc] initWithNibName:@"FeedDetailViewController" bundle:nil];
        Notification* data = [arrData objectAtIndex:indexPath.row];
        vc.postId = data.PostID;
        UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
        [self.navigationController presentViewController:navCon animated:true completion:nil];
    
}

-(void)hitApiForAllNotifications{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    
    
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"username"];
    [dictRequest setValue:@"1" forKey:@"allnot"];
    
    [parameter setValue:dictRequest forKey:@"_User"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_NOTIFICATIONS]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"_Note"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Notification *dataObj = [Notification new];
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
            
            else {
                [self removeloder];
                //        [self addAlertWithTitle:AlertKey andMessage:Network_Issue_Message isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
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


-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
}


@end

