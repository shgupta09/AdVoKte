//
//  FeedDetailViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "FeedDetailViewController.h"

@interface FeedDetailViewController ()
{
    NSMutableArray* arrData;
    PostModel* postDetails;
    LoderView *loderObj;
}

@end

@implementation FeedDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [_tblView registerNib:[UINib nibWithNibName:@"FeedMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeedMainTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];

    [self hitApiForPostDetail];

    self.navigationController.navigationBar.hidden = false;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [CommonFunction colorWithHexString:@"28328C"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross-1"] style: UIBarButtonItemStyleBordered target:self action:@selector(backTapped)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.navigationController setTitle:@"Feed Detail"];
    
    [_tblView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil]forCellReuseIdentifier:@"CommentTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];
    
    [self hitApiToGetGetCommentsForPost];
    

    // Do any additional setup after loading the view from its nib.
}


-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Button Actions
- (void)backTapped {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

#pragma mark- Table Delegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count+1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        FeedMainTableViewCell *cell;
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FeedMainTableViewCell"];
        
        if (cell == nil) {
            cell = [[FeedMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedMainTableViewCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        PostModel* data = [PostModel new];
        data = postDetails;
        
        cell.lblUserName.text = data.UserName;
        cell.lblUserType.text = data.Details;
        cell.lblPostCreatedTime.text = data.Days;
        cell.lblPostNote.text = data.PostNote;
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
            [_btnLike setTitle:@"Liked" forState:UIControlStateNormal];
            _btnLike.titleLabel.textColor = [UIColor orangeColor];
            
        }
        else
        {
            [_btnLike setTitle:@"Like" forState:UIControlStateNormal];
            _btnLike.titleLabel.textColor = [UIColor grayColor];
            
        }
        if ([data.LibStatus  isEqual: @"1"]){
            [_btnSave setTitle:@"Saved" forState:UIControlStateNormal];
            _btnSave.titleLabel.textColor = [UIColor orangeColor];
            
        }
        else
        {
            [_btnSave setTitle:@"Save" forState:UIControlStateNormal];
            _btnSave.titleLabel.textColor = [UIColor grayColor];
            
        }
        
        
        
        if (![data.PostPic  isEqual: @""]){
            [cell.lblPostImage sd_setImageWithURL:[NSURL URLWithString:data.PostPic]];
            cell.cons_postImageHeight.constant = 160;
            
        }
        else
        {
            cell.cons_postImageHeight.constant = 0;
        }
        
        cell.lblPostNote.numberOfLines = 0;
        cell.stackView.hidden = true;
        
        return cell;
    }
 else
 {
     CommentTableViewCell *cell;
     
     cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
     
     if (cell == nil) {
         cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentTableViewCell"];
     }
     
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
     PostModel* data = [PostModel new];
     data = [arrData objectAtIndex:indexPath.row-1];
     
     cell.lblTimeAgo.text = [NSString stringWithFormat:@"%@ ago",data.Days];
     cell.lblComment.text = data.PostNote;
     cell.lblCountLikes.text = [NSString stringWithFormat:@"%lu",(unsigned long)data._cmtlikes.count];
     
     if ([data.Liked  isEqual: @"TRUE"]){
         [cell.btnLike setTitle:@"Liked" forState:UIControlStateNormal];
         cell.btnLike.titleLabel.textColor = [UIColor orangeColor];
         
     }
     else
     {
         [cell.btnLike setTitle:@"Like" forState:UIControlStateNormal];
         cell.btnLike.titleLabel.textColor = [UIColor grayColor];
         
     }
     
     NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
     paragraph.lineBreakMode = cell.lblComment.lineBreakMode;
     NSDictionary *attributes = @{NSFontAttributeName : cell.lblComment.font,
                                  NSParagraphStyleAttributeName : paragraph};
     CGSize constrainedSize = CGSizeMake(cell.lblComment.bounds.size.width, NSIntegerMax);
     CGRect rect = [cell.lblComment.text boundingRectWithSize:constrainedSize
                                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                   attributes:attributes context:nil];
     if (rect.size.height > cell.lblComment.bounds.size.height) {
         NSLog(@"TOO MUCH");
     }
     else
     {
         
     }
     
     return cell;
 }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark - Cell button actions
-(IBAction)btnLikeTapped:(id) sender {
    
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [self hitApiToLikeAPostWithPostId:_postId andIndex: index];
        
    }
    else
    {
        LoginViewController* vc ;
        vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        vc.Behaviour = @"Action";
        UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
        [self.navigationController presentViewController:navCon animated:true completion:nil];
        
    }
    
}
-(IBAction) btnSaveTapped:(id) sender {
    
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        if ([postDetails.LibStatus  isEqual: @"1"]) {
            [self hitApiToSaveDeleteAPostWithPostId:_postId useractv:@"0" andIndex: index];
        }
        else
        {
            [self hitApiToSaveDeleteAPostWithPostId:_postId useractv:@"1" andIndex: index];
            
        }
        
    }
    else
    {
        LoginViewController* vc ;
        vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        vc.Behaviour = @"Action";
        UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
        [self.navigationController presentViewController:navCon animated:true completion:nil];
        
    }
    
}
-(IBAction) btnCommentTapped:(id) sender {
    
    CommentViewController* vc ;
    vc = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
    vc.postId = _postId;
    
    [self.navigationController pushViewController:vc animated:true];
    
}
-(IBAction) btnShareTapped:(id) sender {
    
}




#pragma mark - Api Related
-(void)hitApiToLikeAPostWithPostId:(NSString*)postId andIndex:(int)row{
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    
    [dictRequest setValue:postId forKey:@"PostId"];
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_LIKE_POST]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
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
                        [arrData replaceObjectAtIndex:row withObject:dataObj];
                    }];
                    [_tblView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];;
                }else
                {
                    
                }
                
            }
            
            
            
        }];
    } else {
        
    }
}

