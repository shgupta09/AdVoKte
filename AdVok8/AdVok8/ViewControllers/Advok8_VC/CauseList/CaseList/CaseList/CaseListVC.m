//
//  CaseListVC.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/30/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CaseListVC.h"
#import "CaseListCell.h"
#import "CasePageVC.h"
#import "CaseList.h"

@interface CaseListVC (){
    NSMutableArray* arrData;
    NSMutableArray *tblArray;
    LoderView *loderObj;
}
@end

@implementation CaseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self hitApiToGetAllCaseList];

    // Do any additional setup after loading the view from its nib.
}

-(void)setUpData{
    arrData = [[NSMutableArray alloc ] init];
    tblArray = [NSMutableArray new];
    [self setUpTableView];
    [self hideConcelButton:true];
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- TectField

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length == 1 && [string isEqualToString:@""]) {
        [self hideConcelButton:true];
    }else{
        [self hideConcelButton:false];
    }
    return true;
}

#pragma mark- otherMethods
-(void)hideConcelButton:(BOOL)isHide{
    if (isHide) {
        _btn_CancelSearch.hidden = true;
        _traillinfConstraint.constant = 10;
    }else{
        _btn_CancelSearch.hidden = false;
        _traillinfConstraint.constant = 50;
    }
}

#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"CaseListCell" bundle:nil]forCellReuseIdentifier:@"CaseListCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tblArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CaseListCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"CaseListCell"];
    CaseList *dataObj  = [tblArray objectAtIndex:indexPath.row];

    if (cell == nil) {
        cell = [[CaseListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CaseListCell"];
    }
    cell.lbl1.text = dataObj.CourtName;
    cell.lbl2.text = [NSString stringWithFormat:@"%@ %d/%@",dataObj.CaseTypeName,dataObj.caseId,dataObj.caseyear];
    if ([dataObj.PetitionerName isEqualToString:@""]||[dataObj.rnm isEqualToString:@""]) {
        cell.lbl3.text = @"";
    }else{
        cell.lbl3.text = [NSString stringWithFormat:@"%@ Vs %@",dataObj.PetitionerName,dataObj.rnm];
    }
    
    cell.lbl4.text = [CommonFunction getValueFromDefaultWithKey:LOGINUSER];
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CasePageVC *caseOBJ = [[CasePageVC alloc]initWithNibName:@"CasePageVC" bundle:nil];
    caseOBJ.isFromDailyCauseList = false;
    [self.navigationController pushViewController:caseOBJ animated:true];
}

#pragma mark- Btn Actions

- (IBAction)btnAction_Cross:(id)sender {
    _txt_Search.text = @"";
}
#pragma mark - API related

-(void)hitApiToGetAllCaseList{
    
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    NSMutableDictionary* dictParameter = [NSMutableDictionary new];
    [dictParameter setValue:[CommonFunction getValueFromDefaultWithKey:LOGINUSER] forKey:@"advid"];
    [dict setValue:dictParameter forKey:@"objCase"];
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_CASELIST]  postResponse:dict postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    tempArray = [json objectForKey:@"CaseList"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        CaseList *dataObj = [CaseList new];
                        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                            @try {
                                [dataObj setValue:[CommonFunction checkForNull:obj] forKey:(NSString *)key];
                                
                            } @catch (NSException *exception) {
                                NSLog(exception.description);
                                //  Handle an exception thrown in the @try block
                            } @finally {
                                //  Code that gets executed whether or not an exception is thrown
                            }
                        }];
                        
                        [arrData addObject:dataObj];
                    }];
                    tblArray = arrData;

                    [_tblView reloadData];
                }else
                {
                    //                    [self addAlertWithTitle:AlertKey andMessage:[responseObj valueForKey:@"message"] isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
                    [self removeloder];
                    //                    [self removeloder];
                }
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
