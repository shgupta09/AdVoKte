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
    
    
    [self setupViewWithData];
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
    
    [self.tblView reloadData];
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
        
        cell.txtOfcPincode.delegate = self;
        cell.txtOfcAddress1.delegate = self;
        cell.txtOfcAddress2.delegate = self;

        for (UIButton* btn in advocAvailabilityTableViewCell.btnDaysSelect){
            [btn addTarget:self action:@selector(btnDaysSelectedTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
        
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
    
}

//#pragma mark - Picker View Delegates Methods
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return arrFundtypes.count;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    TGMasterCodeMC *ob = [arrFundtypes objectAtIndex:row];
//    return ob.defaultDesc;
//}
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    TGMasterCodeMC *ob = [arrFundtypes objectAtIndex:row];
//    mcaProfileFormCell.txtFundTypes.text = ob.defaultDesc;
//}
//
//#pragma mark - Api Methods
//-(void)performSaveNBFCLeadApiForIntegratedMode
//{
//    if ([self isInternetAvailable])
//    {
//        [self showActivityIndicator];
//
//        AppDelegate *appDelegateOb = [Utility getAppDelegateObject];
//        NbfcLoan *ob = [appDelegateOb.loanEligibleList objectAtIndex: 0];
//
//        BaseOperationQueue *baseOperationQueue = [BaseOperationQueue getInstance];
//        NbfcLoanManager *loanManager = [[NbfcLoanManager alloc] init];
//        loanManager.operationType = oNBFCSaveNbfcLead_integratedMode;
//        loanManager.nbfcLoanType = kNBFCSaveNbfcLead_integratedMode;
//        loanManager.delegate = self;
//
//        loanManager.probileOb = mca_request_profileDetailsDictUpdated;
//        loanManager.integratedWFSTag = @"100";
//        loanManager.completeRequest = mca_request_completeDataDict;
//        loanManager.loanEligibilityId = ob.loanEligibilityId;
//
//        [baseOperationQueue addOperation:loanManager];
//    }
//    else
//    {
//        [[ToastView getInstance] displayToastWithMessage:LOCALIZATION(msg_no_internet_message)];
//    }
//}
//
//- (void) saveNbfcLeadApiPerformed :(MasterResponse *)masterResponse
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        if (masterResponse.status)
//        {
//            if ([masterResponse.messageId isEqualToString:mca_errorCode_saveNBFC_refreshExistingLeadData])
//            {
//                [self hideActivityIndicator];
//                [[NSNotificationCenter defaultCenter] postNotificationName:notification_refreshMCARequest_existingLeadData object:nil];
//            }
//            else
//            {
//                NSArray *parsedArray = [Utility parseDataForMCA:masterResponse.raw];
//                mca_request_profileDetailsDict = parsedArray[0];
//                mca_request_completeDataDict = parsedArray[4];
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:notification_refreshMCARequest_profileData object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:notification_refreshMCARequest_businessData object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:notification_refreshMCARequest_individualData object:nil];
//
//                [self hideActivityIndicator];
//
//                [self moveToNextScreen];
//            }
//        }
//        else
//        {
//            [self hideActivityIndicator];
//            [[ToastView getInstance] displayToastWithMessage:masterResponse.message];
//
//            if ([masterResponse.messageId isEqualToString:mca_errorCode_saveNBFC_refreshExistingLeadData])
//            {
//                [[NSNotificationCenter defaultCenter] postNotificationName:notification_refreshMCARequest_existingLeadData object:nil];
//            }
//            //            else if ([masterResponse.messageId isEqualToString:mca_errorCode_saveNBFC_refreshGetEligibleLoanData])
//            //            {
//            //                // fire notification to refresh NBFC banner and call getEligibleLoanList Api
//            //                [self.navigationController popToRootViewControllerAnimated:YES];
//            //            }
//        }
//    });
//}
//
//- (void) onErrorOccurred :(NSError *)error inOperationTask :(OperationType)operationType
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self hideActivityIndicator];
//        [[ToastView getInstance] displayToastWithMessage:LOCALIZATION(PT_ERROR_MESSAGE)];
//    });
//}
//
//#pragma mark - Other Methods
//-(void)moveToNextScreen
//{
//    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
//    [userInfo setValue:@"Business" forKey:@"ActiveTab"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:notification_MCA_update_tabs object:self userInfo:userInfo];
//
//    [userInfo setValue:self forKey:@"ActiveViewController"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:notification_MCA_Switch_To_Business_Page object:self userInfo:userInfo];
//
//    //[self performSelector:@selector(refreshNextScreen) withObject:nil afterDelay:0.2];
//}
//
//-(void)refreshNextScreen
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:notification_refreshMCARequest_businessData object:nil];
//}
//
//#pragma mark - Actions Methods
//
//-(void)doneForPicker
//{
//    [self.view endEditing:YES];
//}
//
//
//
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



@end
