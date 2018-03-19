//
//  LawyerListVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LawyerListVC.h"
#import "ListCell.h"
#import "SelectedLawyerVC.h"
@interface LawyerListVC ()
{
    
    NSMutableArray* arrData;
    LoderView *loderObj;
    
}
@end

@implementation LawyerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"Ldasd" isCrossBusston:false];
    arrData = [NSMutableArray new];

    [_tblView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil]forCellReuseIdentifier:@"ListCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
    
    [self hitApiToGetAllAdvocates];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

#pragma mark- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"ListCell"];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ListCell"];
    }
    ADRegistrationModel* obj = [ADRegistrationModel new];
    obj = [arrData objectAtIndex:indexPath.row];
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@",obj.fname,obj.lname];
    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.view.layer.shadowOffset = CGSizeMake( 0, 0);
    cell.view.layer.shadowOpacity = 0.4;
    cell.view.layer.shadowRadius = 4.0;
    [cell.lblEducation setText:[CommonFunction checkEmptyString:obj.Education]];
    [cell.lblExperience setText:[CommonFunction checkEmptyString:[NSString stringWithFormat:@"%@ Experience",obj.Experience]]];
    [cell.lblSepcialization setText:[CommonFunction checkEmptyString:[NSString stringWithFormat:@"spcialisation: %@",obj.AOP]]];
    [cell.lblSepcialization boldSubstring:@"spcialisation:"];
    [cell.lblLocation setText:[CommonFunction checkEmptyString:obj.City]];
    if ([obj.ConsultancyFees  isEqual: @"0.00"]){
        [cell.lblCost setText:@"Free"];
    }
    else
    {
        [cell.lblCost setText:[NSString stringWithFormat:@"INR %@",obj.ConsultancyFees]];
    }
//    [cell.img_Profile sd_setImageWithURL:[NSURL URLWithString:obj.profPic]];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.view.bounds];
//    cell.view.layer.masksToBounds = NO;
//    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;
//    cell.view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//    cell.view.layer.shadowOpacity = 0.5f;
//    cell.view.layer.shadowPath = shadowPath.CGPath; UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectedLawyerVC *lawyerVcOBJ = [[SelectedLawyerVC alloc]initWithNibName:@"SelectedLawyerVC" bundle:nil];
    lawyerVcOBJ.obj =[arrData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:lawyerVcOBJ animated:true];
}



#pragma mark - API related

-(void)hitApiToGetAllAdvocates{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    
    [dictRequest setValue:@"" forKey:@"Court"];
    [dictRequest setValue:@"" forKey:@"Days"];
    [dictRequest setValue:@"" forKey:@"EndTime"];
    [dictRequest setValue:@"" forKey:@"Location"];
    [dictRequest setValue:@"" forKey:@"Name"];
    [dictRequest setValue:_Specialization forKey:@"Specialization"];
    [dictRequest setValue:@"" forKey:@"StartTime"];
    [dictRequest setValue:@"" forKey:@"UserRating"];

    
    [parameter setValue:dictRequest forKey:@"_sp"];

    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_ADVOCATES_FOR]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    tempArray = [json objectForKey:@"_adr"];
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
                        
                        [arrData addObject:dataObj];
                    }];
                    [_tblView reloadData];
                }else
                {
                    //                    [self addAlertWithTitle:AlertKey andMessage:[responseObj valueForKey:@"message"] isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
                    [self removeloder];
                    //                    [self removeloder];
                }
                [self removeloder];
                
            }
            
            
            
        }];
    } else {
        [self removeloder];
        //        [self addAlertWithTitle:AlertKey andMessage:Network_Issue_Message isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
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
