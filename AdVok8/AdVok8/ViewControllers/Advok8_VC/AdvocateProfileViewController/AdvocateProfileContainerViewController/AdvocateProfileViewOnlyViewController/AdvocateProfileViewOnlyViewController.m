//
//  AdvocateProfileViewOnlyViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 05/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateProfileViewOnlyViewController.h"
#import "ProfileCell.h"
#import "LabelCell.h"

@interface AdvocateProfileViewOnlyViewController ()
{
    LoderView *loderObj;
    AdvocatePublicData *adPublicData;
}
@end

@implementation AdvocateProfileViewOnlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonFunction setNavToController:self title:@"Lawyer" isCrossBusston:false];
    [_tblView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil]forCellReuseIdentifier:@"ProfileCell"];
    [_tblView registerNib:[UINib nibWithNibName:@"LabelCell" bundle:nil]forCellReuseIdentifier:@"LabelCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
    

    [self hitApiToGetAdvocateData];
    // Do any additional setup after loading the view from its nib.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (adPublicData){
        return 9;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ADRegistrationModel *tempObj =[adPublicData.AdvocateDetails objectAtIndex:0];
    if (indexPath.row == 0) {
        ProfileCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"ProfileCell"];
        if (cell == nil) {
            cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProfileCell"];
        }
        cell.lblName.text =  [NSString stringWithFormat:@"%@ %@",tempObj.fname,tempObj.lname];
        cell.lblSepcialization.text = [CommonFunction checkEmptyString:[NSString stringWithFormat:@"%@",tempObj.AOP]];
        [cell.img_Profile sd_setImageWithURL:[CommonFunction getProfilePicURLString:tempObj.username] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
        return cell;
    }else{
        LabelCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"LabelCell"];
        if (cell == nil) {
            cell = [[LabelCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LabelCell"];
        }
        cell.lbl_first.hidden = false;
        cell.separatorView1.hidden = false;
        cell.lbl_Second.hidden = true;
        cell.separatorView2.hidden = true;
        cell.lbl_Third.hidden = true;
        cell.separatorView3.hidden = true;
        cell.imgViewFirst.hidden = false;
        cell.imgViewSecond.hidden = true;
        
        
        switch (indexPath.row) {
            case 1:{
                if (![tempObj.Experience isKindOfClass:[NSNull class]]){
                    [cell.lbl_first setText:tempObj.Experience];
                }
                UIImage *image = [UIImage imageNamed:@"tempEnxperience.png"];
                cell.imgViewFirst.image = image;
                cell.imgViewFirst.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
            }
                break;
            case 2:{
                cell.lbl_first.hidden = true;
                cell.separatorView1.hidden = true;
                cell.lbl_Second.hidden = false;
                cell.separatorView2.hidden = false;
                cell.lbl_Third.hidden = false;
                cell.separatorView3.hidden = false;
                cell.imgViewSecond.hidden = false;
                [cell.lbl_Second setText:tempObj.BarCodeId];
                if ([tempObj.ConsultancyFees  isEqual: @"0.00"]){
                    [cell.lbl_Third setText:@"Free"];
                }
                else
                {
                    [cell.lbl_Third setText:[NSString stringWithFormat:@"INR %@",tempObj.ConsultancyFees]];
                }
                UIImage *image1 = [UIImage imageNamed:@"tempFees.png"];
                cell.imgViewFirst.image = image1;
                cell.imgViewFirst.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
                UIImage *image2 = [UIImage imageNamed:@"tempFees.png"];
                cell.imgViewSecond.image = image2;
                cell.imgViewSecond.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
            }
                break;
            case 3:{
                [cell.lbl_first setText:[NSString stringWithFormat:@"Appointment Day\n%@",[CommonFunction checkEmptyString:tempObj.Dsc]]];
                UIImage *image1 = [UIImage imageNamed:@"tempApptDay.png"];
                cell.imgViewFirst.image = image1;
                cell.imgViewFirst.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
                
            }
                break;
            case 4:{
                if (![tempObj.DayTime isKindOfClass:[NSNull class]]){
                    [cell.lbl_first setText:[CommonFunction checkEmptyString:[[tempObj.DayTime componentsSeparatedByString:@"#"] objectAtIndex:0]]];
                    UIImage *image1 = [UIImage imageNamed:@"tempApptDay.png"];
                    cell.imgViewFirst.image = image1;
                    cell.imgViewFirst.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
                }
                
            }
                break;
            case 5:{
                [cell.lbl_first setText:[CommonFunction checkEmptyString:tempObj.Education]];
                UIImage *image1 = [UIImage imageNamed:@"tempProfile.png"];
                cell.imgViewFirst.image = image1;
                cell.imgViewFirst.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
            }
                break;
            case 6:{
                [cell.lbl_first setText:[CommonFunction checkEmptyString:tempObj.OffAddline]];
                UIImage *image1 = [UIImage imageNamed:@"tempHome.png"];
                cell.imgViewFirst.image = image1;
                cell.imgViewFirst.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
            }
                break;
            case 7:{
                
                if (![tempObj.SecAOP isKindOfClass:[NSNull class]]){
                    NSString *str = [CommonFunction checkEmptyString:tempObj.SecAOP];
                    NSMutableString *tempString = [NSMutableString stringWithFormat:@"Services:\n"];
                    if (![str isEqualToString:@"N/A"]) {
                        NSArray *tempArray = [str componentsSeparatedByString:@","];
                        [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [tempString appendFormat:@"%@ %@\n",Bullet,[NSString stringWithFormat:@"%@",obj]];
                        }];
                        [cell.lbl_first setText:tempString];
                    }else{
                        [cell.lbl_first setText:[NSString stringWithFormat:@"Services:\n %@",[CommonFunction checkEmptyString:tempObj.SecAOP]]];
                    }
                    
                    UIImage *image1 = [UIImage imageNamed:@"tempServices.png"];
                    cell.imgViewFirst.image = image1;
                }
                
                
            }
                break;
            case 8:{
                [cell.lbl_first setText:[NSString stringWithFormat:@"FEEDBACK\n%@",[CommonFunction checkEmptyString:@""]]];
                UIImage *image1 = [UIImage imageNamed:@"tempServices.png"];
                cell.imgViewFirst.image = image1;
                cell.imgViewFirst.tintColor = [CommonFunction colorWithHexString:Primary_Blue];
                cell.separatorView1.hidden = true;
            }
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    
    ProfileCell *cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProfileCell"];
    return cell;
}


#pragma mark - API related

-(void)hitApiToGetAdvocateData{
    
    Rating *ratingObj = [Rating new];
    
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];

    if ([ CommonFunction reachability]) {
        //        [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_ADVOCATE_PUBLICDATA]  postResponse:dictRequest postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    adPublicData = [AdvocatePublicData new];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    //Details Data
                    tempArray = [json objectForKey:@"AdvocateDetails"];
                    NSMutableArray *tempdataArray = [NSMutableArray new];
                    
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        ADRegistrationModel *dataObj = [ADRegistrationModel new];
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
                        
                        [tempdataArray addObject:dataObj];
                    }];
                    adPublicData.AdvocateDetails = tempdataArray;
                    
                    //Time Data
                    tempArray = [json objectForKey:@"AdvocateTime"];
                    tempdataArray = [NSMutableArray new];
                    
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        ADRegistrationModel *dataObj = [ADRegistrationModel new];
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
                        
                        [tempdataArray addObject:dataObj];
                    }];
                    adPublicData.AdvocateTime = tempdataArray;
                    
                    
                    //Education Data
                    tempArray = [json objectForKey:@"Education"];
                    tempdataArray = [NSMutableArray new];
                    
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Education *dataObj = [Education new];
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
                        
                        [tempdataArray addObject:dataObj];
                    }];
                    adPublicData.Education = tempdataArray;
                    
                    //Membership Data
                    tempArray = [json objectForKey:@"Membership"];
                    tempdataArray = [NSMutableArray new];
                    
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Membership *dataObj = [Membership new];
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
                        
                        [tempdataArray addObject:dataObj];
                    }];
                    adPublicData.Membership = tempdataArray;
                    //Rating Data
                    tempArray = [json objectForKey:@"Rating"];
                    tempdataArray = [NSMutableArray new];
                    
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Rating *dataObj = [Rating new];
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
                        
                        [tempdataArray addObject:dataObj];
                    }];
                    adPublicData.Rating = tempdataArray;
                    
                    //Rating Data
                    tempArray = [json objectForKey:@"WorkingExperience"];
                    tempdataArray = [NSMutableArray new];
                    
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        WorkingExperience *dataObj = [WorkingExperience new];
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
                        
                        [tempdataArray addObject:dataObj];
                    }];
                    adPublicData.WorkingExperience = tempdataArray;
                    adPublicData.Status =[json objectForKey:@"Status"];
                    adPublicData.Errormsg =[json objectForKey:@"Errormsg"];
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
#pragma mark- Btn Actions

- (IBAction)btnEditClicked:(id)sender {
    AdvocateProfileContainerViewController *vc = [[UIStoryboard storyboardWithName:@"AdvocateProfileStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"AdvocateProfileContainerViewController"];
    
    [self.navigationController pushViewController:vc animated:true];

}

@end

