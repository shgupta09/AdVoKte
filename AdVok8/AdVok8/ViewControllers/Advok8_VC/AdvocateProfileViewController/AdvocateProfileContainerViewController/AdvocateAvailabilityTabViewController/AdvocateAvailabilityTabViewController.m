//
//  AdvocateAvailabilityTabViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateAvailabilityTabViewController.h"
#import "AdvocAvailabilityTableViewCell.h"

@interface AdvocateAvailabilityTabViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIPickerView * picker;
    NSMutableArray* arrAdvocatetypes;
    AdvocAvailabilityTableViewCell* advocAvailabilityTableViewCell;
    ADRegistrationModel* advocate_profileObj_Updated;
    int count;
    UIDatePicker* pickerForDate;
 LoderView* loderObj;
    UIView *viewOverPicker;
    UIToolbar *toolBar;
    
    NSString* strMonStart;
    NSString* strMonEnd;
    NSString* strTueStart;
    NSString* strTueEnd;
    NSString* strWedStart;
    NSString* strWedEnd;
    NSString* strThursStart;
    NSString* strThusrEnd;
    NSString* strFriStart;
    NSString* strFriEnd;
    NSString* strSatStart;
    NSString* strSatEnd;
    NSString* strSunStart;
    NSString* strSunEnd;
    NSString* strAllTimeStart;
    NSString* strAllTimeEnd;
    

}

@end

@implementation AdvocateAvailabilityTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProfileData) name:@"Refresh_Profile_Availability_Data" object:nil];
    //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProfileData) name:notification_refreshMCARequest_profileData object:nil];
    
    
    [self initialiseView];
    [self initialiseData];
}

-(void)initialiseView
{
    [self setUpTableView];
}

-(void)initialiseData
{
    picker = [UIPickerView new];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    advocate_profileObj_Updated = [ADRegistrationModel new];
    advocate_profileObj_Updated = global_advocate_profileObj;
    
    arrAdvocatetypes = [NSMutableArray new];
    arrAdvocatetypes = [[NSMutableArray alloc] initWithObjects:@"Student",@"Intern",@"Practicing",@"Mutual Funds", nil];
    
    strMonStart = @"10:10 AM";
strMonEnd = @"10:10 AM";
strTueStart = @"10:10 AM";
strTueEnd = @"10:10 AM";
strWedStart = @"10:10 AM";
strWedEnd = @"10:10 AM";
strThursStart = @"10:10 AM";
strThusrEnd = @"10:10 AM";
strFriStart = @"10:10 AM";
strFriEnd = @"10:10 AM";
strSatStart = @"10:10 AM";
strSatEnd = @"10:10 AM";
strSunStart = @"10:10 AM";
strSunEnd = @"10:10 AM";

    [self setupViewWithData];
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.navigationController.view.frame;
}

-(void) setupViewWithData
{
    //    mca_request_profileDetailsDictUpdated = [[MCAProfileMC alloc]initWithBlankMCAProfileDictionary];
    [self assignDataToCell];
}

-(void)refreshProfileData
{
    [self assignDataToCell];
}

