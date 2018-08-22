//
//  AddNewCaseViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 06/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AddNewCaseViewController.h"
#import "RegCaseCourt.h"
#import "RegCaseType.h"
@interface AddNewCaseViewController (){
    UIDatePicker* pickerForDate;
    NSDate *startDate;
    NSString *startDateString;
    NSString *dateToSend;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
    LoderView *loderObj;
    NSMutableArray *courtDataArray;
    NSMutableArray *caseTypeArray;
    NSMutableArray *caseStatusArray;
    UIPickerView *pickerObj;
    NSArray *pickerArray;
    RegCaseCourt *selectedCourt;
    RegCaseType *selectedType;
    CGSize keyboardSize;
    BOOL isKeyBoardShown;

}

@end

@implementation AddNewCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUpData];
    

    // Do any additional setup after loading the view from its nib.
}
#pragma mark- Navigation
-(void)setUpData{
   [CommonFunction setNavToController:self title:@"Register a Case" isCrossBusston:false];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    pickerObj = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    isKeyBoardShown = false;
    
    [_btnAdditionalFields setSelected:false];
    _cons_viContainerAdditionalField.constant = 0;
    _viContainerAdditionalFields.hidden = true;
    
    [self setDefaultDate];
    [self hitApiToGetAllCourt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
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
    if (textField.tag == 100 ||textField.tag == 101) {
    
        

    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString * str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    if (textField.tag == 100) {
        if (str.length>0) {
            pickerArray = [self searchCourtName:str];
            [pickerObj reloadAllComponents];
        }else{
            pickerArray = courtDataArray;
            [pickerObj reloadAllComponents];
        }
    }else if (textField.tag == 101){
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
        [self hitApiToAddNewCase];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictForValidation valueForKey:AlertKey]  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (IBAction)btnAcion_picker:(id)sender {
    UIButton* btn = (UIButton*) sender;
    
    if (btn.tag == 200 || btn.tag == 201 || btn.tag == 202 || btn.tag == 203 ){
        [self showDatePicker:sender];
    }
    else
    {
        [self addPickerViewWithTag:((UIButton *)sender).tag];

    }
    
}

/*
 
 */

#pragma mark - API related

-(void)hitApiToAddNewCase{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"DisplayName"] forKey:@"CreatedBy"];
    [parameter setValue:_txt_CaseNo.text forKey:@"caseId"];
    [parameter setValue:@"0" forKey:@"mycaseId"];
    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"DisplayName"] forKey:@"PetitionerName"];
    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"advid"];
    [parameter setValue:_txtRespondentName.text forKey:@"rnm"];
    [parameter setValue:_txtResponAdvocateName.text forKey:@"radvnm"];
    [parameter setValue:[CommonFunction convertDDMMYYYYtoMMDDYYYY:_txtDateOfFiling.text] forKey:@"dof"];
    [parameter setValue:[CommonFunction convertDDMMYYYYtoMMDDYYYY:_txtLastListingDate.text] forKey:@"lld"];
    [parameter setValue:[CommonFunction convertDDMMYYYYtoMMDDYYYY:_txtUpcomingHearingDate.text] forKey:@"upcominghearingDate"];
    [parameter setValue:_txtCaseDescription.text forKey:@"dsc"];
    [parameter setValue:[CommonFunction convertDDMMYYYYtoMMDDYYYY:_txtCaseDisposalDate.text] forKey:@"dod"];
    [parameter setValue:_txtCaseStatus.text forKey:@"st"];
    [parameter setValue:_txt_CaseYear.text forKey:@"caseyear"];
    [parameter setValue:_txtCaseAct.text forKey:@"caseact"];
    [parameter setValue:[NSString stringWithFormat:@"%d",selectedCourt.CourtId] forKey:@"CourtId"];
    [parameter setValue:[NSString stringWithFormat:@"%d",selectedType.CaseTypeId] forKey:@"CaseTypeId"];

    [paraDict setValue:parameter forKey:@"_case"];
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_ADD_NEW_CASE]  postResponse:[paraDict mutableCopy] postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    [self.navigationController popViewControllerAnimated:true];
                }else
                {
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
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
    pickerObj.frame = CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150);
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
    if (tagForPicker == 100) {
        pickerArray = [courtDataArray mutableCopy];
    }else if (tagForPicker == 101) {
        pickerArray = [caseTypeArray mutableCopy];
    }else if (tagForPicker == 204) {
        caseStatusArray = [[NSMutableArray alloc] initWithObjects:@"Pending",@"Outstanding",@"Closed", nil];
        pickerArray = [caseStatusArray mutableCopy];
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
    [CommonFunction resignFirstResponderOfAView:self.view];
    [viewOverPicker removeFromSuperview];

    if (pickerView.tag == 100) {
        selectedCourt = [pickerArray objectAtIndex:row];
        [self hitApiToGetAllCaseType];
        _txt_CourtName.text = selectedCourt.CourtName;
    }else if (pickerView.tag == 101){
        selectedType = [pickerArray objectAtIndex:row];
        _txt_CaseType.text = selectedType.CaseType;
    } else if (pickerView.tag == 204){
        NSString* status = [pickerArray objectAtIndex:row];
        _txtCaseStatus.text = status;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView.tag == 100) {
        
        return ((RegCaseCourt *)[pickerArray objectAtIndex:row]).CourtName;
        
    }else if (pickerView.tag == 101){
        return ((RegCaseType *)[pickerArray objectAtIndex:row]).CaseType;
    }else if (pickerView.tag == 204){
        return [pickerArray objectAtIndex:row];
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


- (IBAction)btnAdditionalFieldsClicked:(id)sender {
    if (_btnAdditionalFields.isSelected == true){
        [_btnAdditionalFields setSelected:false];
        _cons_viContainerAdditionalField.constant = 0;
        _viContainerAdditionalFields.hidden = true;
        
    }
    else
    {
        [_btnAdditionalFields setSelected:true];
        _cons_viContainerAdditionalField.constant = 852;
        _viContainerAdditionalFields.hidden = false;


    }
}


#pragma mark- Date Picker

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
}
// Show the date picker
-(void)showDatePicker:(UIButton*)sender{
    [CommonFunction resignFirstResponderOfAView:self.view];
    
    pickerForDate = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    pickerForDate.datePickerMode = UIDatePickerModeDate;
    [pickerForDate setDate:[NSDate date]];
    
    pickerForDate.tag = sender.tag;
    
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
    
    NSString* currentDateString = [dateFormatter stringFromDate:[sender date]];
    
    switch (sender.tag) {
        case 200:
        {
            _txtDateOfFiling.text = currentDateString;
        }
            break;
            
        case 201:
        {
            _txtLastListingDate.text = currentDateString;

        }
            break;
            
        case 202:
        {
            _txtUpcomingHearingDate.text = currentDateString;

        }
            break;
            
        case 203:
        {
            _txtCaseDisposalDate.text = currentDateString;

        }
            break;
            
        default:
            break;
    }
    
}






@end
