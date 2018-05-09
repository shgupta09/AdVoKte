//
//  CasePageVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//
//172
//146
#import "CasePageVC.h"
#import "FZAccordionTableView.h"
#import "CaseListCell2.h"
#import "DateCaell.h"
@interface CasePageVC (){
    NSMutableArray *headerDataArray;
    NSMutableArray *headerArray;
    NSMutableArray *tempArray;
    LoderView *loderObj;

}
@end
static NSString *const kTableViewCellReuseIdentifier = @"CaseListCell2";

@implementation CasePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpData{
    
    if (_isFromDailyCauseList) {
        _topConstraint.constant = 190;
        _view_DailyCause.hidden = false;
        _view_Case.hidden = true;
        
        _lbl2.text = [NSString stringWithFormat:@"%@ %d/%d",_causeListObj.CaseType,_causeListObj.CaseNo,_causeListObj.CaseYear];
        _lbl1.text = _causeListObj.CourtName;
        _lbl3.text = [NSString stringWithFormat:@"%@ vs %@",_causeListObj.PetitionerName,_causeListObj.RespondentName];
        _lbl4.text = _causeListObj.BenchName;
        _lbl5.text = [NSString stringWithFormat:@"Court: %d   Item: %@",_causeListObj.CourtNo,_causeListObj.CaseSeqNo];
        
        [CommonFunction setShadowOpacity:_view_DailyCause];
        [CommonFunction setCornerRadius:_view_DailyCause Radius:5];
    }else{
        _view_DailyCause.hidden = true;
        _view_Case.hidden = false;
        _topConstraint.constant = 166;
        
        
        _lblC1.text = _dataObj.CourtName;
        _lblC2.text = [NSString stringWithFormat:@"%@ %d/%@",_dataObj.CaseTypeName,_dataObj.caseId,_dataObj.caseyear];
        if ([_dataObj.PetitionerName isKindOfClass:[NSNull class]] || [_dataObj.PetitionerName isEqualToString:@""] || [_dataObj.rnm isKindOfClass:[NSNull class]] ||[_dataObj.rnm isEqualToString:@""]) {
            _lblC3.text = @"";
        }else{
            _lblC3.text = [NSString stringWithFormat:@"%@ Vs %@",_dataObj.PetitionerName,_dataObj.rnm];
        }
        
        _lblC4.text = [NSString stringWithFormat:@"%@ Vs %@",[CommonFunction getValueFromDefaultWithKey:@"DisplayName"],_dataObj.radvnm];
        [CommonFunction setShadowOpacity:_view_Case];
        [CommonFunction setCornerRadius:_view_Case Radius:5];
        [self hitApiToGetAllCaseList];
    }
    [CommonFunction setNavToController:self title:@"Case Page" isCrossBusston:false];
    [self setHeaderDataArray];
    [self setUpTableView];

}

-(void)setHeaderDataArray{
    headerArray = [[NSMutableArray alloc]initWithObjects:@"Next Date:",@"Order",@"Listing", nil];
    headerDataArray = [NSMutableArray new];
    tempArray = [NSMutableArray new];
    [headerDataArray addObject:tempArray];
    tempArray = [[NSMutableArray alloc] initWithObjects:@"Politics",@"What's Hot",@"SA Business", nil];
    [headerDataArray addObject:tempArray];
    tempArray = [[NSMutableArray alloc] initWithObjects:@"Politics",@"What's Hot",@"SA Business", nil];
    [headerDataArray addObject:tempArray];
    
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"CaseListCell2" bundle:nil]forCellReuseIdentifier:@"CaseListCell2"];
    [_tblView registerNib:[UINib nibWithNibName:@"DateCaell" bundle:nil]forCellReuseIdentifier:@"DateCaell"];
    [_tblView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
    _tblView.allowMultipleSectionsOpen = false;
    _tblView.keepOneSectionOpen = false;
    _tblView.initialOpenSections = [NSSet setWithObjects:[NSNumber numberWithInt:0], nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSMutableArray*)[headerDataArray objectAtIndex:section] count];
//    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return headerArray.count;
//    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kDefaultAccordionHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        CaseListCell2 *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 1){
        DateCaell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCaell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        CaseListCell2 *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
//    cell.lbl_text.text = [[headerDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
       CaseListCell2 *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AccordionHeaderView *accordiamViewObj = (AccordionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    [CommonFunction setCornerRadius:accordiamViewObj.view Radius:5];
    accordiamViewObj.lbl_headerTitle.text = [[headerArray objectAtIndex:section] capitalizedString];

    return accordiamViewObj;
}

- (void) handleGesture:(UIGestureRecognizer *)gestureRecognizer;{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [revealController revealToggle:nil];
//
//    ArticleVC *articalVC =[[ArticleVC alloc]initWithNibName:@"ArticleVC" bundle:nil];
//    articalVC.categoryName = [[CommonFunction getNameFromString:[[headerDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]] capitalizedString];
//    articalVC.categoryId = [[CommonFunction getIDFromString:[[headerDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]] capitalizedString];
//
//    //webVC.urlPart = [[headerDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:articalVC animated:true];
}

#pragma mark - <FZAccordionTableViewDelegate> -

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
//    ArticleVC *articalVC;
//    if (section!=1) {
//        [revealController revealToggle:nil];
//        articalVC =[[ArticleVC alloc]initWithNibName:@"ArticleVC" bundle:nil];
//        articalVC.categoryName = [[[CommonFunction getNameFromString:[headerArray objectAtIndex:section]] uppercaseString] capitalizedString];
//        articalVC.categoryId = [[[CommonFunction getIDFromString:[headerArray objectAtIndex:section]] uppercaseString] capitalizedString];
//        [self.navigationController pushViewController:articalVC animated:true];
//    }
    //    webVC.urlPart = [headerArray objectAtIndex:section];
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

#pragma mark - API related

-(void)hitApiToGetAllCaseList{
    
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:[CommonFunction getValueFromDefaultWithKey:LOGINUSER] forKey:@"UserName"];
    [dict setValue:[NSString stringWithFormat:@"%@",_dataObj.mycaseId] forKey:@"CaseId"];
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_CauseListWithCase]  postResponse:dict postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"IsError"];
                int status = [st intValue];
                if ( status == 0) {
//                    NSDictionary *tempArray = [NSDictionary new];
//                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
//                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                    tempArray = [json objectForKey:@"Data"];
//                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                        CaseList *dataObj = [CaseList new];
//                        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
//                            @try {
//                                [dataObj setValue:[CommonFunction checkForNull:obj] forKey:(NSString *)key];
//
//                            } @catch (NSException *exception) {
//                                NSLog(exception.description);
//                                //  Handle an exception thrown in the @try block
//                            } @finally {
//                                //  Code that gets executed whether or not an exception is thrown
//                            }
//                        }];
//
////                        [arrData addObject:dataObj];
//                    }];
////                    tblArray = arrData;

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
