//
//  AppAppealVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppAppealVC.h"
#import "RegCaseCourt.h"
#import "RegCaseType.h"
@interface AppAppealVC (){
    UIDatePicker* pickerForDate;
    NSDate *startDate;
    NSString *startDateString;
    NSString *dateToSend;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
    LoderView *loderObj;
    NSMutableArray *courtDataArray;
    NSMutableArray *caseTypeArray;
    UIPickerView *pickerObj;
    NSArray *pickerArray;
    RegCaseCourt *selectedCourt;
    RegCaseType *selectedType;
    CGSize keyboardSize;
    BOOL isKeyBoardShown;

    
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
        isKeyBoardShown = false;
        [CommonFunction setNavToController:self title:@"Appeal alert" isCrossBusston:false];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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


#pragma mark - keyboard movements

- (void)keyboardWillShow:(NSNotification *)notification{
    isKeyBoardShown = true;
    keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.2
                     animations:^{
                         if (isKeyBoardShown) {
                             viewOverPicker.frame = CGRectMake(viewOverPicker.frame.origin.x, viewOverPicker.frame.origin.y-keyboardSize.height, viewOverPicker.frame.size.width, viewOverPicker.frame.size.height);
                             [viewOverPicker reloadInputViews];
                         }
                     }];
    if(((int)[[UIScreen mainScreen] nativeBounds].size.height)==2436) {
        if (@available(iOS 11.0, *)) {
        } else {
            // Fallback on earlier versions
            
        }
    }else{
    }
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    isKeyBoardShown = false;
    
}
#pragma mark - text Field

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 104) {
        pickerObj.frame = CGRectMake(pickerObj.frame.origin.x,self.view.frame.size.height - 150-keyboardSize.height , pickerObj.frame.size.width, 50);
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString * str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    if (textField.tag == 2) {
        if (str.length>0) {
            pickerArray = [self searchCourtName:str];
            [pickerObj reloadAllComponents];
        }else{
            pickerArray = courtDataArray;
            [pickerObj reloadAllComponents];
        }
    }else if (textField.tag == 3){
        if (str.length>0) {
            pickerArray = [self searchCourtType:str];
            [pickerObj reloadAllComponents];
        }else{
            pickerArray = caseTypeArray;
            [pickerObj reloadAllComponents];
        }
    }
    return true;
}

#pragma mark- Btn Action
- (IBAction)btnAction_Date:(id)sender {
    [self showDatePicker:sender];
}
- (IBAction)btnAction_Save:(id)sender {
    NSDictionary *dictForValidation = [self validateData];
    
    if (![[dictForValidation valueForKey:BoolValueKey] isEqualToString:@"0"]){
    [self hitApiToInsertAppealAlert];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictForValidation valueForKey:AlertKey]  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    dateToSend = [dateFormatter stringFromDate:[NSDate date]];
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
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            dateToSend = [dateFormatter stringFromDate:[sender date]];
            if (sender.tag == 3) {
    
                startDateString = [dateFormatter stringFromDate:[sender date]];
                startDate = sender.date;
                _txt_DateOfJudgement.text = startDateString;
           
    }
}



#pragma mark - API related

-(void)hitApiToInsertAppealAlert{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"CreatedBy"];
    [parameter setValue:_txt_CaseNo.text forKey:@"CaseNo"];
    [parameter setValue:_txt_CaseYear.text forKey:@"CaseYear"];
    [parameter setValue:[NSString stringWithFormat:@"%d",selectedCourt.CourtId] forKey:@"CourtId"];
    [parameter setValue:[NSString stringWithFormat:@"%d",selectedType.CaseTypeId] forKey:@"CaseTypeId"];
    [parameter setValue:dateToSend forKey:@"JudgementDate"];
    [paraDict setValue:parameter forKey:@"_objAppealAlert"];
    if ([ CommonFunction reachability]) {
        [self addLoder];

        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_Insert_APPEAL_ALERT]  postResponse:[paraDict mutableCopy] postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[json valueForKey:@"ErrorMessage"]  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:true];
                    }];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
                }else
                {
                    //                    [self addAlertWithTitle:AlertKey andMessage:[responseObj valueForKey:@"message"] isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
                    [self removeloder];
                    //                    [self removeloder];
                }
                [self removeloder];

            }else{
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];

            }

        }];
    } else {
        [self removeloder];
        
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
    }
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
                [[FadeAlert getInstance] displayToastWithMessage:error.description];

            }
            
        }];
    } else {
        [self removeloder];
        
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
    }
}

