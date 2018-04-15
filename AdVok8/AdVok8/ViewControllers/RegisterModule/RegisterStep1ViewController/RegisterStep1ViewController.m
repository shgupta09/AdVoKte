//
//  RegisterStep1ViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 17/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "RegisterStep1ViewController.h"
#define BoolValueKey @"BoolValue"
#define AlertKey @"Alert"

@interface RegisterStep1ViewController ()<UITextFieldDelegate>
{
    LoderView *loderObj;
    NSString* otpServer;
    NSTimer *timer;
    int currMinute;
    int currSeconds;
    UILabel* lblTimer;
    UILabel* lblMatched;

}
@end

@implementation RegisterStep1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cons_txtOTP_height.constant = 0;
    self.navigationController.navigationItem.title = [NSString stringWithFormat:@"%@ Register",_userType];
    
    _txtEnterOTP.rightViewMode = UITextFieldViewModeAlways;
    
    lblTimer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    lblMatched = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [lblMatched setText:@"Matched"];

    [lblTimer setText:@"30:00"];
    [lblTimer setFont:[UIFont systemFontOfSize:13.0f]];
    lblTimer.textColor = [UIColor redColor];
    [lblMatched setFont:[UIFont systemFontOfSize:13.0f]];
    lblMatched.textColor = [UIColor redColor];
    _txtEnterOTP.rightView = lblTimer;
    currMinute=30;
    currSeconds=00;
    // Do any additional setup after loading the view from its nib.
}



