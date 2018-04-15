//
//  AppAppealVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppAppealVC.h"
#import "RegCaseCourt.h"
@interface AppAppealVC (){
    UIDatePicker* pickerForDate;
    NSDate *startDate;
    NSString *startDateString;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
    LoderView *loderObj;
    NSMutableArray *courtDataArray;
    NSMutableArray *caseTypeArray;
    UIPickerView *pickerObj;
    NSArray *pickerArray;
}

@end

@implementation AppAppealVC

- (void)viewDidLoad {
    [super viewDidLoad];
       [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark- Navigation
-(void)setUpData{
        [CommonFunction setNavToController:self title:@"Appeal alert" isCrossBusston:false];
        [self setDefaultDate];
        [self hitApiToGetAllCourt];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}
#pragma mark- Btn Action
- (IBAction)btnAction_Date:(id)sender {
    [self showDatePicker:sender];
}
- (IBAction)btnAction_Save:(id)sender {
    
}
- (IBAction)btnAcion_picker:(id)sender {
    [self addPickerViewWithTag:((UIButton *)sender).tag];
}
#pragma mark- Date Picker


//Resign Responder
-(void)resignResponder{
    [viewOverPicker removeFromSuperview];
}
// Set the default date
-(void)setDefaultDate{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    startDateString = [dateFormatter stringFromDate:[NSDate date]];
    startDate = [NSDate date];
   
    _txt_DateOfJudgement.text = startDateString;
}
// Show the date picker
-(void)showDatePicker:(id)sender{
    pickerForDate = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    pickerForDate.tag = ((UIButton *)sender).tag;
   
        pickerForDate.datePickerMode = UIDatePickerModeDate;
        [pickerForDate setDate:startDate];
   
    //    [pickerForDate setMinimumDate: [NSDate date]];
    [pickerForDate addTarget:self action:@selector(dueDateChanged:)
            forControlEvents:UIControlEventValueChanged];
    viewOverPicker = [[UIView alloc]initWithFrame:self.view.frame];
    pickerForDate.backgroundColor = [UIColor lightGrayColor];
    viewOverPicker.backgroundColor = [UIColor clearColor];
    [CommonFunction setResignTapGestureToView:viewOverPicker andsender:self];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(doneForPicker:)];
    doneButton.tintColor = [CommonFunction colorWithHexString:@"f7a41e"];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar = [[UIToolbar alloc]initWithFrame:
               CGRectMake(0, self.view.frame.size.height-
                          pickerForDate.frame.size.height-50, self.view.frame.size.width, 50)];
    //    [toolBar setBarTintColor:[UIColor redColor]];
    
    
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:space,
                             space,doneButton, nil];
    [toolBar setItems:toolbarItems];
    [viewOverPicker addSubview:pickerForDate];
    [viewOverPicker addSubview:toolBar];
    [self.view addSubview:viewOverPicker];
    
    
}
-(void)doneForPicker:(id)sender{
    [viewOverPicker removeFromSuperview];
}
// value change of the date picker
-(void) dueDateChanged:(UIDatePicker *)sender {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
            
            //self.myLabel.text = [dateFormatter stringFromDate:[dueDatePickerView date]];
            NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
            [dateFormatter setDateFormat:@"dd/MM/YYYY"];
            if (sender.tag == 0) {
                
                startDateString = [dateFormatter stringFromDate:[sender date]];
                startDate = sender.date;
                _txt_DateOfJudgement.text = startDateString;
           
    }
}



#pragma mark - API related

