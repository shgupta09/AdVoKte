//
//  LoginViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LoginViewController.h"
#define BoolValueKey @"BoolValue"
#define AlertKey @"Alert"

@interface LoginViewController ()
{
    LoderView* loderObj;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self hitApiToDeleteUSer];
  //  _txtUsername.text = @"9643965767";
    //_txtPassword.text = @"Admin@123";
    
    
    [CommonFunction setNavToController:self title:@"Login" isCrossBusston:false];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Button Actions
- (void)backTapped {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)decodeButton:(id)sender {
    
    if (_sc_userType.selectedSegmentIndex == 0) {
        _txtUsername.text = @"9560409501";
        _txtPassword.text = @"123456";
    } else if(_sc_userType.selectedSegmentIndex == 1) {
        _txtUsername.text = @"8896292603";
        _txtPassword.text = @"123456";
    }
}


- (IBAction)btnLoginClicked:(id)sender {
    NSDictionary *dictForValidation = [self validateData];
    if (![[dictForValidation valueForKey:BoolValueKey] isEqualToString:@"0"]){
        NSLog(@"Successful");
        [CommonFunction resignFirstResponderOfAView:self.view];
        [self hitApiToLogin];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[dictForValidation valueForKey:AlertKey] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (IBAction)btnRegister:(id)sender {
    ChooseTypeViewController* vc = [[ChooseTypeViewController alloc] initWithNibName:@"ChooseTypeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)hitApiToLogin{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    
    [dictRequest setValue:_txtUsername.text forKey:@"username"];
    [dictRequest setValue:_txtPassword.text forKey:@"password"];
    if (_sc_userType.selectedSegmentIndex == 0 ) {
        [dictRequest setValue:@"user" forKey:@"type"];
    }
    else
    {
        [dictRequest setValue:@"advocate" forKey:@"type"];
    }

    [parameter setValue:dictRequest forKey:@"_user"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_LOGIN]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
                    
                    if (_sc_userType.selectedSegmentIndex == 0 ) {
                        NSDictionary* userData = [[json valueForKey:@"user"] objectAtIndex:0];
                        
                        User *dataObj = [User new];
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
                        
                        [CommonFunction storeValueInDefault:LOGINUSER_UR andKey:LOGINUSER_TYPE];
                        [CommonFunction storeValueInDefault:dataObj.ContactNo andKey:LOGINUSER];
                        [CommonFunction stroeBoolValueForKey:isLoggedIn withBoolValue:true];
                        [CommonFunction persistObjAsData:dataObj forKey:USERDATA];
                        [CommonFunction storeValueInDefault:[NSString stringWithFormat:@"%@",dataObj.FirstName] andKey:@"DisplayName"];
                    }
                    else
                    {
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
                        
                        
                        [CommonFunction storeValueInDefault:dataObj.username andKey:LOGINUSER];
                        [CommonFunction stroeBoolValueForKey:isLoggedIn withBoolValue:true];
                        [CommonFunction storeValueInDefault:LOGINUSER_AD andKey:LOGINUSER_TYPE];
                        [CommonFunction storeValueInDefault:dataObj.PractiseArea andKey:@"PractiseArea"];
                        [CommonFunction storeValueInDefault:[NSString stringWithFormat:@"%@ %@",dataObj.fname,dataObj.lname] andKey:@"DisplayName"];
                         
                    }
                    
                    
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
                        [self.navigationController dismissViewControllerAnimated:true completion:^{
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshViews" object:nil];
                        }];
                    }];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                    
                    
                }else
                {
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];

                    
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

#pragma mark -other


-(NSDictionary *)validateData{
    NSMutableDictionary *validationDict = [[NSMutableDictionary alloc] init];
    [validationDict setValue:@"1" forKey:BoolValueKey];
    
    if(![CommonFunction validateMobile:_txtUsername.text]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        if ([CommonFunction trimString:_txtUsername.text].length == 0) {
            [validationDict setValue:@"We need a Username" forKey:AlertKey];
        }
        else{
            [validationDict setValue:@"Oops! It seems that this is not a valid Username." forKey:AlertKey];
        }
        
    }
    else if(![CommonFunction isValidPassword:[CommonFunction trimString:_txtPassword.text]] ){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        if ([CommonFunction trimString:_txtPassword.text].length == 0) {
            [validationDict setValue:@"We need a Password" forKey:AlertKey];
        }
        else{
            [validationDict setValue:@"Incorrect Password. The correct password must have a minimum of 8 characters; with at least one character in upper case and at least one special character or number." forKey:AlertKey];
        }
        
        
    }

    return validationDict.mutableCopy;
    
}


#pragma mark - Garvbage

-(void)hitApiToDeleteUSer{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    
    [dictRequest setValue:@"8810307173" forKey:@"username"];
//    [dictRequest setValue:_txtPassword.text forKey:@"password"];
    
    
    [parameter setValue:dictRequest forKey:@"_loginmodel"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_DeleteUser]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
                    
                    if (_sc_userType.selectedSegmentIndex == 0 ) {
                        NSDictionary* userData = [[json valueForKey:@"user"] objectAtIndex:0];
                        
                        User *dataObj = [User new];
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
                        
                        [CommonFunction storeValueInDefault:LOGINUSER_UR andKey:LOGINUSER_TYPE];
                        [CommonFunction storeValueInDefault:dataObj.ContactNo andKey:LOGINUSER];
                        [CommonFunction stroeBoolValueForKey:isLoggedIn withBoolValue:true];
                        [CommonFunction persistObjAsData:dataObj forKey:USERDATA];
                        [CommonFunction storeValueInDefault:[NSString stringWithFormat:@"%@",dataObj.FirstName] andKey:@"DisplayName"];
                    }
                    else
                    {
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
                        
                        
                        [CommonFunction storeValueInDefault:dataObj.username andKey:LOGINUSER];
                        [CommonFunction stroeBoolValueForKey:isLoggedIn withBoolValue:true];
                        [CommonFunction storeValueInDefault:LOGINUSER_AD andKey:LOGINUSER_TYPE];
                        [CommonFunction storeValueInDefault:dataObj.PractiseArea andKey:@"PractiseArea"];
                        [CommonFunction storeValueInDefault:[NSString stringWithFormat:@"%@ %@",dataObj.fname,dataObj.lname] andKey:@"DisplayName"];
                        
                    }
                    
                    
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
                        [self.navigationController dismissViewControllerAnimated:true completion:^{
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshViews" object:nil];
                        }];
                    }];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                    
                    
                }else
                {
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    
                    
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



@end
