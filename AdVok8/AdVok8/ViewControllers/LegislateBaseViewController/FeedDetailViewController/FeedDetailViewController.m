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


    [CommonFunction setNavToController:self title:@"Feed Detail" isCrossBusston:false];

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
            [cell.btnLike setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;
            [_btnLike setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;
        }
        else
        {
            [_btnLike setTitle:@"Like" forState:UIControlStateNormal];
            [cell.btnLike setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;
            [_btnLike setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;


        }
        if ([data.LibStatus  isEqual: @"1"]){
            [_btnSave setTitle:@"Saved" forState:UIControlStateNormal];
            [cell.btnSave setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;
            [_btnSave setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;

        }
        else
        {
            [_btnSave setTitle:@"Save" forState:UIControlStateNormal];
            [cell.btnSave setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;
            [_btnSave setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;

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
     if (![data._cmtlikes isKindOfClass:[NSNull class]])
     cell.lblCountLikes.text = [NSString stringWithFormat:@"%lu",(unsigned long)data._cmtlikes.count];
     
     if ([data.Liked  isEqual: @"TRUE"]){
         [cell.btnLike setTitle:@"Liked" forState:UIControlStateNormal];
         [cell.btnLike setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;

     }
     else
     {
         [cell.btnLike setTitle:@"Like" forState:UIControlStateNormal];
                 [cell.btnLike setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;

         
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
        [self hitApiToLikeAPostWithPostId:_postId];
        
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
    
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [self sharePost];
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




#pragma mark - Api Related
-(void)hitApiToLikeAPostWithPostId:(NSString*)postId{
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
                        [arrData removeAllObjects];
                        postDetails = dataObj;
                        [arrData addObject:dataObj];
                        
                    }];
                    [_tblView reloadData];;
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

                        [arrData removeAllObjects];
                        postDetails = dataObj;

                        [arrData addObject:dataObj];

                    }];
                    [_tblView reloadData];
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



-(void)hitApiToShare{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    
    [dictRequest setValue:_postId forKey:@"PostId"];
    
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_PUT_SHARE]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    //ALERT Shared Successfully
                    [self removeloder];
                    
                    
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


-(void) sharePost {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Share post via"
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Share via apps"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
                                    /** What we write here???????? **/
                                    CGRect myRect = [_tblView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];//example 0,1,indexPath
                                    
                                    UIImage *img = [self cropImage:[self screenshot] rect:myRect];
                                    
                                    NSString *textToShare = @"https://play.google.com/store/apps/details?id=com.advok8";
                                    UIImage * image = img;
                                    
                                    NSArray *objectsToShare = @[textToShare, image];
                                    
                                    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
                                    
                                    
                                    [self presentViewController:activityVC animated:YES completion:nil];
                                    
                                    NSLog(@"fdsv");
                                    // call method whatever u need
                                }];
    
    UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"Advok8 Share"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   /** What we write here???????? **/
                                   // call method whatever u need
                                   [self hitApiToShare];
                               }];
    
    UIAlertAction* canceloButton = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        /** What we write here???????? **/
                                        // call method whatever u need
                                        [self hitApiToShare];
                                    }];
    
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    [alert addAction:canceloButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(UIImage *)cropImage:(UIImage *)image rect:(CGRect)cropRect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return img;
}

- (UIImage *) screenshot {
    
    CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rec = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height); //set the frame
    [self.view drawViewHierarchyInRect:rec afterScreenUpdates:YES];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end



