//
//  AppAppealVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppAppealVC.h"

@interface AppAppealVC (){
    UIDatePicker* pickerForDate;
    NSDate *startDate;
    NSString *startDateString;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
}

@end

@implementation AppAppealVC

- (void)viewDidLoad {
    [super viewDidLoad];
       [self setUpData];
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpData{
        [CommonFunction setNavToController:self title:@"Appeal alert" isCrossBusston:false];
        [self setDefaultDate];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Btn Action
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
@end