#pragma mark - Api Related
-(void)hitApiToSaveDeleteAPostWithPostId:(NSString*)postId useractv:(NSString*)useractv andIndex:(int)row{
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    
    [dictRequest setValue:postId forKey:@"PostId"];
    [dictRequest setValue:useractv forKey:@"useractv"];
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_SAVE_DELETE_POST_LIBRARY]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
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
                        [arrData replaceObjectAtIndex:row withObject:dataObj];
                    }];
                    [_tblView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];;
                }else
                {
                    
                }
                
            }
            
            
            
        }];
    } else {
        
    }
}





-(void)hitApiForPostDetail{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    }
    else
    {
        [dictRequest setValue:@"0" forKey:@"UserId"];
    }
    [dictRequest setValue:_postId forKey:@"PostId"];

    
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self removeloder];
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_FETCH_POST_FOR_POST_ID]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                if (1) {
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
                        
                        postDetails = dataObj;
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



#pragma mark - API related

-(void)hitApiToGetGetCommentsForPost{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    }
    else
    {
        [dictRequest setValue:@"0" forKey:@"UserId"];
    }
    [dictRequest setValue:_postId forKey:@"PostId"];
    
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self removeloder];
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_FETCH_COMMENTS_FOR_POST]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                if (1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"_post"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        PostModel *dataObj = [PostModel new];
                        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                            @try {
                                [dataObj setValue:obj forKey:(NSString *)key];
                                if ([key isEqualToString:@"_cmtlikes"]){
                                    
                                    NSMutableArray* arrComment = [NSMutableArray new];
                                    
                                    [obj enumerateObjectsUsingBlock:^(id  _Nonnull objCom, NSUInteger idx, BOOL * _Nonnull stop) {
                                        
                                        CommentLike *objComment = [CommentLike new];
                                        
                                        [objCom enumerateKeysAndObjectsUsingBlock:^(id keycomtemp, id objcomtemp, BOOL *stop){
                                            @try {
                                                [objComment setValue:objcomtemp forKey:(NSString *)keycomtemp];
                                                
                                            } @catch (NSException *exception) {
                                                NSLog(exception.description);
                                                //  Handle an exception thrown in the @try block
                                            } @finally {
                                                //  Code that gets executed whether or not an exception is thrown
                                            }
                                        }];
                                        [arrComment addObject:objComment];
                                        
                                    }];
                                    dataObj._cmtlikes = arrComment;
                                }
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



