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
        [self setDefaultDate];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark- other Methods
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
            [dateFormatter setDateFormat:@"dd/MM/YYYY"];
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
@end
