//
//  BaseHomeViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 07/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "BaseHomeViewController.h"
#import "SearchPostTableViewCell.h"

@interface BaseHomeViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    SWRevealViewController *revealController;
    BOOL isOpen;
    UIView *tempView;
    UITapGestureRecognizer *singleFingerTap;
    UISearchBar *searchBar;
    LoderView *loderObj;
    NSString* searchType;
    NSMutableArray *arrData;

}
@end

@implementation BaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrData = [NSMutableArray new];
    _searchBar.hidden = true;
    _tblView.hidden = true;
    
    _containerViewDashboard.hidden = true;
    _vi_activeDashboard.hidden = true;

    LegislateBaseViewController* vc = [[LegislateBaseViewController alloc] initWithNibName:@"LegislateBaseViewController" bundle:nil];
    
    [self addChildViewController:vc];                 // 1
    vc.view.frame = _containerView.bounds;
    [_containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
   
    DashboardBaseViewController* vc1 = [[DashboardBaseViewController alloc] initWithNibName:@"DashboardBaseViewController" bundle:nil];
    
    [self addChildViewController:vc1];                 // 1
    vc1.view.frame = _containerViewDashboard.bounds;
    [_containerViewDashboard addSubview:vc1.view];
    [vc1 didMoveToParentViewController:self];

    
    revealController = [self revealViewController];
    singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(handleSingleTap:)];

    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,70,320,44)];
    [searchBar setShowsScopeBar:YES];
    [searchBar setScopeButtonTitles:[[NSArray alloc] initWithObjects:@"OBJ",@"C", nil]];
    
    [_tblView registerNib:[UINib nibWithNibName:@"RearCell" bundle:nil]forCellReuseIdentifier:@"RearCell"];
    [_tblView registerNib:[UINib nibWithNibName:@"SearchPostTableViewCell" bundle:nil]forCellReuseIdentifier:@"SearchPostTableViewCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 30;
    _tblView.multipleTouchEnabled = NO;
    
    _tblView.delegate = self;
    _tblView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search bar delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText  isEqual: @""]) {
        searchBar.hidden = true;
        _tblView.hidden = true;
        [searchBar resignFirstResponder];
    }
    else
    {
        if ([searchType isEqualToString:@"0"]){
            if (searchText.length>2) {
                _tblView.hidden = false;
                _cont_bottomToSuperview.active = false;
                [self hitApiToSearchUsers:searchText];
                
                if (50*[arrData count]>[[UIScreen mainScreen]  bounds].size.height/2) {
                    _cons_tblHeight.constant = [[UIScreen mainScreen]  bounds].size.height/2 ;
                }
                else
                {
                    _cons_tblHeight.constant = 50*[arrData count];
                }
            }
            else
            {
                _tblView.hidden = true;
            }
        }
        else{
            if (searchText.length>3) {
                _tblView.hidden = false;
                _cont_bottomToSuperview.active = false;
                [self hitApiToSearchUsers:searchText];
                
                if (50*[arrData count]>[[UIScreen mainScreen]  bounds].size.height/2) {
                    _cons_tblHeight.constant = [[UIScreen mainScreen]  bounds].size.height/2 ;
                }
                else
                {
                    _cons_tblHeight.constant = 50*[arrData count];
                }
            }
            else
            {
                _tblView.hidden = true;
            }
        }
        
    }

}



-(void)hitApiToSearchUsers:(NSString*) username{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:username forKey:@"UserName"];
    [dictRequest setValue:searchType forKey:@"searchtype"];
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_SEARCH_USERS]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"_post"];
                    [arrData removeAllObjects];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        PostModel *dataObj = [PostModel new];
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
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
            }
            
        }];
    } else {
        [self removeloder];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
    }
}




#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([searchType isEqualToString:@"0" ]) {
        RearCell *rearCell = [_tblView dequeueReusableCellWithIdentifier:@"RearCell"];
        PostModel* post = [PostModel new];
        post = [arrData objectAtIndex:indexPath.row];
        rearCell.lbl_title.text = post.UserName;
        [rearCell.imgView sd_setImageWithURL:[CommonFunction getProfilePicURLString:post.UserId] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
        
        rearCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return rearCell;
    }
    else
    {
        SearchPostTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"SearchPostTableViewCell"];
        PostModel* post = [PostModel new];
        post = [arrData objectAtIndex:indexPath.row];
        cell.lblHeader.text = post.PostNote;
        cell.lblSubtitle.text = post.UserName;
        [cell.imgView sd_setImageWithURL:[CommonFunction getProfilePicURLString:post.UserId] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([searchType isEqualToString:@"0"]){
    }
    else
    {
        FeedDetailViewController* vc ;
        vc = [[FeedDetailViewController alloc] initWithNibName:@"FeedDetailViewController" bundle:nil];
        PostModel* data = [arrData objectAtIndex:indexPath.row];
        vc.postId = data.PostId;
        UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
        [self.navigationController presentViewController:navCon animated:true completion:nil];
        
    }
    
}

#pragma mark - Button Actions
//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    self.navigationController.navigationBar.userInteractionEnabled = true;
    if (isOpen){
        [revealController revealToggle:nil];
        [tempView removeGestureRecognizer:singleFingerTap];
        [tempView removeFromSuperview];
        isOpen = false;
    }
    
}

- (IBAction)revealAction:(id)sender {
    //    self.view.userInteractionEnabled = false;
    self.navigationController.navigationBar.userInteractionEnabled = true;
    
    
    if (isOpen) {
        
        [revealController revealToggle:nil];
        
        [tempView removeGestureRecognizer:singleFingerTap];
        [tempView removeFromSuperview];
        isOpen = false;
    }
    else{
        
        [revealController revealToggle:nil];
        tempView.frame  =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
        [tempView addGestureRecognizer:singleFingerTap];
        [self.view addSubview:tempView];
        isOpen = true;
    }
    
}

- (IBAction)btnLegislate:(id)sender {
    _containerViewDashboard.hidden = true;
    _containerView.hidden = false;
    _vi_activeDashboard.hidden = true;
    _vi_activeLegislate.hidden = false;
    _btnSearchContent.hidden = false;


}
- (IBAction)btnDashboard:(id)sender {
    _containerViewDashboard.hidden = false;
    _containerView.hidden = true;
    _vi_activeDashboard.hidden = false;
    _vi_activeLegislate.hidden = true;
    _btnSearchContent.hidden = true;

}


- (IBAction)btnSearchClciked:(id)sender {
    UIButton* btn = (UIButton*)sender;
    if (btn.tag == 1000){
        searchType = @"1";
    }
    else if (btn.tag == 1001)
    {
        searchType = @"0";
    }
    _searchBar.hidden = false;
    [_searchBar becomeFirstResponder];
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
