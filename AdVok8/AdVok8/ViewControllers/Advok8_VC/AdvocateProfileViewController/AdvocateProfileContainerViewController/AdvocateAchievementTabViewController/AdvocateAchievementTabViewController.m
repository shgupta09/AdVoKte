//
//  AdvocateAchievementTabViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateAchievementTabViewController.h"
#import "AdvocAchievementTableViewCell.h"

@interface AdvocateAchievementTabViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIPickerView * picker;
    NSMutableArray* arrAdvocatetypes;
    AdvocAchievementTableViewCell* advocAchievementTableViewCell;
    LoderView* loderObj;
    NSMutableArray* arr_global_advocate_Education_data_updated;
    NSMutableArray* arr_global_advocate_Membership_data_updated;
    NSMutableArray* arr_global_advocate_WorkingExperience_data_updated;
}

@end

@implementation AdvocateAchievementTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notification_refresh_Acheivement_data" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAcheivementData) name:@"notification_refresh_Acheivement_data" object:nil];
    
    
    [self initialiseView];
    [self initialiseData];
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.navigationController.view.frame;
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
    
    arr_global_advocate_Education_data_updated = [NSMutableArray new];
    arr_global_advocate_WorkingExperience_data_updated = [NSMutableArray new];
    arr_global_advocate_Membership_data_updated = [NSMutableArray new];

    [self setupViewWithData];
}

-(void) setupViewWithData
{
    arr_global_advocate_Education_data_updated = arr_global_advocate_Education_data;
    arr_global_advocate_Membership_data_updated = arr_global_advocate_Membership_data;
    arr_global_advocate_WorkingExperience_data_updated = arr_global_advocate_WorkingExperience_data;

    [self assignDataToCell];
}

-(void)refreshAcheivementData
{
    arr_global_advocate_Education_data_updated = arr_global_advocate_Education_data;
    arr_global_advocate_Membership_data_updated = arr_global_advocate_Membership_data;
    arr_global_advocate_WorkingExperience_data_updated = arr_global_advocate_WorkingExperience_data;

    [self assignDataToCell];
}

-(void) assignDataToCell
{
    
    Education* objEdu = [Education new];
    objEdu = [arr_global_advocate_Education_data objectAtIndex:0];
    advocAchievementTableViewCell.txtEduDegreeName.text = objEdu.DegreeName;
    advocAchievementTableViewCell.txtEduCollege.text = objEdu.College;
    advocAchievementTableViewCell.txtEduToYear.text = objEdu.ToYear;
    advocAchievementTableViewCell.txtEduFromYear.text = objEdu.FromYear;
    
    Membership* objMem = [Membership new];
    objMem = [arr_global_advocate_Membership_data objectAtIndex:0];
    advocAchievementTableViewCell.txtMemMembershipPost.text = objMem.MembershipDesignation;
    advocAchievementTableViewCell.txtMemDuration.text = objMem.MembershipDuration;
    advocAchievementTableViewCell.txtMemCompanyName.text = objMem.MembershipCompany;
    
    WorkingExperience* objworkingExpe = [WorkingExperience new];
    objworkingExpe = [arr_global_advocate_WorkingExperience_data objectAtIndex:0];
    advocAchievementTableViewCell.txtExpDegree.text = objworkingExpe.Designation;
    advocAchievementTableViewCell.txtExpDuration.text = objworkingExpe.Duration;
    advocAchievementTableViewCell.txtExpCompanyName.text = objworkingExpe.Company;

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

-(IBAction)btnUpdateData:(id)sender{
    
    [self getUpdatedData];
    [self hitApiToPutAcheivementData ];
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
        
        advocAchievementTableViewCell.txtEduDegreeName.delegate = self;
        advocAchievementTableViewCell.txtEduCollege.delegate = self;
        advocAchievementTableViewCell.txtEduToYear.delegate = self;
        advocAchievementTableViewCell.txtEduFromYear.delegate = self;
        
        advocAchievementTableViewCell.txtMemMembershipPost.delegate = self;
        advocAchievementTableViewCell.txtMemDuration.delegate = self;
        advocAchievementTableViewCell.txtMemCompanyName.delegate = self;
        
        advocAchievementTableViewCell.txtExpDegree.delegate = self;
        advocAchievementTableViewCell.txtExpDuration.delegate = self;
        advocAchievementTableViewCell.txtExpCompanyName.delegate = self;

        Education* objEdu = [Education new];
        objEdu = [arr_global_advocate_Education_data objectAtIndex:0];
        advocAchievementTableViewCell.txtEduDegreeName.text = objEdu.DegreeName;
        advocAchievementTableViewCell.txtEduCollege.text = objEdu.College;
        advocAchievementTableViewCell.txtEduToYear.text = objEdu.ToYear;
        advocAchievementTableViewCell.txtEduFromYear.text = objEdu.FromYear;
        
        Membership* objMem = [Membership new];
        objMem = [arr_global_advocate_Membership_data objectAtIndex:0];
        advocAchievementTableViewCell.txtMemMembershipPost.text = objMem.MembershipDesignation;
        advocAchievementTableViewCell.txtMemDuration.text = objMem.MembershipDuration;
        advocAchievementTableViewCell.txtMemCompanyName.text = objMem.MembershipCompany;
        
        WorkingExperience* objworkingExpe = [WorkingExperience new];
        objworkingExpe = [arr_global_advocate_WorkingExperience_data objectAtIndex:0];
        advocAchievementTableViewCell.txtExpDegree.text = objworkingExpe.Designation;
        advocAchievementTableViewCell.txtExpDuration.text = objworkingExpe.Duration;
        advocAchievementTableViewCell.txtExpCompanyName.text = objworkingExpe.Company;
        
        [advocAchievementTableViewCell.btnUpdate addTarget:self action:@selector(btnUpdateData:) forControlEvents:UIControlEventTouchUpInside];


    }
}


