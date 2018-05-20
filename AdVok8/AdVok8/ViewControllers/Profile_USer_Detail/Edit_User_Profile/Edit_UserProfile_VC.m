//
//  Edit_UserProfile_VC.m
//  AdVok8
//
//  Created by shubham gupta on 4/14/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "Edit_UserProfile_VC.h"

@interface Edit_UserProfile_VC (){
    UIDatePicker* pickerForDate;
    NSDate *startDate;
    NSString *startDateString;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
    UIPickerView *pickerObj;
    NSArray *pickerArray;
    LoderView* loderObj;
}

@end

@implementation Edit_UserProfile_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Navigation
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Update Profile" isCrossBusston:false];
    self.txt_name.text = _userObj.FirstName;
    self.txt_Number.text = _userObj.ContactNo;
    self.txt_AlterNumbr.text = _userObj.AlternateContactNo;
    self.txt_email.text = _userObj.EmailId;
    self.txt_gender.text = _userObj.Gender;
    [_imgProfileUser sd_setImageWithURL:[CommonFunction getProfilePicURLString:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"]] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
    
    [self setDefaultDate];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark-Btn Action

- (IBAction)btn_Action:(id)sender {
    [self.view endEditing:true];
    if (((UIButton *)sender).tag == 0) {
        [self addPickerViewWithTag:0];
    }else{
        [self showDatePicker:sender];
    }
}


#pragma mark- Date Picker


//Resign Responder
-(void)resignResponder{
    [viewOverPicker removeFromSuperview];
}
// Set the default date
-(void)setDefaultDate{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YYYY"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    startDateString = [dateFormatter stringFromDate:[NSDate date]];
    startDate = [NSDate date];
    
    _txt_Date.text = startDateString;
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
    [dateFormatter setDateFormat:@"MM/dd/YYYY"];
    
        startDateString = [dateFormatter stringFromDate:[sender date]];
        startDate = sender.date;
        _txt_Date.text = startDateString;
        
    
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
    
    pickerArray = [[NSArray alloc]initWithObjects:@"Male",
                   @"Female", nil];
    
    
    
    viewOverPicker.backgroundColor = [UIColor clearColor];
    [CommonFunction setResignTapGestureToView:viewOverPicker andsender:self];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(doneForPicker:)];
    doneButton.tintColor = [CommonFunction colorWithHexString:@"f7a41e"];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             space,doneButton, nil];
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
    
    _txt_gender.text = [pickerArray objectAtIndex:row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnUpdateClicked:(id)sender {
    [self hitApiToUpdateProfile];
}

//"AlternateContactNo":"9965923014","ContactNo":"9560409501","DOB":"11/04/1988","EmailId":"","EntityCode":"0","EntityOtherType":"","FirstName":"Mradul","Gender":"Male","LastName":"Singh","type":1,"username":"9560409501"}

-(void)hitApiToUpdateProfile{
    NSMutableDictionary* parameter = [NSMutableDictionary new];
    
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"username"];
    [dictRequest setValue:self.txt_email.text forKey:@"EmailId"];
    [dictRequest setValue:self.txt_gender.text forKey:@"Gender"];
    [dictRequest setValue:self.txt_Date.text forKey:@"DOB"];
    [dictRequest setValue:self.txt_name.text forKey:@"FirstName"];
    [dictRequest setValue:self.txt_Number.text forKey:@"ContactNo"];
    [dictRequest setValue:self.txt_AlterNumbr.text forKey:@"AlternateContactNo"];
    [dictRequest setValue:@"" forKey:@"EntityOtherType"];
    [dictRequest setValue:@"0" forKey:@"EntityCode"];
    [dictRequest setValue:@"1" forKey:@"type"];

    
    [parameter setObject:dictRequest forKey:@"_USRegistration"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_UPDATE_USER_PROFILE]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    
                }
                [self.navigationController popViewControllerAnimated:true];
                [[FadeAlert getInstance] displayToastWithMessage: [json valueForKey:@"ErrMsg"]];
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
