//
//  CasePageListViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 06/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CasePageListViewController.h"
#import "CasePageCell.h"
#import "AppealAlert.h"
#import "DailyCauseListCell.h"
#import "CasePageVC.h"
@interface CasePageListViewController (){
     NSMutableArray* arrData;
        LoderView *loderObj;

}

@end

@implementation CasePageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUpData];
    [self hitApiToGetCases];
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpData{
    arrData = [[NSMutableArray alloc ] init];
    [CommonFunction setNavToController:self title:@"Case Page" isCrossBusston:false];
    [self setUpTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}
-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}

- (IBAction)btnAddClicked:(id)sender {
    AddNewCaseViewController* vc = [[AddNewCaseViewController alloc] initWithNibName:@"AddNewCaseViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}
#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"CasePageCell" bundle:nil]forCellReuseIdentifier:@"CasePageCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([arrData count]>0) {
        _lbl_NoData.hidden = true;
    }else{
        _lbl_NoData.hidden = false;
    }
    return [arrData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CasePageCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"CasePageCell"];
    
    if (cell == nil) {
        cell = [[CasePageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DailyCauseListCell"];
    }
    
    CaseList *tempObj = [arrData objectAtIndex:indexPath.row];
    cell.lbl_detail2.text = [NSString stringWithFormat:@"%@ %@/%@",tempObj.casetype,tempObj.caseId,tempObj.caseyear];
    cell.lbl_detail1.text = tempObj.CourtName;
    cell.lbl_detail3.text = [NSString stringWithFormat:@"%@, %@",tempObj.PetitionerName,tempObj.RespondantName];
    
    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CasePageVC *caseOBJ = [[CasePageVC alloc]initWithNibName:@"CasePageVC" bundle:nil];
    caseOBJ.isFromDailyCauseList = false;
    caseOBJ.dataObj = [arrData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:caseOBJ animated:true];
}

#pragma mark - API related

-(void)hitApiToGetCases{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"Username"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ADVOCATE_CALENDAR]  postResponse:dict postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                arrData = [NSMutableArray new];
                NSArray *tempArray = [NSArray new];
                tempArray = [json objectForKey:@"caseList"];
                [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    CaseList *dataObj = [CaseList new];
                    [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj1, BOOL *stop){
                        @try {
                            [dataObj setValue:obj1 forKey:(NSString *)key];
                            
                        } @catch (NSException *exception) {
                            NSLog(exception.description);
                            //  Handle an exception thrown in the @try block
                        } @finally {
                            //  Code that gets executed whether or not an exception is thrown
                        }
                    }];
                    
                    [arrData addObject:dataObj];
                }];
                 [self removeloder];
                [_tblView reloadData];
                
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
#pragma mark- Loder
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