#pragma mark - Api Methods

-(void)hitApiToPutAcheivementData{
    
    NSMutableDictionary* parameter = [NSMutableDictionary new];
    
    NSMutableDictionary* dictEdu = [NSMutableDictionary new];
    NSMutableDictionary* dictMem = [NSMutableDictionary new];
    NSMutableDictionary* dictExp = [NSMutableDictionary new];
    NSMutableArray* arrEdu = [NSMutableArray new];
    NSMutableArray* arrMem = [NSMutableArray new];
    NSMutableArray* arrExp = [NSMutableArray new];

    
    [dictEdu setObject:advocAchievementTableViewCell.txtEduDegreeName.text forKey:@"DegreeName"];
    [dictEdu setObject:advocAchievementTableViewCell.txtEduCollege.text forKey:@"College"];
    [dictEdu setObject:advocAchievementTableViewCell.txtEduToYear.text forKey:@"ToYear"];
    [dictEdu setObject:advocAchievementTableViewCell.txtEduFromYear.text forKey:@"FromYear"];
    [arrEdu addObject:dictEdu];
 
    [dictMem setObject:advocAchievementTableViewCell.txtMemMembershipPost.text forKey:@"MembershipDesignation"];
    [dictMem setObject:advocAchievementTableViewCell.txtMemDuration.text forKey:@"MembershipDuration"];
    [dictMem setObject:advocAchievementTableViewCell.txtMemCompanyName.text forKey:@"MembershipCompany"];
    [arrMem addObject:dictMem];

    [dictExp setObject:advocAchievementTableViewCell.txtExpDegree.text forKey:@"Designation"];
    [dictExp setObject:advocAchievementTableViewCell.txtExpDuration.text forKey:@"Duration"];
    [dictExp setObject:advocAchievementTableViewCell.txtExpCompanyName.text forKey:@"Company"];
    [arrExp addObject:dictExp];
    
    [parameter setObject:arrEdu forKey:@"objListEducation"];
    [parameter setObject:arrMem forKey:@"objListMembership"];
    [parameter setObject:arrExp forKey:@"objListWorkingEx"];
    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];

    if ([ CommonFunction reachability]) {
                [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_PUT_ACHEIVEMENT]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
                    [self removeloder];
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
-(void) getUpdatedData
{
    NSMutableArray* arrEdu = [NSMutableArray new];
    NSMutableArray* arrExp = [NSMutableArray new];
    NSMutableArray* arrMem = [NSMutableArray new];

    Education* edu = [Education new];
    WorkingExperience* workExp = [WorkingExperience new];
    Membership* mem = [Membership new];

    edu.DegreeName=advocAchievementTableViewCell.txtEduDegreeName.text;
    edu.College = advocAchievementTableViewCell.txtEduCollege.text;
    edu.ToYear =advocAchievementTableViewCell.txtEduToYear.text;
    edu.FromYear =advocAchievementTableViewCell.txtEduFromYear.text;
    [arrEdu addObject:edu];
    
    mem.MembershipDesignation=advocAchievementTableViewCell.txtMemMembershipPost.text;
    mem.MembershipDuration = advocAchievementTableViewCell.txtMemDuration.text;
    mem.MembershipCompany =advocAchievementTableViewCell.txtMemCompanyName.text;
    [arrMem addObject:mem];
   
    workExp.Designation=advocAchievementTableViewCell.txtExpDegree.text;
    workExp.Duration = advocAchievementTableViewCell.txtExpDuration.text;
    workExp.Company =advocAchievementTableViewCell.txtExpCompanyName.text;
    [arrExp addObject:workExp];
    
    [arr_global_advocate_WorkingExperience_data_updated replaceObjectAtIndex:0 withObject:workExp];
    [arr_global_advocate_Education_data_updated replaceObjectAtIndex:0 withObject:edu];
    [arr_global_advocate_Membership_data_updated replaceObjectAtIndex:0 withObject:mem];

}



@end

