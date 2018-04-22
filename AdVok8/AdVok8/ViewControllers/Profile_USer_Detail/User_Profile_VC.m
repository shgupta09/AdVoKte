//
//  User_Profile_VC.m
//  AdVok8
//
//  Created by shubham gupta on 4/14/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "User_Profile_VC.h"
#import "Edit_UserProfile_VC.h"
@interface User_Profile_VC (){
    NSMutableArray *headerDataArray;
    NSMutableArray *headerArray;
    NSMutableArray *tempArray;
    LoderView *loderObj;
    
    User* userObj;

}
@end

@implementation User_Profile_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    
    [self hitApiToGetData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Profile" isCrossBusston:false];
    [self setHeaderDataArray];
    [self setUpTableView];
}
-(void)setHeaderDataArray{
    headerArray = [[NSMutableArray alloc]initWithObjects:@"PERSONAL DETAIL",@"ADDRESS DETAIL", nil];
    headerDataArray = [NSMutableArray new];
    tempArray = [NSMutableArray new];
    tempArray = [[NSMutableArray alloc] initWithObjects:@"Name",@"Contact No",@"Alternate Contact No",@"Email ID",@"Gender",@"DOB", nil];
    [headerDataArray addObject:tempArray];
    tempArray = [[NSMutableArray alloc] initWithObjects:@"Address1",@"Address2",@"Street",@"Landmark",@"Locality",@"State",@"Country",@"Pin Code", nil];
    [headerDataArray addObject:tempArray];
    
}
#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"User_Profile_Cell" bundle:nil]forCellReuseIdentifier:@"User_Profile_Cell"];
    [_tblView registerNib:[UINib nibWithNibName:@"User_Header" bundle:nil] forHeaderFooterViewReuseIdentifier:kUser_HeaderReuseIdentifier];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 44;
    _tblView.multipleTouchEnabled = NO;
    _tblView.allowMultipleSectionsOpen = true;
    _tblView.keepOneSectionOpen = true;
    _tblView.initialOpenSections = [NSSet setWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1], nil];
    
    [CommonFunction setCornerRadius:_imgView Radius:50];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *temp =(NSMutableArray*)[headerDataArray objectAtIndex:section];
    return [temp count];
    //    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return headerArray.count;
    //    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kDefaulAUser_HeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User_Profile_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"User_Profile_Cell" forIndexPath:indexPath];
    cell.lbl_Title.text = [[headerDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.lbl_Data.text = userObj.FirstName;
            }
                break;
            case 1:
            {
                cell.lbl_Data.text = userObj.ContactNo;
            }
                break;
            case 2:
            {
                cell.lbl_Data.text = userObj.AlternateContactNo;
            }
                break;
            case 3:
            {
                cell.lbl_Data.text = userObj.EmailId;
            }
                break;
            case 4:
            {
                cell.lbl_Data.text = userObj.Gender;
            }
                break;
            case 5:
            {
                cell.lbl_Data.text = userObj.DOB;
                
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                cell.lbl_Data.text = userObj.AddLine1;
            }
                break;
            case 1:
            {
                cell.lbl_Data.text = userObj.AddLine2;
            }
                break;
            case 2:
            {
                cell.lbl_Data.text = userObj.Street;
            }
                break;
            case 3:
            {
                cell.lbl_Data.text = userObj.Landmark;
            }
                break;
            case 4:
            {
                cell.lbl_Data.text = userObj.Street;
            }
                break;
            case 5:
            {
                cell.lbl_Data.text = userObj.State;
                
            }
                break;
            case 6:
            {
                cell.lbl_Data.text = userObj.Country;
                
            }
                break;
            case 7:
            {
                cell.lbl_Data.text = userObj.Pincode;
                
            }
                break;

            default:
                break;
        }
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    User_Header *accordiamViewObj = (User_Header *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kUser_HeaderReuseIdentifier];
    accordiamViewObj.lbl_headerTitle.text = [headerArray objectAtIndex:section];
    accordiamViewObj.backgroundColor = [UIColor lightGrayColor];
    return accordiamViewObj;
}

- (void) handleGesture:(UIGestureRecognizer *)gestureRecognizer;{
    
}


#pragma mark - btn Action

- (IBAction)btnAction_Edit:(id)sender {
    Edit_UserProfile_VC *profileObj = [[Edit_UserProfile_VC alloc]initWithNibName:@"Edit_UserProfile_VC" bundle:nil];
    profileObj.userObj = userObj;
    [self.navigationController pushViewController:profileObj animated:true];
}



#pragma mark - API related

-(void)hitApiToGetData{
    
    
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    NSMutableDictionary* parameter = [[NSMutableDictionary alloc ] init];
    [parameter setObject:dictRequest forKey:@"objUser"];
    
    if ([ CommonFunction reachability]) {
        //        [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_USER_DETAILS]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"user"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        User *dataObj = [User new];
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
                        
                        userObj = dataObj;
                        
                        
                    }];
                    [_tblView reloadData];
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
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
            }
        }];
    } else {
        [self removeloder];
        
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
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

@end
