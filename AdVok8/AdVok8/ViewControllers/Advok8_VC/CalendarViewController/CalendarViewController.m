//
//  CalendarViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 31/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CalendarViewController.h"
#import "JTCalendarDayView.h"

@interface CalendarViewController ()<UIAlertViewDelegate>
{
    int count;
    UIButton* testButton;
    NSString* currentSelectedDate;
    NSMutableArray* queryData;
    
}

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    count = 0;
    [super viewDidLoad];
    
    self.navigationController.title = @"Calendar";
    
    testButton = [[UIButton alloc ]  init];
    self.calendar = [JTCalendar new];
    // Do any additional setup after loading the view.
    
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotification:) name:@"Calendar View Appear" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotification:) name:@"AddEvent" object:nil];
    
    self.calendarMenuView.backgroundColor = [UIColor whiteColor];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [THEME_BACKGROUND drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self refreshData];
}
- (void) viewWillAppear:(BOOL)animated {
    UIView* footer =[[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    self.tblEvents.tableFooterView =footer;
    self.tblEvents.backgroundColor = [UIColor clearColor];
    [self.tblEvents reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.calendar reloadData]; // Must be call in viewDidAppear
}
-(void) refreshData {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-MMM-yyyy";
    NSDateFormatter *formatForDB = [[NSDateFormatter alloc] init];
    formatForDB.dateFormat = @"yyyy-MM-dd";
    currentSelectedDate =[formatForDB stringFromDate:[NSDate date]];
    self.lblDate.text = [NSString stringWithFormat:@"%@",[format stringFromDate:[NSDate date]]];
    
    
    self.tblEvents.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    queryData =[db getAllClientQueriesByDate:[formatForDB stringFromDate:[NSDate date]]];
    [self.tblEvents reloadData];
    
}
#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch{
    [self.calendar setCurrentDate:[NSDate date]];
}
- (IBAction)didChangeModeTouch{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

#pragma mark - JTCalendarDataSource
- (int)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date{
    NSDateFormatter *formatForDB = [[NSDateFormatter alloc] init];
    formatForDB.dateFormat = @"yyyy-MM-dd";
    NSString* testDate =[formatForDB stringFromDate:date];
    int countForQueries;
    countForQueries = 2;
    int noToShowOnDate = 1;
    int countFormMultiDate = 1;
    
    if (countForQueries>0) {
        return noToShowOnDate;
    }
    else if (countForQueries == -1)
    {
        JTCalendarDayView* dv = [[JTCalendarDayView alloc ] init];
        dv.calendarManager = calendar;
        dv.date = date;
        [dv setEventFinalView:testDate];
        return (noToShowOnDate* -1);
    }
    else if (countFormMultiDate>0)
    {
        JTCalendarDayView* dv = [[JTCalendarDayView alloc ] init];
        dv.calendarManager = calendar;
        dv.date = date;
        [dv setEventFinalView:testDate];
        return (countFormMultiDate* -1);
    }
    
    else
    {
        return noToShowOnDate;
    }
    /*
     int countForQueries;
     countForQueries = [db isQueryPresentForDate:testDate];
     int noToShowOnDate = [db countQueriesPresentForDateWithCount:testDate];
     
     if (countForQueries == -1)
     {
     JTCalendarDayView* dv = [[JTCalendarDayView alloc ] init];
     dv.calendarManager = calendar;
     dv.date = date;
     [dv setEventFinalView:testDate];
     return noToShowOnDate;
     }
     else
     {
     if (noToShowOnDate>0) {
     JTCalendarDayView* dv = [[JTCalendarDayView alloc ] init];
     dv.calendarManager = calendar;
     dv.date = date;
     [dv setQueryView:testDate];
     return noToShowOnDate;
     }
     else
     return noToShowOnDate;
     }
     
     */
}
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date{
    NSTimeInterval secondsInEightHours = 5.5 * 60 * 60;
    NSDate *dateIST = [date dateByAddingTimeInterval:secondsInEightHours];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-MMM-yyyy";
    NSDateFormatter *formatForDB = [[NSDateFormatter alloc] init];
    formatForDB.dateFormat = @"yyyy-MM-dd";
    currentSelectedDate =[formatForDB stringFromDate:dateIST];
    self.lblDate.text = [NSString stringWithFormat:@"%@",[format stringFromDate:dateIST]];
    
//    queryData = [db getAllClientQueriesByDate:currentSelectedDate];
    [self.tblEvents reloadData];
}

#pragma mark - Transition examples

- (void)transitionExample {
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark - Table view Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (queryData.count)
    {
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tblEvents.backgroundView = nil;
        return 2;
    }
    else
    {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"";
        messageLabel.textColor = [UIColor darkGrayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tblEvents.backgroundView = messageLabel;
        self.tblEvents.backgroundColor = [UIColor clearColor];
        return 2;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.accessoryView = nil;
    cell.textLabel.text = @"hello";
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
}

-(void) recieveNotification:(NSNotification*) notification {
    
    if ([[notification name] isEqualToString:@"Calendar View Appear"]) {
        [self.calendar reloadData];
    }
    else if([[notification name] isEqualToString:@"AddEvent"])
    {
        
    }
}

- (IBAction)btnAdd:(id)sender {
   
    
}

#pragma  mark - ALert View Delegate methods
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 1) {
        
        
    }
    else
    {
        
    }
    
}

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (IBAction)btnNextMonth:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadNextMonth" object:nil];
}
- (IBAction)btnPreviousMonth:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadPreviousMonth" object:nil];
}


@end
