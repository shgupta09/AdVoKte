//
//  RegisterStep1ViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 17/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "RegisterStep1ViewController.h"

@interface RegisterStep1ViewController ()
{
    LoderView *loderObj;
}
@end

@implementation RegisterStep1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cons_txtOTP_height.constant = 0;
    [self.navigationController setTitle:[NSString stringWithFormat:@"%@ Register",_userType]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

#pragma mark - Button Actions

- (IBAction)btnSendOTPClicked:(id)sender {
    if ([[_BtnSendOTP currentTitle]  isEqual: @"FINISH"]){
        [self hitApiToFinishRegistration];
    }
    else
    {
        [self hitApiToSendOTP];
    }
}


#pragma mark - TextField Delegate

//! for change the current first responder
//! @param: TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    UIResponder *nextResponder = [self.view viewWithTag:textField.tag+1];
    if(nextResponder){
        [nextResponder becomeFirstResponder];   //next responder found
    } else {
        [CommonFunction resignFirstResponderOfAView:self.view];
    }
    return NO;
}



#pragma mark - Api Related
-(void)hitApiToSendOTP{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    
    [dictRequest setValue:_txtMobile.text forKey:@"mobile"];
    
    [parameter setValue:dictRequest forKey:@"_user"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_OTP]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                if (1) {
                    
                    _cons_txtOTP_height.constant = 45;
                    [_BtnSendOTP setTitle:@"FINISH" forState:UIControlStateNormal];
                    
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

-(void)hitApiToFinishRegistration{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    
    [dictRequest setValue:_txtMobile.text forKey:@"mobile"];
    [dictRequest setValue:_txtMobile.text forKey:@"fname"];
    [dictRequest setValue:_txtMobile.text forKey:@"lname"];
    [dictRequest setValue:_txtMobile.text forKey:@"pass"];
    [dictRequest setValue:_txtMobile.text forKey:@"BarCodeId"];
    [dictRequest setValue:_txtMobile.text forKey:@"username"];

    [parameter setValue:dictRequest forKey:@"_user"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_OTP]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                if (1) {
                    
                    _cons_txtOTP_height.constant = 45;
                    [_BtnSendOTP setTitle:@"FINISH" forState:UIControlStateNormal];
                    
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
