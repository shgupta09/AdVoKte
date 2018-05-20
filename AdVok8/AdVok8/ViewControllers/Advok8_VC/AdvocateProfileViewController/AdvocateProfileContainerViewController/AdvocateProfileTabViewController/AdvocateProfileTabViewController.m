//
//  AdvocateProfileTabViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateProfileTabViewController.h"
#import "AdvocProfileTableViewCell.h"
#import "MultiSelectTableViewCell.h"

@interface AdvocateProfileTabViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIDatePicker* pickerForDate;
    UIPickerView * picker;
    NSMutableArray* arrAdvocatetypes;
    AdvocProfileTableViewCell* advocProfileTableViewCell;
    UIPickerView *pickerObj;
    UIView *viewOverPicker;
    NSMutableArray *pickerArray;
    UIToolbar *toolBar;
    NSMutableArray* selectedItemsSecondary;
    NSMutableArray* arrPractiseSecondary;
    MultiSelectTableViewCell* multiSelectTableViewCell;
    LoderView* loderObj;
    NSString* startDateString;
    NSDate *startDate;
}
@end

@implementation AdvocateProfileTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:notification_refreshMCARequest_profileData object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProfileData) name:notification_refreshMCARequest_profileData object:nil];
    
    [self initialiseView];
    [self initialiseData];
}

-(void)initialiseView
{
    [self setUpTableView];
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

-(void)initialiseData
{
    _tblMultiSelect.hidden = true;
    _btnClose.hidden = true;
    _viTrans.hidden = true;
    picker = [UIPickerView new];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    arrAdvocatetypes = [NSMutableArray new];
    arrAdvocatetypes = [[NSMutableArray alloc] initWithObjects:@"Student",@"Intern",@"Practicing",@"Mutual Funds", nil];
    pickerArray = [NSMutableArray new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProfileData) name:@"Refresh_Profile_Availability_Data" object:nil];
    selectedItemsSecondary  = [NSMutableArray new];
    arrPractiseSecondary  = [NSMutableArray new];
    [arrPractiseSecondary addObjectsFromArray:@[ @"Tax Lawyer",@"Criminal Lawyer",@"Civil Lawyer",@"Marriage Lawyer",@"Divorce Lawyer",@"Company Lawyer",@"Constitutional Lawyer",@"Immigration Lawyer",@"Trademark Lawyer",@"Human Rights Lawyer",@"Media and Entertainment Lawyer",@"Sports Lawyer",@"Environment Lawyer",@"Consumer Lawyer",@"Industrial and Labour Lawyer",@"Insurance Lawyer",@"Family Lawyer",@"Arbitration Lawyer",@"Property Lawyer",@"Traffic and Accident Lawyer",@"Document Drafting Lawyer",@"Cheque Bounce"]];
    [self setupViewWithData];
}

-(void) setupViewWithData
{
//    mca_request_profileDetailsDictUpdated = [[MCAProfileMC alloc]initWithBlankMCAProfileDictionary];
    [self assignDataToCell];
}

-(void)refreshProfileData
{
//    MCAProfileMC *ob = [[MCAProfileMC alloc] initWithCopyData: mca_request_profileDetailsDict];
//    mca_request_profileDetailsDictUpdated = ob;
    [self assignDataToCell];
}

