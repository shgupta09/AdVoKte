//
//  DBVC.m
//  AdVok8
//
//  Created by shubham gupta on 8/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "DBVC.h"
#import "CourtDetails.h"
#import "CourtBaseDetail.h"
#import "FZAccordionTableView.h"
#import "DetailCell.h"
#import "AccordionHeaderView.h"

@interface DBVC (){
    LoderView *loderObj;
    NSMutableArray* arrData;
    
    
}

@end
static NSString *const kTableViewCellReuseIdentifier = @"DetailCell";

@implementation DBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpData{
        [CommonFunction setNavToController:self title:@"Display Board" isCrossBusston:false];
        arrData = [[NSMutableArray alloc ] init];
    [self hitApiToGetDta];
    
}

-(void)backTapped{
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}
#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil]forCellReuseIdentifier:@"DetailCell"];

    [_tblView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
//      [_tblView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil]
//forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
    _tblView.allowMultipleSectionsOpen = false;
    
    _tblView.keepOneSectionOpen = false;
    _tblView.initialOpenSections = [NSSet setWithObjects:[NSNumber numberWithInt:0], nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((CourtDetails *)[arrData objectAtIndex:section]).listArray.count;

    //    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrData.count;
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
    
    if (indexPath.section !=0){
        
            NSMutableArray* obj = (NSMutableArray*)[arrData objectAtIndex:indexPath.section-1];
            CauseListModel* caseObj = [obj objectAtIndex:indexPath.row];
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
//            cell.lblTitle.text = @"Cause List:";
//            cell.lblSubtitle.text = caseObj.HearingDate;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
       
    }
    else
    {
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AccordionHeaderView *accordiamViewObj = (AccordionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    [CommonFunction setCornerRadius:accordiamViewObj.view Radius:5];
    if (section == 0){
       
            accordiamViewObj.lbl_headerTitle.text = @"qwerty";
        
        
    }
    else
    {
        accordiamViewObj.lbl_headerTitle.text =  @"awef";
    }
    
    return accordiamViewObj;
}

- (void) handleGesture:(UIGestureRecognizer *)gestureRecognizer;{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section !=0){
//        if ([[headerArray objectAtIndex:indexPath.section-1] isEqualToString:@"Order"])
//        {
//            NSMutableArray* obj = (NSMutableArray*)[arrData objectAtIndex:indexPath.section-1];
//            DocumentModel* caseObj = [obj objectAtIndex:indexPath.row];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:caseObj.AttachmentPath]];
//
//        }
    }
}

#pragma mark - <FZAccordionTableViewDelegate> -

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
    
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}
#pragma mark - API related

-(void)hitApiToGetDta{
    
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_DISPLAYLIST]  postResponse:dict postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
               
                if ( 1) {
                    arrData = [[NSMutableArray alloc ] init];
                    
                    NSArray *tempArray = [NSArray new];
                    tempArray = [json objectForKey:@"data"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        CourtDetails *dataObj = [CourtDetails new];
                            dataObj.courtName = [obj valueForKey:@"CourtName"];
                            
                            NSArray *arr = [obj valueForKey:@"CourtItemDetail"];
                        NSMutableArray *tempDataArrayForCourtList = [NSMutableArray new];

                            
                            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                CourtBaseDetail *basicDetail = [CourtBaseDetail new];
                                [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key2, id  _Nonnull obj2, BOOL * _Nonnull stop) {
                                    @try {
                                        
                                        
                                        [basicDetail setValue:obj2 forKey:(NSString *)key2];
                                        
                                    } @catch (NSException *exception) {
                                        NSLog(exception.description);
                                        //  Handle an exception thrown in the @try block
                                    } @finally {
                                        //  Code that gets executed whether or not an exception is thrown
                                    }
                                    [tempDataArrayForCourtList addObject:basicDetail];
                                }];
                                
                            }];
                       
                        dataObj.listArray = tempDataArrayForCourtList;
                        [arrData addObject:dataObj];
                        }];
                        
                 
                    [_tblView reloadData];
                    [self removeloder];
                    
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
