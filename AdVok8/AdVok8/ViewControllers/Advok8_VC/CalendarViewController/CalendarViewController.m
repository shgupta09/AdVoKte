//
//  CalendarViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 31/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CalendarViewController.h"
#import "JTCalendarDayView.h"
#import "CreateTaskVC.h"

@interface CalendarViewController ()<UIAlertViewDelegate>
{
    NSMutableArray *_eventsByDate;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    NSDate *_dateSelected;
    NSMutableArray* arrData;
    NSMutableArray* arrTableData;
    LoderView* loderObj;
}

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonFunction setNavToController:self title:@"Update Profile" isCrossBusston:false];

    arrData = [NSMutableArray new];
    arrTableData = [NSMutableArray new];

    self.navigationController.title = @"Calendar";
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
//    [self createRandomEvents];
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];

    [self hitApiToGetAllCalendarData];
    [self refreshData];
    
    [_tblEvents registerNib:[UINib nibWithNibName:@"CalendarListViewCell" bundle:nil]forCellReuseIdentifier:@"CalendarListViewCell"];
    
}
- (void) viewWillAppear:(BOOL)animated {
    UIView* footer =[[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    self.tblEvents.tableFooterView =footer;
    self.tblEvents.backgroundColor = [UIColor clearColor];
    [self.tblEvents reloadData];
    
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.calendarManager reload]; // Must be call in viewDidAppear
}
-(void) refreshData {
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.dateFormat = @"dd-MMM-yyyy";
//    NSDateFormatter *formatForDB = [[NSDateFormatter alloc] init];
//    formatForDB.dateFormat = @"yyyy-MM-dd";
//    currentSelectedDate =[formatForDB stringFromDate:[NSDate date]];
//    self.lblDate.text = [NSString stringWithFormat:@"%@",[format stringFromDate:[NSDate date]]];
//
//
//    self.tblEvents.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
////    queryData =[db getAllClientQueriesByDate:[formatForDB stringFromDate:[NSDate date]]];
//    [self.tblEvents reloadData];
    
}

#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [_calendarManager setDate:_todayDate];
}

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    
    [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
    
    NSString *strDate = [dateFormat1  stringFromDate:dayView.date];// string with yyyy-MM-dd format
    
    [arrTableData removeAllObjects];
    
    for (CaseList* caseObj in arrData){
        if ([strDate isEqualToString:caseObj.lld] || [strDate isEqualToString:caseObj.upcominghearingDate]){
            [arrTableData addObject:caseObj];
            
        }
    }
    [_tblEvents reloadData];
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    
    [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
    
    NSString *strDate = [dateFormat1  stringFromDate:date];// string with yyyy-MM-dd format
    
    
    
    if([_eventsByDate containsObject:strDate]){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableArray new];
    [_eventsByDate removeAllObjects];
    int i = 0;
    for(CaseList* obj in arrData){
        // Generate 30 random dates between now and 60 days later
        
        [_eventsByDate addObject:obj.upcominghearingDate];
        [_eventsByDate addObject:obj.lld];
        i++;
    }
}


#pragma mark - API related

-(void)hitApiToGetAllCalendarData{
    
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"Username"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ADVOCATE_CALENDAR]  postResponse:dict postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                
                    NSArray *tempArray = [NSArray new];
                    tempArray = [json objectForKey:@"caseList"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        CaseList *dataObj = [CaseList new];
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
                        
                        [arrData addObject:dataObj];
                    }];
                [self createRandomEvents];
                    [_calendarManager reload];
                
                [self removeloder];
                
            }
            else
            {
                [self  removeloder];
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



#pragma mark - Table view Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrTableData.count)
    {
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tblEvents.backgroundView = nil;
        return arrTableData.count;
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
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   CalendarListViewCell*  cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarListViewCell"];
    
    if (cell == nil) {
        cell = [[CalendarListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CalendarListViewCell"];
    }
    
    CaseList* caseObj = [arrTableData objectAtIndex:indexPath.row];
    
    cell.lblTopRight.text = caseObj.CaseTypeName;
    cell.lblTopLeft.text = caseObj.CourtName;
    cell.lblHeading.text = [NSString stringWithFormat:@"%@ vs %@",caseObj.PetitionerName,caseObj.RespondantName];
    cell.lblSubtitle.text = @"Regitrar Court";
    cell.lblCourt.text = @"Court:";
    cell.lblItem.text = @"Item:";
    cell.lblType.text = @"C.List" ;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
}

-(void) recieveNotification:(NSNotification*) notification {
    
    if ([[notification name] isEqualToString:@"Calendar View Appear"]) {
        [self.calendarManager reload];
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

- (IBAction)btnCreateTaskClicked:(id)sender {
    CreateTaskVC* vc = [[CreateTaskVC alloc] initWithNibName:@"CreateTaskVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
    
}

@end