-(void)start
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}
-(void)timerFired
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
            [lblTimer setText:[NSString stringWithFormat:@"%@%d%@%02d",@"",currMinute,@":",currSeconds]];
    }
    else
    {
        
        [timer invalidate];
    }
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
        NSDictionary *dictForValidation = [self validateData];
        if (![[dictForValidation valueForKey:BoolValueKey] isEqualToString:@"0"]){
            NSLog(@"Successful");
            [CommonFunction resignFirstResponderOfAView:self.view];
            [self hitApiToFinishRegistration];
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[dictForValidation valueForKey:AlertKey] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
    else
    {
        NSDictionary *dictForValidation = [self validateData];
        if (![[dictForValidation valueForKey:BoolValueKey] isEqualToString:@"0"]){
            NSLog(@"Successful");
            [CommonFunction resignFirstResponderOfAView:self.view];
            [self hitApiToSendOTP];
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[dictForValidation valueForKey:AlertKey] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

#pragma mark -other


-(NSDictionary *)validateData{
    NSMutableDictionary *validationDict = [[NSMutableDictionary alloc] init];
    [validationDict setValue:@"1" forKey:BoolValueKey];
    if (![CommonFunction validateName:_txtFirstName.text]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        if ([CommonFunction trimString:_txtFirstName.text].length == 0){
            [validationDict setValue:@"We need a First Name" forKey:AlertKey];
        }else{
            [validationDict setValue:@"Oops! It seems that this is not a valid First Name." forKey:AlertKey];
        }
        
    }
    
//    else if (![CommonFunction validateName:_txtLastName.text]){
//        [validationDict setValue:@"0" forKey:BoolValueKey];
//        if ([CommonFunction trimString:_txtLastName.text].length == 0){
//            [validationDict setValue:@"We need a Last Name" forKey:AlertKey];
//        }else{
//            [validationDict setValue:@"Oops! It seems that this is not a valid Last Name." forKey:AlertKey];
//        }
//
//    }
//    else if ([CommonFunction trimString:_txtDOB.text].length == 0){
//        [validationDict setValue:@"0" forKey:BoolValueKey];
//        [validationDict setValue:@"We need a Date" forKey:AlertKey];
//    }
//    else if ([CommonFunction trimString:_txtGender.text].length == 0){
//        [validationDict setValue:@"0" forKey:BoolValueKey];
//        [validationDict setValue:@"We need a Date" forKey:AlertKey];
//    }
    
    else if(![CommonFunction validateEmailWithString:_txtEmailAddress.text]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        if ([CommonFunction trimString:_txtEmailAddress.text].length == 0) {
            [validationDict setValue:@"We need an Email ID" forKey:AlertKey];
        }
        else{
            [validationDict setValue:@"Oops! It seems that this is not a valid Email ID." forKey:AlertKey];
        }
    }
    
    else if(![CommonFunction validateMobile:_txtMobile.text]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        if ([CommonFunction trimString:_txtMobile.text].length == 0) {
            [validationDict setValue:@"We need a Mobile Number" forKey:AlertKey];
        }
        else{
            [validationDict setValue:@"Oops! It seems that this is not a valid Mobile Number." forKey:AlertKey];
        }
        
    }
//    else if(![CommonFunction validateMobile:_txtpSecondary.text]){
//        [validationDict setValue:@"0" forKey:BoolValueKey];
//        if ([CommonFunction trimString:_txtpSecondary.text].length == 0) {
//            [validationDict setValue:@"We need a Secondary Mobile Number" forKey:AlertKey];
//        }
//        else{
//            [validationDict setValue:@"Oops! It seems that this is not a valid Secondary Mobile Number." forKey:AlertKey];
//        }
//
//    }
    else if(![CommonFunction isValidPassword:[CommonFunction trimString:_txtPassword.text]] ){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        if ([CommonFunction trimString:_txtPassword.text].length == 0) {
            [validationDict setValue:@"We need a Password" forKey:AlertKey];
        }
        else{
            [validationDict setValue:@"Incorrect Password. Password must have minimum 4 characters" forKey:AlertKey];
        }
        
        
    }
    
//    else if(![CommonFunction isValidPassword:[CommonFunction trimString:_txtEnterOTP.text]] ){
//        [validationDict setValue:@"0" forKey:BoolValueKey];
//        if ([CommonFunction trimString:_txtEnterOTP.text].length == 0) {
//            [validationDict setValue:@"We need an OTP" forKey:AlertKey];
//        }
//        else{
//            [validationDict setValue:@"We need an OTP." forKey:AlertKey];
//        }
//
//
//    }
    return validationDict.mutableCopy;
    
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
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    TextFieldBaselineWithLeftRight* txtField = (TextFieldBaselineWithLeftRight*)textField;
    
    
    if (textField.tag == 105) {
   
        if (![string  isEqual: @""]){
            
            if([NSString stringWithFormat:@"%@%@",textField.text,string] == [NSString stringWithFormat:@"%@",otpServer]){
                _txtEnterOTP.rightView = lblMatched;
            }
            else{
                _txtEnterOTP.rightView = lblTimer;
            }
            
        }
        else
        {
            if([textField.text substringToIndex:[textField.text length] - 1] == [NSString stringWithFormat:@"%@",otpServer]){
                _txtEnterOTP.rightView = lblMatched;
            }
            else{
                _txtEnterOTP.rightView = lblTimer;
            }
        }
    }
    
//    NSUInteger intTemp = txtField.maxCharLimit.unsignedIntegerValue;
    if ([string  isEqual: @""]) {
        return true;

    }
    if (txtField.maxCharLimit>=[[NSString stringWithFormat:@"%@%@",textField.text,string] length] ){
        return true;
    }
    else{
        return false;
    }
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
                
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

                [self removeloder];

                if ([[json valueForKey:@"ErrMsg"]  isEqual: @""]){
                    _cons_txtOTP_height.constant = 45;
                    [_BtnSendOTP setTitle:@"FINISH" forState:UIControlStateNormal];
                    otpServer = [json valueForKey:@"count"];
                    [self start];
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];

                }
            
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
    [dictRequest setValue:_txtFirstName.text forKey:@"fname"];
    [dictRequest setValue:@"" forKey:@"lname"];
    [dictRequest setValue:_txtPassword.text forKey:@"pass"];
    [dictRequest setValue:_txtEnterOTP.text forKey:@"BarCodeId"];
    [dictRequest setValue:_txtEmailAddress.text forKey:@"username"];

    [parameter setValue:dictRequest forKey:@"_user"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_REGISTER_USER]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                
                if ([[json valueForKey:@"ErrMsg"]  isEqual: @""]){

                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
                        [self.navigationController dismissViewControllerAnimated:true completion:nil];
                    }];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];

                    
                }else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
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