-(void) assignDataToCell
{

    advocAvailabilityTableViewCell.txtOfcAddress1.text = advocate_profileObj_Updated.OffAddline;
    advocAvailabilityTableViewCell.txtOfcAddress2.text = advocate_profileObj_Updated.OffAddline2;
    advocAvailabilityTableViewCell.txtOfcPincode.text = advocate_profileObj_Updated.OffPincode;

    [self resetbuttons];
    
    if ([advocate_profileObj_Updated.mon isEqualToString:@"1"]){
        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
            if (btn.tag == 1001){
                [btn setSelected:true];
            }
        }
        [advocAvailabilityTableViewCell.btnMonStart setTitle:[[advocate_profileObj_Updated.MonTime componentsSeparatedByString:@"-"] objectAtIndex:0] forState:UIControlStateNormal];
        [advocAvailabilityTableViewCell.btnMonEnd setTitle:[[advocate_profileObj_Updated.MonTime componentsSeparatedByString:@"-"] objectAtIndex:1] forState:UIControlStateNormal];
        strMonStart = [[advocate_profileObj_Updated.MonTime componentsSeparatedByString:@"-"] objectAtIndex:0];
        strMonEnd = [[advocate_profileObj_Updated.MonTime componentsSeparatedByString:@"-"] objectAtIndex:1];
    }
    if ([advocate_profileObj_Updated.tues isEqualToString:@"1"]){
        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
            if (btn.tag == 1002){
                [btn setSelected:true];
            }
        }
        [advocAvailabilityTableViewCell.btnTueStart setTitle:[[advocate_profileObj_Updated.TueTime componentsSeparatedByString:@"-"] objectAtIndex:0] forState:UIControlStateNormal];
        [advocAvailabilityTableViewCell.btnTueEnd setTitle:[[advocate_profileObj_Updated.TueTime componentsSeparatedByString:@"-"] objectAtIndex:1] forState:UIControlStateNormal];
        strTueStart = [[advocate_profileObj_Updated.TueTime componentsSeparatedByString:@"-"] objectAtIndex:0];
        strTueEnd = [[advocate_profileObj_Updated.TueTime componentsSeparatedByString:@"-"] objectAtIndex:1];


    }
    if ([advocate_profileObj_Updated.wed isEqualToString:@"1"]){
        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
            if (btn.tag == 1003){
                [btn setSelected:true];
            }
        }
        [advocAvailabilityTableViewCell.btnWedStart setTitle:[[advocate_profileObj_Updated.WedTime componentsSeparatedByString:@"-"] objectAtIndex:0] forState:UIControlStateNormal];
        [advocAvailabilityTableViewCell.btnWedEnd setTitle:[[advocate_profileObj_Updated.WedTime componentsSeparatedByString:@"-"] objectAtIndex:1] forState:UIControlStateNormal];
        
        strWedStart = [[advocate_profileObj_Updated.WedTime componentsSeparatedByString:@"-"] objectAtIndex:0];
        strWedEnd = [[advocate_profileObj_Updated.WedTime componentsSeparatedByString:@"-"] objectAtIndex:1];
     }
 
    if ([advocate_profileObj_Updated.thu isEqualToString:@"1"]){
        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
            if (btn.tag == 1004){
                [btn setSelected:true];
            }
        }
        [advocAvailabilityTableViewCell.btnThurStart setTitle:[[advocate_profileObj_Updated.ThuTime componentsSeparatedByString:@"-"] objectAtIndex:0] forState:UIControlStateNormal];
        [advocAvailabilityTableViewCell.btnThursEnd setTitle:[[advocate_profileObj_Updated.ThuTime componentsSeparatedByString:@"-"] objectAtIndex:1] forState:UIControlStateNormal];
        strThursStart = [[advocate_profileObj_Updated.ThuTime componentsSeparatedByString:@"-"] objectAtIndex:0];
        strThusrEnd = [[advocate_profileObj_Updated.ThuTime componentsSeparatedByString:@"-"] objectAtIndex:1];
    }
    if ([advocate_profileObj_Updated.fri isEqualToString:@"1"]){
        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
            if (btn.tag == 1005){
                [btn setSelected:true];
            }
        }
        [advocAvailabilityTableViewCell.btnFriStart setTitle:[[advocate_profileObj_Updated.FriTime componentsSeparatedByString:@"-"] objectAtIndex:0] forState:UIControlStateNormal];
        [advocAvailabilityTableViewCell.btnFriEnd setTitle:[[advocate_profileObj_Updated.FriTime componentsSeparatedByString:@"-"] objectAtIndex:1] forState:UIControlStateNormal];

        strFriStart = [[advocate_profileObj_Updated.FriTime componentsSeparatedByString:@"-"] objectAtIndex:0];
        strFriEnd = [[advocate_profileObj_Updated.FriTime componentsSeparatedByString:@"-"] objectAtIndex:1];

    }
    if ([advocate_profileObj_Updated.sat isEqualToString:@"1"]){
        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
            if (btn.tag == 1006){
                [btn setSelected:true];
            }
        }
        [advocAvailabilityTableViewCell.btnSatStart setTitle:[[advocate_profileObj_Updated.SatTime componentsSeparatedByString:@"-"] objectAtIndex:0] forState:UIControlStateNormal];
        [advocAvailabilityTableViewCell.btnSatEnd setTitle:[[advocate_profileObj_Updated.SatTime componentsSeparatedByString:@"-"] objectAtIndex:1] forState:UIControlStateNormal];
        strSatStart = [[advocate_profileObj_Updated.SatTime componentsSeparatedByString:@"-"] objectAtIndex:0];
        strSatEnd = [[advocate_profileObj_Updated.SatTime componentsSeparatedByString:@"-"] objectAtIndex:1];
    }
    if ([advocate_profileObj_Updated.sun isEqualToString:@"1"]){
        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
            if (btn.tag == 1007){
                [btn setSelected:true];
            }
        }
        [advocAvailabilityTableViewCell.btnSunStart setTitle:[[advocate_profileObj_Updated.SunTime componentsSeparatedByString:@"-"] objectAtIndex:0] forState:UIControlStateNormal];
        [advocAvailabilityTableViewCell.btnSunEnd setTitle:[[advocate_profileObj_Updated.SunTime componentsSeparatedByString:@"-"] objectAtIndex:1] forState:UIControlStateNormal];
        strSunStart = [[advocate_profileObj_Updated.SunTime componentsSeparatedByString:@"-"] objectAtIndex:0];
        strSunEnd = [[advocate_profileObj_Updated.SunTime componentsSeparatedByString:@"-"] objectAtIndex:1];

    }
    
    AdvocAvailabilityTableViewCell* cell = [_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [cell.btnSunStart setTitle:strSunStart forState:UIControlStateNormal];
    [cell.btnSunEnd setTitle:strSunEnd forState:UIControlStateNormal];
    [cell.btnMonStart setTitle:strMonStart forState:UIControlStateNormal];
    [cell.btnMonEnd setTitle:strMonEnd forState:UIControlStateNormal];
    [cell.btnTueStart setTitle:strTueStart forState:UIControlStateNormal];
    [cell.btnTueEnd setTitle:strTueEnd forState:UIControlStateNormal];
    [cell.btnWedStart setTitle:strWedStart forState:UIControlStateNormal];
    [cell.btnWedEnd setTitle:strWedEnd forState:UIControlStateNormal];
    [cell.btnThurStart setTitle:strThursStart forState:UIControlStateNormal];
    [cell.btnThursEnd setTitle:strThusrEnd forState:UIControlStateNormal];
    [cell.btnFriStart setTitle:strFriStart forState:UIControlStateNormal];
    [cell.btnFriEnd setTitle:strFriEnd forState:UIControlStateNormal];
    [cell.btnSatStart setTitle:strSatStart forState:UIControlStateNormal];
    [cell.btnSatStart setTitle:strSatStart forState:UIControlStateNormal];
    


}

