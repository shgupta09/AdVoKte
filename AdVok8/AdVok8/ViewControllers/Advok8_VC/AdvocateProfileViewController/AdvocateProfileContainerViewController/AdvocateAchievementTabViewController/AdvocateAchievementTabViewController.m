//
//  AdvocateAchievementTabViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateAchievementTabViewController.h"
#import "AdvocAchievementTableViewCell.h"

@interface AdvocateAchievementTabViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    UIPickerView * picker;
    NSMutableArray* arrAdvocatetypes;
    AdvocAchievementTableViewCell* advocAchievementTableViewCell;
}

@end

@implementation AdvocateAchievementTabViewController

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

-(void)initialiseData
{
    picker = [UIPickerView new];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
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
    //    MCAProfileMC *ob = [[MCAProfileMC alloc] initWithCopyData: mca_request_profileDetailsDict];
    //    mca_request_profileDetailsDictUpdated = ob;
    [self assignDataToCell];
}

-(void) assignDataToCell
{
    
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
    static NSString *MyIdentifier = @"AdvocAchievementTableViewCell";
    advocAchievementTableViewCell = (AdvocAchievementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (advocAchievementTableViewCell == nil)
    {
        advocAchievementTableViewCell = [[AdvocAchievementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [advocAchievementTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self configureCell:advocAchievementTableViewCell indexPath:indexPath];
    
    return advocAchievementTableViewCell;
}

-(void)configureCell:(AdvocAchievementTableViewCell *)cell indexPath:(NSIndexPath *) indexPath
{
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0)
    {
        
        
        //        cell.txtCity.delegate = self;
        //        cell.txtFundTypes.delegate = self;
        //        cell.txtContactNu.delegate = self;
        //        cell.txtEmailId.delegate = self;
        //        cell.txtLoanAmount.delegate = self;
        //
        //        cell.txtLoanAmount.text = @"" ;
        //        cell.txtCity.text = @"";
        //        cell.txtEmailId.text = @"";
        //        cell.txtContactNu.text = @"";
        //        cell.txtFundTypes.text = @"";
        //
        //        cell.txtLoanAmount.keyboardType = UIKeyboardTypeNumberPad;
        //
        //        cell.txtFundTypes.inputView = picker;
        //        [cell.btnCurrentLocation addTarget:self action:@selector(currentLocationTapped) forControlEvents:UIControlEventTouchUpInside];
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