-(void) assignDataToCell
{
    
    advocProfileTableViewCell.txtFirstName.text = global_advocate_profileObj.fname;
    advocProfileTableViewCell.txtLastName.text = global_advocate_profileObj.lname;
    advocProfileTableViewCell.txtEmailID.text = global_advocate_profileObj.EmailId;
    advocProfileTableViewCell.txtContactNumber.text = global_advocate_profileObj.mobile;
    advocProfileTableViewCell.txtGender.text = global_advocate_profileObj.Gender;
    advocProfileTableViewCell.txtFDOB.text = global_advocate_profileObj.DOB;
    advocProfileTableViewCell.txtBarcode.text = global_advocate_profileObj.BarCodeId;
    advocProfileTableViewCell.txtDescription.text = global_advocate_profileObj.PractiseArea;
    advocProfileTableViewCell.txtConsultancyFees.text = global_advocate_profileObj.ConsultancyFees;
    advocProfileTableViewCell.txtAdvocateType.text = global_advocate_profileObj.Advocatetype;
    advocProfileTableViewCell.txt_secondaryArea_container.text = global_advocate_profileObj.SecAOP;
    selectedItemsSecondary = [[global_advocate_profileObj.SecAOP componentsSeparatedByString:@","] mutableCopy];
    advocProfileTableViewCell.txt_primaryArea_container.text = global_advocate_profileObj.AOP;
    advocProfileTableViewCell.txt_year_container.text = global_advocate_profileObj.ExpYear;
    advocProfileTableViewCell.txt_month_container.text = global_advocate_profileObj.ExpMonth;
    
    advocProfileTableViewCell.txtAdvocateType.text = global_advocate_profileObj.Advocatetype;
    if ([global_advocate_profileObj.Advocatetype isEqualToString:@"Student"]){
        advocProfileTableViewCell.viContainer_conditional.hidden = true;
//        advocProfileTableViewCell.cons_viContainerHeight.constant = 0;
//            advocProfileTableViewCell.cons_fullContainerHeight.constant = 1027.5-238;
    }
    else
    {
        advocProfileTableViewCell.viContainer_conditional.hidden = false;
//         advocProfileTableViewCell.cons_viContainerHeight.constant = 238;
//            advocProfileTableViewCell.cons_fullContainerHeight.constant = 1027.5;

        
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
    
    [self.tblView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Textfield delegates methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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
    
    if (textField.tag == 400 || textField.tag == 401 || textField.tag == 402 || textField.tag == 403 ){
        [self addPickerViewWithTag:textField.tag];

        return false;
    }
    else if (textField.tag == 300){
       [self addPickerViewWithTag:textField.tag];
        return false;
    }
    else if (textField.tag == 200){
        [self showDatePicker];
        return false;
    }
    else if (textField.tag == 404){
        _tblMultiSelect.hidden = false;
        _btnClose.hidden = false;
        _viTrans.hidden = false;
        return false;
    }
    return true;
}

#pragma mark - Tableview methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblMultiSelect){
        return arrPractiseSecondary.count;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblMultiSelect){
        static NSString *MyIdentifier = @"MultiSelectTableViewCell";
        multiSelectTableViewCell = (MultiSelectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (multiSelectTableViewCell == nil)
        {
            multiSelectTableViewCell = [[MultiSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        [multiSelectTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        

        multiSelectTableViewCell.lblTitle.text = [arrPractiseSecondary objectAtIndex:indexPath.row];
        if ([selectedItemsSecondary containsObject:[arrPractiseSecondary objectAtIndex:indexPath.row]]){
            [multiSelectTableViewCell.imgViewStatus setImage:[UIImage imageNamed:@"check_active"]];
        }
        else{
            [multiSelectTableViewCell.imgViewStatus setImage:[UIImage imageNamed:@"check-passive"]];
        }
        
        return multiSelectTableViewCell;
    }
    else{
    static NSString *MyIdentifier = @"AdvocProfileTableViewCell";
    advocProfileTableViewCell = (AdvocProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (advocProfileTableViewCell == nil)
    {
        advocProfileTableViewCell = [[AdvocProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [advocProfileTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self configureCell:advocProfileTableViewCell indexPath:indexPath];
    
    return advocProfileTableViewCell;
    }
}

-(void)configureCell:(AdvocProfileTableViewCell *)cell indexPath:(NSIndexPath *) indexPath
{
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0)
    {
        [cell.imgProfileView sd_setImageWithURL:[CommonFunction getProfilePicURLString:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"]] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
        cell.txtFirstName.text = global_advocate_profileObj.fname;
        cell.txtLastName.text = global_advocate_profileObj.lname;
        cell.txtEmailID.text = global_advocate_profileObj.EmailId;
        cell.txtContactNumber.text = global_advocate_profileObj.mobile;
        cell.txtGender.text = global_advocate_profileObj.Gender;
        cell.txtFDOB.text = global_advocate_profileObj.DOB;
        cell.txtBarcode.text = global_advocate_profileObj.BarCodeId;
        cell.txtDescription.text = global_advocate_profileObj.PractiseArea;
        cell.txtConsultancyFees.text = global_advocate_profileObj.ConsultancyFees;
        cell.txtAdvocateType.text = global_advocate_profileObj.Advocatetype;
        cell.txt_secondaryArea_container.text = global_advocate_profileObj.SecAOP;
        selectedItemsSecondary = [[global_advocate_profileObj.SecAOP componentsSeparatedByString:@","] mutableCopy];
        cell.txt_primaryArea_container.text = global_advocate_profileObj.AOP;
        cell.txt_year_container.text = global_advocate_profileObj.ExpYear;
        cell.txt_month_container.text = global_advocate_profileObj.ExpMonth;

        cell.txtAdvocateType.text = global_advocate_profileObj.Advocatetype;
        if ([global_advocate_profileObj.Advocatetype isEqualToString:@"Student"]){
            advocProfileTableViewCell.viContainer_conditional.hidden = true;
//            advocProfileTableViewCell.cons_viContainerHeight.constant = 0;
//            advocProfileTableViewCell.cons_fullContainerHeight.constant = 1027.5-238;
        }
        else
        {
            advocProfileTableViewCell.viContainer_conditional.hidden = false;
//             advocProfileTableViewCell.cons_viContainerHeight.constant = 238;
//            advocProfileTableViewCell.cons_fullContainerHeight.constant = 1027.5;


            
        }
        
        cell.txtFirstName.delegate = self;
        cell.txtLastName.delegate = self;
        cell.txtEmailID.delegate = self;
        cell.txtContactNumber.delegate = self;
        cell.txtGender.delegate = self;
        cell.txtFDOB.delegate = self;
        cell.txtBarcode.delegate = self;
        cell.txtDescription.delegate = self;
        cell.txtConsultancyFees.delegate = self;
        cell.txtAdvocateType.delegate = self;

        
        
//
        cell.txtContactNumber.keyboardType = UIKeyboardTypeNumberPad;
        cell.txtConsultancyFees.keyboardType = UIKeyboardTypeNumberPad;
//
        [cell.btnUpdateProfile addTarget:self action:@selector(hitApiToPutProfileData) forControlEvents:UIControlEventTouchUpInside];

        //        [cell.btnNext addTarget:self action:@selector(btnNextTapped:) forControlEvents:UIControlEventTouchUpInside];
//
//        [cell.txtContactNu addCountryCode];
//
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
//        [button setImage:[UIImage imageNamed:@"down-arrow"] forState:UIControlStateNormal];
//        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        button.tag = indexPath.row;
//        cell.txtFundTypes.rightView = button;
//        cell.txtFundTypes.rightViewMode = UITextFieldViewModeAlways;
//
//        UIToolbar* toolbar;
//        toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
//        toolbar.barStyle = UIBarStyleDefault;
//        toolbar.items = [NSArray arrayWithObjects:
//                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneForPicker)],
//                         nil];
//        [toolbar sizeToFit];
//        cell.txtFundTypes.inputAccessoryView = toolbar;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tblMultiSelect){
        if ([selectedItemsSecondary containsObject:[arrPractiseSecondary objectAtIndex:indexPath.row]]){
            [selectedItemsSecondary removeObject:[arrPractiseSecondary objectAtIndex:indexPath.row]];
        }
        else
        {
            [selectedItemsSecondary addObject:[arrPractiseSecondary objectAtIndex:indexPath.row]];
        }
        [_tblMultiSelect reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        advocProfileTableViewCell.txt_secondaryArea_container.text = [selectedItemsSecondary componentsJoinedByString:@","];
    }
    else
    {
        
    }
}

//[pickerArray removeAllObjects];
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
    
    switch (tagForPicker) {
        case 300:
        {
            [pickerArray removeAllObjects];
            [pickerArray addObjectsFromArray: @[@"Male",@"Female"]];
        }
            break;
        case 400:
        {
            [pickerArray removeAllObjects];
            [pickerArray addObjectsFromArray: arrAdvocatetypes];
        }
            break;
        case 401:
        {
            [pickerArray removeAllObjects];
            for (int i=1;i<51;i++){
                [pickerArray addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
            break;
        case 402:
        {
            [pickerArray removeAllObjects];
            for (int i=1;i<12;i++){
                [pickerArray addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
            break;
 
        case 403:
        {
            [pickerArray removeAllObjects];
            [pickerArray addObjectsFromArray:arrPractiseSecondary];
        }
            break;

        default:
            break;
    }
    
    
    
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


#pragma mark - Picker View Delegates Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *ob = [pickerArray objectAtIndex:row];
    return ob;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *ob = [pickerArray objectAtIndex:row];

    switch (pickerView.tag) {
        case 400:
        {
            advocProfileTableViewCell.txtAdvocateType.text = ob;
            if ([ob isEqualToString:@"Student"]){
                advocProfileTableViewCell.viContainer_conditional.hidden = true;
//                advocProfileTableViewCell.cons_viContainerHeight.constant = 0;
//            advocProfileTableViewCell.cons_fullContainerHeight.constant = 1027.5-238;
            }
            else
            {
                advocProfileTableViewCell.viContainer_conditional.hidden = false;
// advocProfileTableViewCell.cons_viContainerHeight.constant = 238;
//            advocProfileTableViewCell.cons_fullContainerHeight.constant = 1027.5;

            }
        }
            break;
            
        case 401:
        {
            advocProfileTableViewCell.txt_year_container.text = ob;
        }
            break;
            
        case 402:
        {
            advocProfileTableViewCell.txt_month_container.text = ob;
        }
            break;
            
        case 403:
        {
            advocProfileTableViewCell.txt_primaryArea_container.text = ob;
        }
            break;
        case 300:
        {
            advocProfileTableViewCell.txtGender.text = ob;
        }
            break;

       default:
            break;
    }
}


#pragma mark - Actions Methods

-(void)doneForPicker:(id)sender{
    [viewOverPicker removeFromSuperview];
}
-(void)resignResponder{
    [viewOverPicker removeFromSuperview];
}

-(void)updateProfileTapped{
    
}



//-(BOOL) ifProfileUpdated
//{
//    if (mca_request_profileDetailsDictUpdated.loanAmount != mca_request_profileDetailsDict.loanAmount)
//    {
//        return true;
//    }
//    else if (![mca_request_profileDetailsDictUpdated.contactNo isEqualToString:mca_request_profileDetailsDict.contactNo])
//    {
//        return true;
//    }
//    else if (![mca_request_profileDetailsDictUpdated.cityName isEqualToString:mca_request_profileDetailsDict.cityName]) {
//        return true;
//    }
//    else if (![mca_request_profileDetailsDictUpdated.emailId isEqualToString:mca_request_profileDetailsDict.emailId]) {
//        return true;
//    }
//    else if (![mca_request_profileDetailsDictUpdated.typeOfFund isEqualToString:mca_request_profileDetailsDict.typeOfFund]) {
//        return true;
//    }
//    
//    return false;
//}
//
//-(void) getUpdatedData
//{
//    mca_request_profileDetailsDictUpdated.loanAmount = [NSNumber numberWithInteger: [mcaProfileFormCell.txtLoanAmount.text integerValue]];
//    mca_request_profileDetailsDictUpdated.cityName = mcaProfileFormCell.txtCity.text;
//    mca_request_profileDetailsDictUpdated.emailId = mcaProfileFormCell.txtEmailId.text;
//    mca_request_profileDetailsDictUpdated.contactNo = mcaProfileFormCell.txtContactNu.text;
//    
//    NSString *fundTypeDesc = mcaProfileFormCell.txtFundTypes.text.lowercaseString;
//    for (TGMasterCodeMC *ob in arrFundtypes)
//    {
//        if ([ob.defaultDesc.lowercaseString isEqualToString:fundTypeDesc])
//        {
//            mca_request_profileDetailsDictUpdated.typeOfFund = ob.codeKey;
//        }
//    }
//}
- (IBAction)btnCloseTapped:(id)sender {
    _tblMultiSelect.hidden = true;
    _btnClose.hidden = true;
    _viTrans.hidden = true;
}

#pragma mark - Api Methods

-(void)hitApiToPutProfileData{
    
    NSMutableDictionary* parameter = [NSMutableDictionary new];
    
    NSMutableDictionary* dictEdu = [NSMutableDictionary new];
//{"username":"8896292603","EmailId":"dharm@malinator.com","fname":"Vineet","mobile":"8896292603","lname":"Singh","DOB":"04/11/2018","Dsc":"","AOP":"Criminal Lawyer","PA":"4,6,12,14","BarCodeId":"wwwwwwww","Gender":"Male","FirmName":"","SecAOP":"Civil Lawyer,Marriage Lawyer,Company Lawyer,Property Lawyer,Traffic and Accident Lawyer","ConsultancyFees":"1200.00","Advocatetype":null,"ExpYear":"4","ExpMonth":"1","OtherPractiseArea":""}
    
    
    [dictEdu setObject:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"username"];
    [dictEdu setObject:advocProfileTableViewCell.txtEmailID.text forKey:@"EmailId"];
    [dictEdu setObject:advocProfileTableViewCell.txtFirstName.text forKey:@"fname"];
    [dictEdu setObject:advocProfileTableViewCell.txtContactNumber.text forKey:@"mobile"];
    [dictEdu setObject:advocProfileTableViewCell.txtLastName.text forKey:@"lname"];
    [dictEdu setObject:advocProfileTableViewCell.txtFDOB.text forKey:@"DOB"];
    [dictEdu setObject:advocProfileTableViewCell.txt_primaryArea_container.text forKey:@"AOP"];
    [dictEdu setObject:global_advocate_profileObj.PA forKey:@"PA"];
    [dictEdu setObject:advocProfileTableViewCell.txtBarcode.text forKey:@"BarCodeId"];
    [dictEdu setObject:advocProfileTableViewCell.txtGender.text forKey:@"Gender"];
    [dictEdu setObject:advocProfileTableViewCell.txtDescription.text forKey:@"FirmName"];
    [dictEdu setObject:advocProfileTableViewCell.txt_secondaryArea_container.text forKey:@"SecAOP"];
    [dictEdu setObject:advocProfileTableViewCell.txtConsultancyFees.text forKey:@"ConsultancyFees"];
    [dictEdu setObject:advocProfileTableViewCell.txtAdvocateType.text forKey:@"Advocatetype"];
    [dictEdu setObject:advocProfileTableViewCell.txt_year_container.text forKey:@"ExpYear"];
    [dictEdu setObject:advocProfileTableViewCell.txt_month_container.text forKey:@"ExpMonth"];
    [dictEdu setObject:@"" forKey:@"OtherPractiseArea"];

    [parameter setValue:dictEdu forKey:@"_UpdAdv"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_SAVE_PROFILE]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    [self removeloder];
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


#pragma mark- Date Picker

// Set the default date
-(void)setDefaultDate{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YYYY"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    startDateString = [dateFormatter stringFromDate:[NSDate date]];
    startDate = [NSDate date];
    
    advocProfileTableViewCell.txtFDOB.text = startDateString;
}
// Show the date picker
-(void)showDatePicker{
    pickerForDate = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    
    pickerForDate.datePickerMode = UIDatePickerModeDate;
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
    advocProfileTableViewCell.txtFDOB.text = startDateString;
    
    
}


@end