-(void) resetbuttons{
 
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        [btn setSelected:false];
    }
}

-(void)setUpTableView
{
    self.tblView.scrollsToTop = NO;
    self.tblView.backgroundColor = [UIColor clearColor];
    self.tblView.delegate = self;
    self.tblView.dataSource = self;
    self.tblView.showsVerticalScrollIndicator = NO;
    self.tblView.showsHorizontalScrollIndicator = NO;
    self.tblView.tableFooterView = [UIView new];
    
    [self reloadTbl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Textfield delegates methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if (textField == mcaProfileFormCell.txtContactNu && textField.text.length > 9 && range.length == 0)
    //    {
    //        return NO;
    //    }
    //
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}

#pragma mark - Tableview methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0){
        return 839-350+(50*count);
    }
    else
    {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"AdvocAvailabilityTableViewCell";
    advocAvailabilityTableViewCell = (AdvocAvailabilityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (advocAvailabilityTableViewCell == nil)
    {
        advocAvailabilityTableViewCell = [[AdvocAvailabilityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [advocAvailabilityTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self configureCell:advocAvailabilityTableViewCell indexPath:indexPath];
    
    
    return advocAvailabilityTableViewCell;
}

-(void)reloadTbl{
    advocate_profileObj_Updated.OffAddline = advocAvailabilityTableViewCell.txtOfcAddress1.text;
    advocate_profileObj_Updated.OffAddline2 = advocAvailabilityTableViewCell.txtOfcAddress2.text;
    advocate_profileObj_Updated.OffPincode = advocAvailabilityTableViewCell.txtOfcPincode.text;
   [self.tblView reloadData];
}
-(void)configureCell:(AdvocAvailabilityTableViewCell *)cell indexPath:(NSIndexPath *) indexPath
{
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0)
    {
            advocAvailabilityTableViewCell.txtOfcAddress1.text = advocate_profileObj_Updated.OffAddline;
            advocAvailabilityTableViewCell.txtOfcAddress2.text = advocate_profileObj_Updated.OffAddline2;
            advocAvailabilityTableViewCell.txtOfcPincode.text = advocate_profileObj_Updated.OffPincode;
       
       
        [self resetbuttons];
        
        if ([advocate_profileObj_Updated.mon isEqualToString:@"1"]){
            for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
                if (btn.tag == 1001){
                    [btn setSelected:true];
                }
            }
        }
        if ([advocate_profileObj_Updated.tues isEqualToString:@"1"]){
            for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
                if (btn.tag == 1002){
                    [btn setSelected:true];
                }
            }
        }
        if ([advocate_profileObj_Updated.wed isEqualToString:@"1"]){
            for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
                if (btn.tag == 1003){
                    [btn setSelected:true];
                }
            }
        }
        if ([advocate_profileObj_Updated.thu isEqualToString:@"1"]){
            for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
                if (btn.tag == 1004){
                    [btn setSelected:true];
                }
            }
        }
        if ([advocate_profileObj_Updated.fri isEqualToString:@"1"]){
            for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
                if (btn.tag == 1005){
                    [btn setSelected:true];
                }
            }
        }
        if ([advocate_profileObj_Updated.sat isEqualToString:@"1"]){
            for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
                if (btn.tag == 1006){
                    [btn setSelected:true];
                }
            }
        }
        if ([advocate_profileObj_Updated.sun isEqualToString:@"1"]){
            for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
                if (btn.tag == 1007){
                    [btn setSelected:true];
                }
            }
        }
        
        [self setStackView];
        cell.txtOfcPincode.delegate = self;
        cell.txtOfcAddress1.delegate = self;
        cell.txtOfcAddress2.delegate = self;

        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect){
            [btn addTarget:self action:@selector(btnDaysSelectedTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [cell.btnMonStart addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnTueStart addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnWedStart addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnThurStart addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnFriStart addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSatStart addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSunStart addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnMonEnd addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnTueEnd addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnWedEnd addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnThursEnd addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnFriEnd addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSatEnd addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSunEnd addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];

        
        [cell.btnSunStart setTitle:strSunStart forState:UIControlStateNormal];
        [cell.btnSunEnd setTitle:strSunEnd forState:UIControlStateNormal];
        [cell.btnMonStart setTitle:strMonStart forState:UIControlStateNormal];
        [cell.btnMonEnd setTitle:strMonEnd forState:UIControlStateNormal];
        [cell.btnTueStart setTitle:strTueStart forState:UIControlStateNormal];
        [cell.btnTueEnd setTitle:strTueEnd forState:UIControlStateNormal];
        [cell.btnWedStart setTitle:strWedStart forState:UIControlStateNormal];
        [cell.btnWedEnd setTitle:strWedEnd forState:UIControlStateNormal];
        [cell.btnThurStart setTitle:strThursStart forState:UIControlStateNormal];
        [cell.btnThursEnd setTitle:strThusrEnd forState:UIControlStateNormal];
        [cell.btnFriStart setTitle:strFriStart forState:UIControlStateNormal];
        [cell.btnFriEnd setTitle:strFriEnd forState:UIControlStateNormal];
        [cell.btnSatStart setTitle:strSatStart forState:UIControlStateNormal];
        [cell.btnSatEnd setTitle:strSatEnd forState:UIControlStateNormal];
        
        [cell.btnUpdate addTarget:self action:@selector(btnUpdateClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (cell.btnSameForAll.isSelected){
            cell.stackViewAllSelectedTime.hidden = false;
        }
        else
        {
            cell.stackViewAllSelectedTime.hidden = true;
        }

        [cell.btnAllStartTime addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAllEndTime addTarget:self action:@selector(btnSelectTime:) forControlEvents:UIControlEventTouchUpInside];

        [cell.btnSameForAll addTarget:self action:@selector(btnSameForAllClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
}

-(IBAction)btnUpdateClicked:(id)sender{
    
    
    [self hitApiToPutAvailabilityData];
    
    
}

-(IBAction)btnSameForAllClicked:(id)sender{
    
    UIButton* btnPressed = (UIButton*)sender;
    AdvocAvailabilityTableViewCell* cell = [_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (btnPressed.isSelected){
        [btnPressed setSelected:false];
        cell.stackViewAllSelectedTime.hidden = true;
        
    }
    else
    {
         [btnPressed setSelected:true];
        cell.stackViewAllSelectedTime.hidden = false;
        for (UIButton* btn in cell.btnDaysSelect) {
            
                [btn setSelected:false];
        }
        advocate_profileObj_Updated.mon = @"0";
        advocate_profileObj_Updated.tues = @"0";
        advocate_profileObj_Updated.wed = @"0";
        advocate_profileObj_Updated.thu = @"0";
        advocate_profileObj_Updated.fri = @"0";
        advocate_profileObj_Updated.sat = @"0";
        advocate_profileObj_Updated.sun = @"0";
        [self setStackView];
        [self reloadTbl];
        [_tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:false];

    }
}

-(IBAction)btnSelectTime:(id)sender{
    
    UIButton* btnPressed = (UIButton*)sender;
    [self showDatePicker:sender];

   
}

-(IBAction)btnDaysSelectedTapped:(id)sender
{
    UIButton* btn = sender;
    NSString* state = @"";
    if (btn.selected == true){
        btn.selected = false;
        state = @"0";
    }
    else{
        btn.selected = true;
        state = @"1";
    }
    switch (btn.tag) {
        case 1001:
            advocate_profileObj_Updated.mon = state;
            break;
        case 1002:
            advocate_profileObj_Updated.tues = state;
            break;
        case 1003:
            advocate_profileObj_Updated.wed = state;
            break;
        case 1004:
            advocate_profileObj_Updated.thu = state;
            break;
        case 1005:
            advocate_profileObj_Updated.fri = state;
            break;
        case 1006:
            advocate_profileObj_Updated.sat = state;
            break;
        case 1007:
            advocate_profileObj_Updated.sun = state;
            break;

        default:
            break;
    }
    
    [self setStackView];
    [self reloadTbl];
    [_tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:false];
}

-(void) setStackView{
    [self resetStackView];
    count = 0;
    if ([advocate_profileObj_Updated.mon isEqualToString:@"1"]){
        advocAvailabilityTableViewCell.cons_mondayView_height.constant = 50;
        advocAvailabilityTableViewCell.viMonday.hidden = false;
        count++;
    }
    if ([advocate_profileObj_Updated.tues isEqualToString:@"1"]){
        advocAvailabilityTableViewCell.cons_tuesView_height.constant = 50;
        advocAvailabilityTableViewCell.vi_tuesday.hidden = false;
        count++;
    }
    if ([advocate_profileObj_Updated.wed isEqualToString:@"1"]){
        advocAvailabilityTableViewCell.cons_wednesdayView_height.constant = 50;
        advocAvailabilityTableViewCell.vi_wednesday.hidden = false;
        count++;
    }
    if ([advocate_profileObj_Updated.thu isEqualToString:@"1"]){
        advocAvailabilityTableViewCell.cons_thursView_height.constant = 50;
        advocAvailabilityTableViewCell.vi_thurday.hidden = false;
        count++;
    }
    if ([advocate_profileObj_Updated.fri isEqualToString:@"1"]){
        advocAvailabilityTableViewCell.cons_friView_height.constant = 50;
        advocAvailabilityTableViewCell.vi_friday.hidden = false;
        count++;
    }
    if ([advocate_profileObj_Updated.sat isEqualToString:@"1"]){
        advocAvailabilityTableViewCell.cons_satView_height.constant = 50;
        advocAvailabilityTableViewCell.viSaturday.hidden = false;
        count++;
    }
    if ([advocate_profileObj_Updated.sun isEqualToString:@"1"]){
        advocAvailabilityTableViewCell.cons_sunView_height.constant = 50;
        advocAvailabilityTableViewCell.viSunday.hidden = false;

        count++;
    }
    
    advocAvailabilityTableViewCell.cons_stackViewWeekHeight.constant = 50*count;
}

-(void) resetStackView
{
    advocAvailabilityTableViewCell.cons_mondayView_height.constant = 0;
    advocAvailabilityTableViewCell.cons_tuesView_height.constant = 0;
    advocAvailabilityTableViewCell.cons_wednesdayView_height.constant = 0;
    advocAvailabilityTableViewCell.cons_thursView_height.constant = 0;
    advocAvailabilityTableViewCell.cons_friView_height.constant = 0;
    advocAvailabilityTableViewCell.cons_satView_height.constant = 0;
    advocAvailabilityTableViewCell.cons_sunView_height.constant = 0;
    
    advocAvailabilityTableViewCell.viMonday.hidden = true;
    advocAvailabilityTableViewCell.vi_tuesday.hidden = true;
    advocAvailabilityTableViewCell.vi_wednesday.hidden = true;
    advocAvailabilityTableViewCell.vi_thurday.hidden = true;
    advocAvailabilityTableViewCell.vi_friday.hidden = true;
    advocAvailabilityTableViewCell.viSaturday.hidden = true;
    advocAvailabilityTableViewCell.viSunday.hidden = true;

}
#pragma mark - DatePicker View Methods

// Show the date picker
-(void)showDatePicker:(id)sender{
    pickerForDate = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    pickerForDate.tag = ((UIButton *)sender).tag;
    
    pickerForDate.datePickerMode = UIDatePickerModeTime;
    [pickerForDate setDate:[NSDate date]];
    
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
//Resign Responder
-(void)resignResponder{
    [viewOverPicker removeFromSuperview];
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
    [dateFormatter setDateFormat:@"h:mm a"];
    
    switch (sender.tag) {
        case 101:
        {
            
            
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            //        startDate = sender.date;
            
            strMonStart = startDateString;
            [advocAvailabilityTableViewCell.btnMonStart setBackgroundColor:[UIColor redColor]];
            [advocAvailabilityTableViewCell.btnMonStart setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 102:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            //        startDate = sender.date;
            strMonEnd = endDateString;
            [advocAvailabilityTableViewCell.btnMonEnd setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 201:
        {
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            //        startDate = sender.date;
            strTueStart = startDateString;
            [advocAvailabilityTableViewCell.btnTueStart setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 202:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            strTueEnd = endDateString;
            [advocAvailabilityTableViewCell.btnTueEnd setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 301:
        {
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            strWedStart = startDateString;
            [advocAvailabilityTableViewCell.btnWedStart setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 302:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            strWedEnd = endDateString;
            [advocAvailabilityTableViewCell.btnWedEnd setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 401:
        {
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            strThursStart = startDateString;
            [advocAvailabilityTableViewCell.btnThurStart setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 402:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            strThusrEnd = endDateString;
            [advocAvailabilityTableViewCell.btnThursEnd setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 501:
        {
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            strFriStart = startDateString;
            [advocAvailabilityTableViewCell.btnFriStart setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 502:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            strFriEnd = endDateString;
            [advocAvailabilityTableViewCell.btnFriEnd setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 601:
        {
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            strSatStart = startDateString;
            [advocAvailabilityTableViewCell.btnSatStart setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 602:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            strSatEnd = endDateString;
            [advocAvailabilityTableViewCell.btnSatEnd setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 701:
        {
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            strSunStart = startDateString;
            [advocAvailabilityTableViewCell.btnSunStart setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 702:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            strSunEnd = endDateString;
            [advocAvailabilityTableViewCell.btnSunEnd setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 801:
        {
            NSString* startDateString = [dateFormatter stringFromDate:[sender date]];
            strAllTimeStart = startDateString;
            [advocAvailabilityTableViewCell.btnAllStartTime setTitle:startDateString forState:UIControlStateNormal] ;
        }
            break;
            
        case 802:
        {
            NSString* endDateString = [dateFormatter stringFromDate:[sender date]];
            strAllTimeEnd = endDateString;
            [advocAvailabilityTableViewCell.btnAllEndTime setTitle:endDateString forState:UIControlStateNormal] ;
        }
            break;
            

        default:
            break;
    }
    
    AdvocAvailabilityTableViewCell* cell = [_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [cell.btnSunStart setTitle:strSunStart forState:UIControlStateNormal];
    [cell.btnSunEnd setTitle:strSunEnd forState:UIControlStateNormal];
    [cell.btnMonStart setTitle:strMonStart forState:UIControlStateNormal];
    [cell.btnMonEnd setTitle:strMonEnd forState:UIControlStateNormal];
    [cell.btnTueStart setTitle:strTueStart forState:UIControlStateNormal];
    [cell.btnTueEnd setTitle:strTueEnd forState:UIControlStateNormal];
    [cell.btnWedStart setTitle:strWedStart forState:UIControlStateNormal];
    [cell.btnWedEnd setTitle:strWedEnd forState:UIControlStateNormal];
    [cell.btnThurStart setTitle:strThursStart forState:UIControlStateNormal];
    [cell.btnThursEnd setTitle:strThusrEnd forState:UIControlStateNormal];
    [cell.btnFriStart setTitle:strFriStart forState:UIControlStateNormal];
    [cell.btnFriEnd setTitle:strFriEnd forState:UIControlStateNormal];
    [cell.btnSatStart setTitle:strSatStart forState:UIControlStateNormal];
    [cell.btnSatEnd setTitle:strSatEnd forState:UIControlStateNormal];
    [cell.btnAllStartTime setTitle:strAllTimeStart forState:UIControlStateNormal];
    [cell.btnAllEndTime setTitle:strAllTimeEnd forState:UIControlStateNormal];

}



#pragma mark - Api Methods

-(void)hitApiToPutAvailabilityData{
    
    NSMutableDictionary* parameter = [NSMutableDictionary new];
    
    NSMutableDictionary* dictEdu = [NSMutableDictionary new];
    
    [dictEdu setObject:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"username"];
    [dictEdu setObject:advocAvailabilityTableViewCell.txtOfcAddress1.text forKey:@"OffAddline"];
    [dictEdu setObject:advocAvailabilityTableViewCell.txtOfcAddress2.text forKey:@"OffAddline2"];
    [dictEdu setObject:advocAvailabilityTableViewCell.txtOfcPincode.text forKey:@"OffPincode"];
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        if (btn.tag == 1001){
            [dictEdu setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:btn.isSelected]]  forKey:@"mon"];
        }
    }
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        if (btn.tag == 1002){
            [dictEdu setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:btn.isSelected]]  forKey:@"tues"];
        }
    }
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        if (btn.tag == 1003){
            [dictEdu setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:btn.isSelected]]  forKey:@"wed"];
        }
    }
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        if (btn.tag == 1004){
            [dictEdu setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:btn.isSelected]]  forKey:@"thu"];
        }
    }
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        if (btn.tag == 1005){
            [dictEdu setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:btn.isSelected]]  forKey:@"fri"];
        }
    }
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        if (btn.tag == 1006){
            [dictEdu setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:btn.isSelected]]  forKey:@"sat"];
        }
    }
    for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect) {
        if (btn.tag == 1007){
            [dictEdu setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:btn.isSelected]]  forKey:@"sun"];
        }
    }
//{"_UpdAdv":{"username":"8896292603","OffAddline":"","OffAddline2":"A-256 Lakhiram Park rohini New Delhi","OffPincode":"110086","mon":1,"tues":1,"wed":1,"thu":1,"fri":1,"sat":0,"sun":0,"MonTime":"11:00 AM-04:30 PM","TueTime":"11:00 AM-04:30 PM","WedTime":"11:00 AM-04:30 PM","ThuTime":"08:30 AM-07:30 PM","FriTime":"07:30 AM-08:30 AM","SatTime":"","SunTime":"","SameAsTime":false,"SameAsTimeValue":"0"}}
    
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnMonStart currentTitle],[advocAvailabilityTableViewCell.btnMonEnd currentTitle]] forKey:@"MonTime"];
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnTueStart currentTitle],[advocAvailabilityTableViewCell.btnTueEnd currentTitle]] forKey:@"TueTime"];
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnWedStart currentTitle],[advocAvailabilityTableViewCell.btnWedEnd currentTitle]] forKey:@"WedTime"];
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnThurStart currentTitle],[advocAvailabilityTableViewCell.btnThursEnd currentTitle]] forKey:@"ThuTime"];
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnFriStart currentTitle],[advocAvailabilityTableViewCell.btnFriEnd currentTitle]] forKey:@"FriTime"];
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnSatStart currentTitle],[advocAvailabilityTableViewCell.btnSatEnd currentTitle]] forKey:@"SatTime"];
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnSunStart currentTitle],[advocAvailabilityTableViewCell.btnSunEnd currentTitle]] forKey:@"SunTime"];
    
    if (advocAvailabilityTableViewCell.btnSameForAll.isSelected) {
        [dictEdu setObject:@"true"  forKey:@"SameAsTime"];
    }else{
        [dictEdu setObject:@"false"  forKey:@"SameAsTime"];
    }
   
    [dictEdu setObject:[NSString stringWithFormat:@"%@-%@",[advocAvailabilityTableViewCell.btnAllStartTime currentTitle],[advocAvailabilityTableViewCell.btnAllEndTime currentTitle]]  forKey:@"SameAsTimeValue"];
    
    [parameter setValue:dictEdu forKey:@"_UpdAdv"];

    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_PUT_AVAILABILITY]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSMutableArray* arrData = [NSMutableArray new];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    [self.navigationController popViewControllerAnimated:true];
                }else
                {
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    [self.navigationController popViewControllerAnimated:true];
                }
                [self removeloder];
                
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
    loderObj = [[LoderView alloc] initWithFrame:self.navigationController.view.frame];
    loderObj.lbl_title.text = @"Please wait...";
    [[UIApplication sharedApplication].keyWindow addSubview:loderObj];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:loderObj];
}

-(void)removeloder{
    //loderObj = nil;
    [loderObj removeFromSuperview];
    //[loaderView removeFromSuperview];
    self.view.userInteractionEnabled = YES;
}



@end
