//
//  AdvocateProfileContainerViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateProfileContainerViewController.h"
#import "AdvocateProfileTabViewController.h"
#import "AdvocateAvailabilityTabViewController.h"
#import "AdvocateAchievementTabViewController.h"


@interface AdvocateProfileContainerViewController ()
{
    NSString* currentTabName;
    LoderView* loderObj;
    
}
@end

@implementation AdvocateProfileContainerViewController
ADRegistrationModel* global_advocate_profileObj;
NSMutableArray* arr_global_advocate_Education_data;
NSMutableArray* arr_global_advocate_WorkingExperience_data;
NSMutableArray* arr_global_advocate_Membership_data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonFunction setNavToController:self title:@"Advocate Profile" isCrossBusston:NO];
    [self resetTabs];
   
    self.cons_activeTab.constant = -self.btnProfile.bounds.size.width;
    
    [self hitApiToGetAdvocateData];
    [self hitApiToGetAcheivementData];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}

-(void) resetTabs {
   
    
    
}

- (IBAction)btnTabsPressed:(id)sender {
    UIButton* btn = (UIButton*) sender;
    switch (btn.tag) {
        case 100:
        {
            NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
            
             self.cons_activeTab.constant = -self.btnProfile.bounds.size.width;
            
                [userInfo setValue:[AdvocateProfileTabViewController new] forKey:@"ActiveViewController"];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_Switch_To_Profile_Page" object:self userInfo:userInfo];
            
        }
            break;
        case 101:
        {
            NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
            
            self.cons_activeTab.constant = 0;
                
            [userInfo setValue:[AdvocateAvailabilityTabViewController new] forKey:@"ActiveViewController"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_Switch_To_Availability" object:self userInfo:userInfo];
        }
            break;
        case 102:
        {
            NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
                    self.cons_activeTab.constant = self.btnProfile.bounds.size.width;
                [userInfo setValue:[AdvocateAchievementTabViewController new] forKey:@"ActiveViewController"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_Switch_To_Achievement" object:self userInfo:userInfo];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - API related

-(void)hitApiToGetAdvocateData{
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    NSMutableDictionary* parameter = [NSMutableDictionary new];

    [parameter setObject:dictRequest forKey:@"_user"];
    
    if ([ CommonFunction reachability]) {
                [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ADVOCATE_PROFILE]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    //Details Data
                    NSDictionary* userData = [[json valueForKey:@"_adr"] objectAtIndex:0];
                    
                    ADRegistrationModel *dataObj = [ADRegistrationModel new];
                    [userData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                        @try {
                            [dataObj setValue:obj forKey:(NSString *)key];
                        } @catch (NSException *exception) {
                            NSLog(exception.description);
                            //  Handle an exception thrown in the @try block
                        } @finally {
                            //  Code that gets executed whether or not an exception is thrown
                        }
                    }];
                    
                    global_advocate_profileObj = dataObj;
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Refresh_Profile_Availability_Data" object:nil];

                    
                }else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
                    [self removeloder];
                }
                [self removeloder];
                
            }
            else
            {
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
            }
        }];
    } else {
        [self removeloder];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
    }
}

-(void)hitApiToGetAcheivementData{
    
    Rating *ratingObj = [Rating new];
    
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"Username"];
    NSMutableDictionary* parameter = [NSMutableDictionary new];
    
    [parameter setObject:dictRequest forKey:@"_user"];
    
    if ([ CommonFunction reachability]) {
        [self removeloder];
                [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ACHEIVEMENT]  postResponse:dictRequest postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSMutableArray* arrData = [NSMutableArray new];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 0) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"_Education"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Education *dataObj = [Education new];
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
                    
                    arr_global_advocate_Education_data = arrData;
                    
                    arrData = [NSMutableArray new];
                    tempArray = [NSArray new];
                    data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"_WorkingExperience"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        WorkingExperience *dataObj = [WorkingExperience new];
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
                    
                    arr_global_advocate_WorkingExperience_data = arrData;
                    
                    arrData = [NSMutableArray new];
                    tempArray = [NSArray new];
                    data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"_Membership"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Membership *dataObj = [Membership new];
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
                    
                    arr_global_advocate_Membership_data = arrData;
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_refresh_Acheivement_data" object:nil];

                    
                }else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
                    [self removeloder];
                }
                [self removeloder];
                
            }
            else
            {
                [self removeloder];
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

