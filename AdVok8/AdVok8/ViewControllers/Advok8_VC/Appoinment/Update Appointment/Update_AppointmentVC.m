//
//  Update_AppointmentVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/16/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "Update_AppointmentVC.h"

@interface Update_AppointmentVC (){
    LoderView *loderObj;

}

@end

@implementation Update_AppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Navigation
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Update Appoinment" isCrossBusston:false];
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark - btnAction

- (IBAction)btnAction_Udate:(id)sender {
    if (_txt_appointment.text.length>0) {
        [self hitApiToUpdate];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Note can't be blank" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)btnAction_Terms:(id)sender {
    if (_btn_Terms.isSelected) {
        [_btn_Terms setSelected:false];
    }else{
        [_btn_Terms setSelected:true];
    }
}


#pragma mark - Hit Api
-(void)hitApiToUpdate{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    
    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    [parameter setValue:_data.AppId forKey:@"appId"];
    [parameter setObject:_txt_appointment.text forKey:@"appNotes"];
    if (_btn_Terms.isSelected) {
        [parameter setObject:@"1" forKey:@"st"];
    }else{
        [parameter setObject:@"0" forKey:@"st"];
    }
    NSMutableDictionary *parameterDict = [NSMutableDictionary new];
    [parameterDict setValue:parameter forKey:@"_AN"];
    NSString* apiHitName = @"Ins_AppNotes";
    
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,apiHitName]  postResponse:parameterDict postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    [self.navigationController popViewControllerAnimated:true];
                }else
                {
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    [self removeloder];
                    //                    [self removeloder];
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
