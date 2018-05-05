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
#import "CalenderModel.h"
#import "CasePageVC.h"
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
    
    [CommonFunction setNavToController:self title:@"Calender" isCrossBusston:false];

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
    [self setUpTableView];
    [self refreshData];
    
    
}


-(void)setUpTableView{
    [_tblEvents registerNib:[UINib nibWithNibName:@"CalendarListViewCell" bundle:nil]forCellReuseIdentifier:@"CalendarListViewCell"];
    _tblEvents.rowHeight = UITableViewAutomaticDimension;
    _tblEvents.estimatedRowHeight = 100;
    _tblEvents.multipleTouchEnabled = NO;
}

-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}
- (void) viewWillAppear:(BOOL)animated {
    UIView* footer =[[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    self.tblEvents.tableFooterView =footer;
    self.tblEvents.backgroundColor = [UIColor clearColor];
    [self hitApiToGetAllCalendarData];
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
    
    [self setDataInTableArrayOnselectedDate:strDate];
    
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
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-12];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:12];
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
    for(CalenderModel* obj in arrData){
        // Generate 30 random dates between now and 60 days later
        if ([obj.type isEqualToString:Cause_List_Data_Calender]) {
                    [_eventsByDate addObject:((CauseListModel *)((CalenderModel *)obj).causeObj).HearingDate];
                 i++;
        }else if ([obj.type isEqualToString:Event_List_Data_Calender]){
            [_eventsByDate addObject:((Event *)((CalenderModel *)obj).eventObj).StartAt];
                 i++;
        }else if ([obj.type isEqualToString:Case_List_Data_Calender]){
//            [_eventsByDate addObject:((CaseList *)((CalenderModel *)obj).caseObj).lld];
        }
   
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
                 arrData = [NSMutableArray new];
                    NSArray *tempArray = [NSArray new];
                    tempArray = [json objectForKey:@"CauseListData"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        CauseListModel *dataObj = [CauseListModel new];
                        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj1, BOOL *stop){
                            @try {
                                [dataObj setValue:obj1 forKey:(NSString *)key];
                                
                            } @catch (NSException *exception) {
                                NSLog(exception.description);
                                //  Handle an exception thrown in the @try block
                            } @finally {
                                //  Code that gets executed whether or not an exception is thrown
                            }
                        }];
                        CalenderModel *calenderObj = [CalenderModel new];
                        calenderObj.type = Cause_List_Data_Calender;
                        calenderObj.causeObj = dataObj;
                        [arrData addObject:calenderObj];
                    }];
                tempArray = [json objectForKey:@"caseList"];
                [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    CaseList *dataObj = [CaseList new];
                    [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj1, BOOL *stop){
                        @try {
                            [dataObj setValue:obj1 forKey:(NSString *)key];
                            
                        } @catch (NSException *exception) {
                            NSLog(exception.description);
                            //  Handle an exception thrown in the @try block
                        } @finally {
                            //  Code that gets executed whether or not an exception is thrown
                        }
                    }];
                    CalenderModel *calenderObj = [CalenderModel new];
                    calenderObj.type = Case_List_Data_Calender;
                    calenderObj.caseObj = dataObj;
                    [arrData addObject:calenderObj];
                }];
            
                tempArray = [json objectForKey:@"EventList"];
                [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Event *dataObj = [Event new];
                    [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj1, BOOL *stop){
                        @try {
                            [dataObj setValue:obj1 forKey:(NSString *)key];
                            
                        } @catch (NSException *exception) {
                            NSLog(exception.description);
                            //  Handle an exception thrown in the @try block
                        } @finally {
                            //  Code that gets executed whether or not an exception is thrown
                        }
                    }];
                    CalenderModel *calenderObj = [CalenderModel new];
                    calenderObj.type = Event_List_Data_Calender;
                    calenderObj.eventObj = dataObj;
                    [arrData addObject:calenderObj];
                }];

                [self createRandomEvents];
                NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                
                [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
                
                NSString *strDate = [dateFormat1  stringFromDate:[NSDate date]];// string with yyyy-MM-dd format
                
                [self setDataInTableArrayOnselectedDate:strDate];
                [_calendarManager reload];
                [_tblEvents reloadData];
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



#pragma mark - Table view Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrTableData.count)
    {
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tblEvents.backgroundView = nil;
        _lbl_Nodata.hidden = true;
        return arrTableData.count;
    }
    else
    {
        // Display a message when the table is empty
        _lbl_Nodata.hidden = false;
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   CalendarListViewCell*  cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarListViewCell"];
    
    if (cell == nil) {
        cell = [[CalendarListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CalendarListViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CalenderModel *obj = [arrTableData objectAtIndex:indexPath.row];
        if ([((CalenderModel *)obj).type isEqualToString:Cause_List_Data_Calender]) {
            
            CauseListModel *tempObj = ((CalenderModel *)obj).causeObj;
                cell.lblTopRight.text = [NSString stringWithFormat:@"%@ %d/%d",tempObj.CaseType,tempObj.CaseNo,tempObj.CaseYear];
                cell.lblTopLeft.text = tempObj.CourtName;
                cell.lblHeading.text = [NSString stringWithFormat:@"%@ vs %@",tempObj.PetitionerName,tempObj.RespondentName];
                cell.lblSubtitle.text = tempObj.BenchName;
                cell.lblCourt.text = [NSString stringWithFormat:@"Court: %d",tempObj.CourtNo];
                cell.lblItem.text = [NSString stringWithFormat:@"Item: %@",tempObj.CaseSeqNo];
                cell.lblType.text = @"C.List" ;
        }else if ([((CalenderModel *)obj).type isEqualToString:Event_List_Data_Calender]){
              Event *tempObj = ((CalenderModel *)obj).eventObj;
                cell.lblTopRight.text = @"";
                cell.lblTopLeft.text = tempObj.EventName;
                cell.lblHeading.text = tempObj.StartAt;
                cell.lblSubtitle.text = @"";
                cell.lblCourt.text = @"";
                cell.lblItem.text = @"";
                cell.lblType.text = @"Task" ;
            
        }else if ([((CalenderModel *)obj).type isEqualToString:Case_List_Data_Calender]){
            CaseList *tempObj = ((CalenderModel *)obj).caseObj;

                cell.lblTopRight.text = tempObj.CaseTypeName;
                cell.lblTopLeft.text = tempObj.CourtName;
                cell.lblHeading.text = [NSString stringWithFormat:@"%@ vs %@",tempObj.PetitionerName,tempObj.RespondantName];
                cell.lblSubtitle.text = tempObj.PetitionerAdvocateName;
                cell.lblCourt.text = @"";
                cell.lblItem.text = @"";
                cell.lblType.text = @"Case" ;
        }
   
    

    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   CalenderModel *obj = [arrTableData objectAtIndex:indexPath.row];
    if ([((CalenderModel *)obj).type isEqualToString:Cause_List_Data_Calender]) {
        CasePageVC *caseOBJ = [[CasePageVC alloc]initWithNibName:@"CasePageVC" bundle:nil];
        caseOBJ.isFromDailyCauseList = true;
        caseOBJ.causeListObj = obj.causeObj;
        [self.navigationController pushViewController:caseOBJ animated:true];
        
    }else if ([((CalenderModel *)obj).type isEqualToString:Event_List_Data_Calender]){
        TaskDetailVC *createTaskObj = [[TaskDetailVC alloc]initWithNibName:@"TaskDetailVC" bundle:nil];
        createTaskObj.eventObj = obj.eventObj;
        createTaskObj.fromViewController = self;
        [self.navigationController pushViewController:createTaskObj animated:true];
    }else if ([((CalenderModel *)obj).type isEqualToString:Case_List_Data_Calender]){

        CasePageVC *caseOBJ = [[CasePageVC alloc]initWithNibName:@"CasePageVC" bundle:nil];
        CaseList *dataObj  = obj.caseObj;
        caseOBJ.dataObj = dataObj;
        caseOBJ.isFromDailyCauseList = false;
        [self.navigationController pushViewController:caseOBJ animated:true];
    }
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
    vc.isCreateTask = true;
    vc.fromViewController  = self;
    [self.navigationController pushViewController:vc animated:true];
    
}

-(void)setDataInTableArrayOnselectedDate:(NSString *)selectedDate{
    [arrTableData removeAllObjects];
    
    [arrData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([((CalenderModel *)obj).type isEqualToString:Cause_List_Data_Calender]) {
            if ([((CauseListModel *)((CalenderModel *)obj).causeObj).HearingDate isEqualToString:selectedDate]) {
                [arrTableData addObject:obj];
            }
        }else if ([((CalenderModel *)obj).type isEqualToString:Event_List_Data_Calender]){
            if ([((Event *)((CalenderModel *)obj).eventObj).StartAt isEqualToString:selectedDate]) {
//                if ([self getBoolFromDate:selectedDate startDate:((Event *)((CalenderModel *)obj).eventObj).StartAt andEndDate:((Event *)((CalenderModel *)obj).eventObj).EndAt]) {
                    [arrTableData addObject:obj];
                }
//            }
            
          
        }else if ([((CalenderModel *)obj).type isEqualToString:Case_List_Data_Calender]){
            if ([((CaseList *)((CalenderModel *)obj).caseObj).upcominghearingDate isEqualToString:selectedDate]) {
                [arrTableData addObject:obj];
            }
        }
    }];
    [_tblEvents reloadData];
}

-(BOOL)getBoolFromDate:(NSString *)dateCompareString startDate:(NSString *)startDateString andEndDate:(NSString *)endDateString{
    NSDateFormatter *dateform=[[NSDateFormatter alloc]init];
    [dateform setDateStyle:NSDateFormatterLongStyle];
    [dateform setTimeStyle:NSDateFormatterShortStyle];
    [dateform setDateFormat:@"dd/MM/YYYY"];
    NSDate *dateToCompare=[dateform dateFromString:dateCompareString];
    NSDate *startDate=[dateform dateFromString:startDateString];
    NSDate *endDate=[dateform dateFromString:endDateString];
    
    
    NSComparisonResult result1;
    NSComparisonResult result2;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
//    result = [today compare:newDate]; // comparing two dates

    result1 = [startDate compare:dateToCompare]; // comparing two dates
    result2 = [dateToCompare compare:endDate]; // comparing two dates
    if((result1==NSOrderedAscending || result1 == NSOrderedSame)&&(result2==NSOrderedDescending || result2 == NSOrderedSame) ){
//        NSLog(@"today is less");
        return true;
    }
    else
    return false;
}
@end
