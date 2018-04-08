//
//  ProfileVC.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/7/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC ()
{
    UIRefreshControl* refreshControl;
    NSMutableArray* arrData;
    LoderView *loderObj;
    UIImageView *imgViewToZoom;
    UITapGestureRecognizer *cameraGesture;
    PostModel* objUser ;
    
}
@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    refreshControl = [[UIRefreshControl alloc]init];
    [_tbl_View addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    cameraGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeImage)];
    [cameraGesture setNumberOfTapsRequired:1];
    
    [self hitApiForUserDetails];
    [self hitApiForAllPosts:@"0"];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}


-(void)setUpData{
    [CommonFunction setNavToController:self title:@"My Activity" isCrossBusston:false];
    [self setUpTableView];
    arrData = [[NSMutableArray alloc ] init];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backTapped{
    if (_isFromMyActivity) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
    
    
}


#pragma mark- tableView delegate
-(void)setUpTableView{
    [_tbl_View registerNib:[UINib nibWithNibName:@"FeedMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeedMainTableViewCell"];
    [_tbl_View registerNib:[UINib nibWithNibName:@"ProfileCell2" bundle:nil]forCellReuseIdentifier:@"ProfileCell2"];
    _tbl_View.rowHeight = UITableViewAutomaticDimension;
    _tbl_View.estimatedRowHeight = 100;
    _tbl_View.multipleTouchEnabled = NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData count]+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ProfileCell2 *cell = [_tbl_View dequeueReusableCellWithIdentifier:@"ProfileCell2"];
        if (cell == nil) {
            cell = [[ProfileCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProfileCell2"];
        }
        if (arrData.count>0) {
       
            cell.lblUserName.text = objUser.UserName;
            cell.lblSubtitle.text = objUser.Details;
            cell.lblCountFollowers.text = objUser.cntlike;
            cell.lblCountFollowing.text = objUser.cntcmt;
            [cell.imgView_Profile sd_setImageWithURL:[CommonFunction getProfilePicURLString:objUser.UserId] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];

        }
        return cell;
    }else{
        FeedMainTableViewCell *cell;
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FeedMainTableViewCell"];
        
        if (cell == nil) {
            cell = [[FeedMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedMainTableViewCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        PostModel* data = [PostModel new];
        data = [arrData objectAtIndex:indexPath.row-1];
        
        cell.lblUserName.text = data.UserName;
        cell.lblUserType.text = data.Details;
        cell.lblPostCreatedTime.text = data.Days;
        cell.lblPostNote.text = data.PostNote;
        
        
        [cell.imgViewProfilePic sd_setImageWithURL:[CommonFunction getProfilePicURLString:data.UserId] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
        
        if ([data.ArticleTitle  isEqual: @""]){
            cell.lblHeading.text = @"";
        }
        else
        {
            cell.lblHeading.text = data.ArticleTitle;
        }
        cell.lblPostNote.text = data.PostNote;
        cell.lblLikes.text = [NSString stringWithFormat:@"%@ likes", data.cntlike ];
        cell.lblComments.text = [NSString stringWithFormat:@"%@ comments",data.cntcmt];
        
        if ([data.Liked  isEqual: @"TRUE"]){
            [cell.btnLike setTitle:@"Liked" forState:UIControlStateNormal];
            cell.btnLike.titleLabel.textColor = [UIColor orangeColor];
            
        }
        else
        {
            [cell.btnLike setTitle:@"Like" forState:UIControlStateNormal];
            cell.btnLike.titleLabel.textColor = [UIColor grayColor];
            
        }
        if ([data.LibStatus  isEqual: @"1"]){
            [cell.btnSave setTitle:@"Saved" forState:UIControlStateNormal];
            cell.btnSave.titleLabel.textColor = [UIColor orangeColor];
            
        }
        else
        {
            [cell.btnSave setTitle:@"Save" forState:UIControlStateNormal];
            cell.btnSave.titleLabel.textColor = [UIColor grayColor];
            
        }
        
        cell.btnLike.tag = like_tag+indexPath.row-1;
        [cell.btnLike addTarget:self action:@selector(btnLikeTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnSave.tag = like_tag+indexPath.row-1;
        [cell.btnSave addTarget:self action:@selector(btnSaveTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnComment.tag = like_tag+indexPath.row-1;
        [cell.btnComment addTarget:self action:@selector(btnCommentTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnShare.tag = like_tag+indexPath.row-1;
        [cell.btnShare addTarget:self action:@selector(btnShareTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnImageToZoom.tag = like_tag+indexPath.row-1;
        [cell.btnImageToZoom addTarget:self action:@selector(imageZoomClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = cell.lblPostNote.lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName : cell.lblPostNote.font,
                                     NSParagraphStyleAttributeName : paragraph};
        CGSize constrainedSize = CGSizeMake(cell.lblPostNote.bounds.size.width, NSIntegerMax);
        CGRect rect = [cell.lblPostNote.text boundingRectWithSize:constrainedSize
                                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                       attributes:attributes context:nil];
        if (rect.size.height > cell.lblPostNote.bounds.size.height) {
            NSLog(@"TOO MUCH");
        }
        else
        {
            
        }
        
        
        if (![data.PostPic  isEqual: @""]){
            [cell.lblPostImage sd_setImageWithURL:[NSURL URLWithString:data.PostPic]];
            cell.cons_postImageHeight.constant = 160;
            
        }
        else
        {
            cell.cons_postImageHeight.constant = 0;
        }
        
        if (indexPath.row-1 == [arrData count] - 1)
        {
            [self hitApiForAllPosts:[NSString stringWithFormat:@"%d", indexPath.row-1]];
        }
        
        return cell;
        
    }
    
   ProfileCell2 *cell = [_tbl_View dequeueReusableCellWithIdentifier:@"ProfileCell2"];
    return cell;
}


#pragma mark - API related methods
-(void)hitApiForUserDetails{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    }
    else
    {
        [dictRequest setValue:@"0" forKey:@"UserId"];
    }
//    [dictRequest setValue:@"0" forKey:@"PostId"];
//    [dictRequest setValue:@"Feed" forKey:@"posttype"];
//    [dictRequest setValue:startPoint forKey:@"StrtPnt"];
//    [dictRequest setValue:[NSString stringWithFormat:@"%d",startPoint.integerValue+20] forKey:@"EndPnt"];
    
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self removeloder];
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,@"get_ConsultDetails"]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                        
                        objUser = dataObj;
                    }];
                    
                    [self removeloder];
                    [_tbl_View reloadData];
                    
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


-(void)hitApiForAllPosts:(NSString*) startPoint{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    }
    else
    {
        [dictRequest setValue:@"0" forKey:@"UserId"];
    }
    [dictRequest setValue:startPoint forKey:@"StrtPnt"];
    [dictRequest setValue:[NSString stringWithFormat:@"%d",startPoint.integerValue+20] forKey:@"EndPnt"];
    
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self removeloder];

        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_POSTS_FOR_USER]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    
                    [self removeloder];
                    [_tbl_View reloadData];
                    
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