-(void)hitApiToGetAllCaseType{
    if ([ CommonFunction reachability]) {
        
        NSMutableDictionary *parameter = [NSMutableDictionary new];
        [parameter setValue:[NSString stringWithFormat:@"%d",selectedCourt.CourtId]  forKey:@"CourtId"];
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_CaseType]  postResponse:[parameter mutableCopy] postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
             
                NSArray *tempArray = [NSArray new];
                caseTypeArray = [NSMutableArray new];
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                tempArray = (NSArray *)json;
                [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    RegCaseType *dataObj = [RegCaseType new];
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
                    
                    [caseTypeArray addObject:dataObj];
                }];
                
                [self removeloder];
            }else{
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];

            }
            
        }];
    } else {
        [self removeloder];
        
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
    }
}
#pragma mark - Loder

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
    [CommonFunction resignFirstResponderOfAView:self.view];
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
    if (tagForPicker == 2) {
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
    

    UITextField *txtView=[[UITextField alloc]initWithFrame:CGRectMake(0, 0 , toolBar.frame.size.width-doneButton.width-100, toolBar.frame.size.height)];
    txtView.backgroundColor =[UIColor  clearColor];
    txtView.delegate = self;
    txtView.tintColor = [UIColor whiteColor];
    txtView.textColor = [UIColor whiteColor];
    txtView.placeholder=@"Search";
    txtView.tag = tagForPicker;
     txtView.returnKeyType = UIReturnKeyDone;
    UIBarButtonItem *textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:txtView];

    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             space,textFieldItem,space,doneButton, nil];
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
    if (pickerView.tag == 2) {
        selectedCourt = [pickerArray objectAtIndex:row];
        [self hitApiToGetAllCaseType];
        _txt_CourtName.text = selectedCourt.CourtName;
    }else{
        selectedType = [pickerArray objectAtIndex:row];
        _txt_CaseType.text = selectedType.CaseType;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView.tag == 2) {
        
        return ((RegCaseCourt *)[pickerArray objectAtIndex:row]).CourtName;

    }else{
        return ((RegCaseType *)[pickerArray objectAtIndex:row]).CaseType;
    }
    return @"";

}

#pragma mark- other Methods

-(NSArray *)searchCourtName:(NSString *)stringToSearch{
    NSMutableArray *searchedArray = [NSMutableArray new];
    [courtDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if( [((RegCaseCourt *)obj).CourtName containsString:stringToSearch]){
            [searchedArray addObject:obj];
        }}];
    return searchedArray;
} 
-(NSArray *)searchCourtType:(NSString *)stringToSearch{
    NSMutableArray *searchedArray = [NSMutableArray new];
    [caseTypeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if( [((RegCaseType *)obj).CaseType containsString:stringToSearch]){
            [searchedArray addObject:obj];
        }}];
    return searchedArray;
}


#pragma mark - validation



-(NSDictionary *)validateData{
    NSMutableDictionary *validationDict = [[NSMutableDictionary alloc] init];
    [validationDict setValue:@"1" forKey:BoolValueKey];
    if ([_txt_CaseNo.text isEqualToString:@""]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        [validationDict setValue:@"We need a Case Number" forKey:AlertKey];
    }
    else if ([_txt_CaseYear.text isEqualToString:@""]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        [validationDict setValue:@"We need a Case Year" forKey:AlertKey];
    }else if ([_txt_CourtName.text isEqualToString:@""]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        [validationDict setValue:@"We need a Court Name" forKey:AlertKey];
    }
    else if ([_txt_CaseType.text isEqualToString:@""]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        [validationDict setValue:@"We need a Court type" forKey:AlertKey];
    }else if ([_txt_DateOfJudgement.text isEqualToString:@""]){
        [validationDict setValue:@"0" forKey:BoolValueKey];
        [validationDict setValue:@"We need a date of judgement" forKey:AlertKey];
    }
    return validationDict.mutableCopy;
    
}



@end
