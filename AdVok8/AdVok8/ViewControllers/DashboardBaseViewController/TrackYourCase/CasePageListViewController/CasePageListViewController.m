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
@interface CasePageListViewController (){
     NSMutableArray* arrData;
        LoderView *loderObj;

}

@end

@implementation CasePageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUpData];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpData{
    arrData = [[NSMutableArray alloc ] init];
    [CommonFunction setNavToController:self title:@"Cause List" isCrossBusston:false];
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
        cell = [[CasePageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CasePageCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    TaskDetailVC *createTaskObj = [[TaskDetailVC alloc]initWithNibName:@"TaskDetailVC" bundle:nil];
    //    [self.navigationController pushViewController:createTaskObj animated:true];
}
#pragma mark - API related

-(void)hitApiToGetCases{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    
    [parameter setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"userId"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_TO_GET_CASES]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    tempArray = [json objectForKey:@"Data"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        AppealAlert *dataObj = [AppealAlert new];
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
            else
            {
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