-(void)hitApiToInsertAppealAlert{
    
//    NSMutableDictionary *parameter = [NSMutableDictionary new];
//
//    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"userId"];
//
//    if ([ CommonFunction reachability]) {
//        [self addLoder];
//
//        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
//        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_APPEAL_ALERTS]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
//            if (error == nil) {
//                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
//                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//
//                [self removeloder];
//                NSNumber* st = [json valueForKey:@"Status"];
//                int status = [st intValue];
//                if ( status == 1) {
//                    NSArray *tempArray = [NSArray new];
//                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
//                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                    tempArray = [json objectForKey:@"Data"];
//                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                        AppealAlert *dataObj = [AppealAlert new];
//                        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
//                            @try {
//                                [dataObj setValue:obj forKey:(NSString *)key];
//
//                            } @catch (NSException *exception) {
//                                NSLog(exception.description);
//                                //  Handle an exception thrown in the @try block
//                            } @finally {
//                                //  Code that gets executed whether or not an exception is thrown
//                            }
//                        }];
//
//                        [arrData addObject:dataObj];
//                    }];
//                    [_tblView reloadData];
//                }else
//                {
//                    //                    [self addAlertWithTitle:AlertKey andMessage:[responseObj valueForKey:@"message"] isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
//                    [self removeloder];
//                    //                    [self removeloder];
//                }
//                [self removeloder];
//
//            }
//
//        }];
//    } else {
//        [self removeloder];
//        //        [self addAlertWithTitle:AlertKey andMessage:Network_Issue_Message isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
//    }
}
#pragma mark - API related

-(void)hitApiToGetAllCourt{
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_Court]  postResponse:nil postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                
                    NSArray *tempArray = [NSArray new];
                    courtDataArray = [NSMutableArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = (NSArray *)json;
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        RegCaseCourt *dataObj = [RegCaseCourt new];
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

                        [courtDataArray addObject:dataObj];
                    }];
                
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

-(void)hitApiToGetAllCaseType{
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_Court]  postResponse:nil postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    courtDataArray = [NSMutableArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"Data"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        RegCaseCourt *dataObj = [RegCaseCourt new];
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
                        
                        [courtDataArray addObject:dataObj];
                    }];
                }else{
                    [self removeloder];
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
#pragma mark - Picker View Data source
// Add picker View
-(void)addPickerViewWithTag:(NSInteger)tagForPicker{
    pickerObj = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    pickerObj.delegate = self;
    pickerObj.dataSource = self;
    pickerObj.showsSelectionIndicator = YES;
    pickerObj.backgroundColor = [UIColor lightGrayColor];
    pickerObj.tag = tagForPicker;
    viewOverPicker = [[UIView alloc]initWithFrame:self.view.frame];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     pickerObj.frame.size.height-50, self.view.frame.size.width, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    UIToolbar *toolBarForTitle;
    if (tagForPicker == 0) {
        pickerArray = [courtDataArray mutableCopy];
    }else{
        pickerArray = [caseTypeArray mutableCopy];
    }
   
    
    
    
    viewOverPicker.backgroundColor = [UIColor clearColor];
    [CommonFunction setResignTapGestureToView:viewOverPicker andsender:self];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(doneForPicker:)];
    doneButton.tintColor = [CommonFunction colorWithHexString:@"f7a41e"];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    

    UITextField *txtView=[[UITextField alloc]initWithFrame:CGRectMake(0, 0 , toolBar.frame.size.width-50, toolBar.frame.size.height)];
    txtView.backgroundColor =[UIColor  redColor];
    txtView.placeholder=@"Search";
    txtView.tag = tagForPicker;
    UIBarButtonItem *textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:txtView];

    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             space,doneButton,space,textFieldItem, nil];
    pickerObj.hidden = false;
    [toolBar setItems:toolbarItems];
    [viewOverPicker addSubview:toolBar];
    [viewOverPicker addSubview:pickerObj];
    [self.view addSubview:viewOverPicker];
    [pickerObj reloadAllComponents];
}


#pragma picker - data Source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}


#pragma mark - Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 0) {
        _txt_CourtName.text = ((RegCaseCourt *)[pickerArray objectAtIndex:row]).CourtName;
    }else{
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView.tag == 0) {
        
        return ((RegCaseCourt *)[pickerArray objectAtIndex:row]).CourtName;

    }else{
        return @"";
    }
    return @"";

}


@end
