//
//  DailyCauseListVc.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/30/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "DailyCauseListVc.h"
#import "DailyCauseListCell.h"
#import "CasePageVC.h";
@interface DailyCauseListVc ()
{
    UIDatePicker* pickerForDate;
    NSDate *currentDate;
    NSString *currentDateString;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
    LoderView* loderObj;
    NSMutableArray *arrData;
    NSMutableArray *arrTableData;
}
@end

@implementation DailyCauseListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self hitApiToGetAllData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

-(void)setUpData{
    arrData = [NSMutableArray new];
    arrTableData = [NSMutableArray new];
    [self setUpTableView];
    [self setDefaultDate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- btn Actions

- (IBAction)btnAction_calender:(id)sender {
    [self showDatePicker];
}


#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"DailyCauseListCell" bundle:nil]forCellReuseIdentifier:@"DailyCauseListCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrTableData.count>0) {
        _lbl_NoData.hidden = true;
    }else{
        _lbl_NoData.hidden = false;
    }
    return arrTableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DailyCauseListCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"DailyCauseListCell"];
    
    if (cell == nil) {
        cell = [[DailyCauseListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DailyCauseListCell"];
    }
    
    CauseListModel *tempObj = [arrTableData objectAtIndex:indexPath.row];
    cell.lbl2.text = [NSString stringWithFormat:@"%@ %d/%d",tempObj.CaseType,tempObj.CaseNo,tempObj.CaseYear];
    cell.lbl1.text = tempObj.CourtName;
    cell.lbl3.text = [NSString stringWithFormat:@"%@ vs %@",tempObj.PetitionerName,tempObj.RespondentName];
    cell.lbl4.text = tempObj.BenchName;
    cell.lbl5.text = [NSString stringWithFormat:@"Court: %d   Item: %@",tempObj.CourtNo,tempObj.CaseSeqNo];
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CasePageVC *caseOBJ = [[CasePageVC alloc]initWithNibName:@"CasePageVC" bundle:nil];
    caseOBJ.isFromDailyCauseList = true;
    [self.navigationController pushViewController:caseOBJ animated:true];
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
    currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    currentDate = [NSDate date];
    _txt_Search.text = currentDateString;
}
// Show the date picker
-(void)showDatePicker{
    [CommonFunction resignFirstResponderOfAView:self.view];

    pickerForDate = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    pickerForDate.datePickerMode = UIDatePickerModeDate;
        [pickerForDate setDate:currentDate];
    
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
    
    currentDateString = [dateFormatter stringFromDate:[sender date]];
    currentDate = sender.date;
    
    _txt_Search.text = currentDateString;
    [self setDataInTableArrayOnselectedDate:currentDateString];
}


#pragma mark - API related

-(void)hitApiToGetAllData{
    
    
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
                   
                    [arrData addObject:dataObj];
                }];
                
                NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                
                [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
                
                NSString *strDate = [dateFormat1  stringFromDate:[NSDate date]];// string with yyyy-MM-dd format
                
                [self setDataInTableArrayOnselectedDate:strDate];
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
-(void)setDataInTableArrayOnselectedDate:(NSString *)selectedDate{
    [arrTableData removeAllObjects];
    
    [arrData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([((CauseListModel *)obj).HearingDate isEqualToString:selectedDate]) {
                [arrTableData addObject:obj];
            }
       
    }];
    [_tblView reloadData];
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


@end
