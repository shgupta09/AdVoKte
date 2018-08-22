//
//  CreateTaskVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CreateTaskVC.h"

@interface CreateTaskVC (){
    UIDatePicker* pickerForDate;
    NSDate *startDate;
    NSString *startDateString;
    NSDate *endDate;
    NSString *endDateString;
    NSString *startTimeString;
    NSString *endTimeString;
    NSDate *startTimeDate;
    NSDate *endTimeDate;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
    LoderView *loderObj;

}

@end

@implementation CreateTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpData{
    if (_isCreateTask) {
        
        [CommonFunction setNavToController:self title:@"Create Task" isCrossBusston:false];
        [_btn_Save_Update setTitle:@"Save" forState:UIControlStateNormal];
        [self setDefaultDate];
        [_btn_AllDay setOn:true];
        [self hideData:true];
        
//        [self.view setNeedsUpdateConstraints];
//        [self.view updateConstraints];
//        [self.view layoutSubviews];
    }else{
        [CommonFunction setNavToController:self title:@"Update Task" isCrossBusston:false];
         [_btn_Save_Update setTitle:@"Update" forState:UIControlStateNormal];
//        [self setDefaultDate];
        [self prefillData];
    }
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


#pragma mark- other Methods
-(void)prefillData{
    _txt_title.text = _eventObj.EventName;
    _txt_Matter.text = _eventObj.Matter;
    _txt_Location.text = _eventObj.Location;
    _txt_Description.text = _eventObj.Description;
    [_btn_AllDay setOn:false];
    _txt_StartDate.text = _eventObj.StartAt;
    _txt_startTime.text = _eventObj.StartTime;
    _txt_EndDate.text = _eventObj.EndAt;
    _txt_endTime.text = _eventObj.EndTime;
 
    startDate = [CommonFunction convertStringddMMYYYYToDate:_eventObj.StartAt];
    endDate = [CommonFunction convertStringddMMYYYYToDate:_eventObj.EndAt];
}

-(void)hideData:(BOOL)state{
    _txt_startTime.hidden = state;
    _txt_endTime.hidden = state;
    _btn_EndTime.hidden = state;
    _btn_StartTime.hidden = state;
    _lbl_EndTime.hidden = state;
    _lbl_StartTime.hidden = state;
}
#pragma mark- Btn Action

- (IBAction)btnAction_AllDay:(id)sender {
    if (((UISwitch *)sender).isOn) {
        [self hideData:true];
        
       _widthConstraint2 = [_widthConstraint2 updateMultiplier:1.0];
       _widthConstraint3 = [_widthConstraint3 updateMultiplier:1.0];

    }else{
        [self hideData:false];
       _widthConstraint2 = [_widthConstraint2 updateMultiplier:.5];
       _widthConstraint3 = [_widthConstraint3 updateMultiplier:.5];

    }
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraints];
    [self.view layoutSubviews];
}

- (IBAction)btnAction_Date:(id)sender {
    [self showDatePicker:sender];
}
- (IBAction)btnAction_Save:(id)sender {
    [self hitApiToInsertUpdateAppointment];
}
#pragma mark- Date Picker


//Resign Responder
-(void)resignResponder{
    [viewOverPicker removeFromSuperview];
}
// Set the default date
-(void)setDefaultDate{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    startDateString = [dateFormatter stringFromDate:[NSDate date]];
    startDate = [NSDate date];
    endDateString = startDateString;
    endDate= startDate;
    _txt_StartDate.text = startDateString;
    _txt_EndDate.text = startDateString;
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"hh:mm a"];
    startTimeString = [dateFormatter2 stringFromDate:[NSDate date]];
    endTimeString = [dateFormatter2 stringFromDate:[NSDate date]];
    _txt_startTime.text = startTimeString;
    _txt_endTime.text = endTimeString;
    startTimeDate = [NSDate date];
    endTimeDate = [NSDate date];
}
// Show the date picker
-(void)showDatePicker:(id)sender{
    [CommonFunction resignFirstResponderOfAView:self.view];
    pickerForDate = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    pickerForDate.tag = ((UIButton *)sender).tag;
    if (pickerForDate.tag == 0) {
        pickerForDate.datePickerMode = UIDatePickerModeDate;
        [pickerForDate setDate:startDate];
    }else if(pickerForDate.tag ==1){
        pickerForDate.datePickerMode = UIDatePickerModeDate;
        [pickerForDate setDate:endDate];
    }else if (pickerForDate.tag ==2){
        pickerForDate.datePickerMode = UIDatePickerModeTime;
        [pickerForDate setDate:startTimeDate];
    }else if (pickerForDate.tag == 3){
        [pickerForDate setDate:endTimeDate];
        pickerForDate.datePickerMode = UIDatePickerModeTime;
    }
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
    
    switch (sender.tag) {
        case 0:
        case 1:{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
            
            //self.myLabel.text = [dateFormatter stringFromDate:[dueDatePickerView date]];
            NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            if (sender.tag == 0) {
                
                startDateString = [dateFormatter stringFromDate:[sender date]];
                startDate = sender.date;
                _txt_StartDate.text = startDateString;
            }else if(sender.tag == 1){
                endDateString = [dateFormatter stringFromDate:[sender date]];
                endDate = sender.date;
                _txt_EndDate.text = endDateString;
            }
        }
            break;
        case 2:
        case 3:{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"hh:mm a"];
            
            if (sender.tag == 2) {
                
                startTimeString = [dateFormatter stringFromDate:[sender date]];
                startTimeDate = sender.date;
                _txt_startTime.text = startTimeString;
            }else if(sender.tag == 3){
                endTimeString = [dateFormatter stringFromDate:[sender date]];
                endTimeDate = sender.date;
                _txt_endTime.text = endTimeString;
            }
        }
            break;
            
            
        default:
            break;
    }
}


#pragma mark - Api Related
-(void)hitApiToInsertUpdateAppointment{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormatter dateFromString:_txt_StartDate.text];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString* strStart = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    date = [dateFormatter dateFromString:_txt_EndDate.text];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString* strEnd = [dateFormatter stringFromDate:date];
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    if (_isCreateTask){
        [dictRequest setValue:@"0" forKey:@"EventId"];
    }
    else
    {
        [dictRequest setValue:[NSString stringWithFormat:@"%d", _eventObj.EventId] forKey:@"EventId"];
    }
    if (_btn_AllDay.isOn){
        [dictRequest setValue:@"true" forKey:@"AllDay"];
    }
    else
    {
        [dictRequest setValue:@"false" forKey:@"AllDay"];
    }
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    [dictRequest setValue:@"10" forKey:@"Attendees"];
    [dictRequest setValue:_txt_title.text forKey:@"EventName"];
    [dictRequest setValue:_txt_Description.text forKey:@"Description"];
    [dictRequest setValue:_txt_Matter.text forKey:@"Matter"];
    [dictRequest setValue:strStart forKey:@"StartAt"];
    [dictRequest setValue:strEnd forKey:@"EndAt"];
    [dictRequest setValue:_txt_startTime.text forKey:@"StartTime"];
    [dictRequest setValue:_txt_endTime.text forKey:@"EndTime"];
    [dictRequest setValue:_txt_Location.text forKey:@"Location"];
    [parameter setValue:dictRequest forKey:@"objEvent"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_INSERT_UPDATE_EVENT]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1 || status == 2){
                    [self.navigationController popToViewController:_fromViewController animated:true];
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                }else
                {
                    
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    
                }
                
            }
            else
            {
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
            }
            
            
            [self removeloder];
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
