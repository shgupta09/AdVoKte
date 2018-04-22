//
//  JournalFeedsViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 17/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "JournalFeedsViewController.h"

@interface JournalFeedsViewController (){
    UIRefreshControl* refreshControl;
    NSMutableArray* arrData;
    LoderView *loderObj;
    UIImageView *imgViewToZoom;
    UITapGestureRecognizer *cameraGesture;
    

    
}


@end

@implementation JournalFeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonFunction setNavToController:self title:_postSubType isCrossBusston:false];

    [_tblView registerNib:[UINib nibWithNibName:@"FeedMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeedMainTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];
    refreshControl = [[UIRefreshControl alloc]init];
    [_tblView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    cameraGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeImage)];
    [cameraGesture setNumberOfTapsRequired:1];

    [self hitApiForAllPosts:@"0"];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handlers
- (void)refreshTable {
    //TODO: refresh your data
    [refreshControl endRefreshing];
    [self hitApiForAllPosts:@"0"];
    
}

#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedMainTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"FeedMainTableViewCell"];
    
    if (cell == nil) {
        cell = [[FeedMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedMainTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PostModel* data = [PostModel new];
    data = [arrData objectAtIndex:indexPath.row];
    
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
        [cell.btnLike setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;

    }
    else
    {
        [cell.btnLike setTitle:@"Like" forState:UIControlStateNormal];
                [cell.btnLike setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;

        
    }
    if ([data.LibStatus  isEqual: @"1"]){
        [cell.btnSave setTitle:@"Saved" forState:UIControlStateNormal];
        [cell.btnSave setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal] ;

    }
    else
    {
        [cell.btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [cell.btnSave setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;
        
    }
    
    cell.btnLike.tag = like_tag+indexPath.row;
    [cell.btnLike addTarget:self action:@selector(btnLikeTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnSave.tag = like_tag+indexPath.row;
    [cell.btnSave addTarget:self action:@selector(btnSaveTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnComment.tag = like_tag+indexPath.row;
    [cell.btnComment addTarget:self action:@selector(btnCommentTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnShare.tag = like_tag+indexPath.row;
    [cell.btnShare addTarget:self action:@selector(btnShareTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnImageToZoom.tag = like_tag+indexPath.row;
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
    
    if (indexPath.row == [arrData count] - 1)
    {
        [self hitApiForAllPosts:[NSString stringWithFormat:@"%d", indexPath.row]];
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedDetailViewController* vc ;
    vc = [[FeedDetailViewController alloc] initWithNibName:@"FeedDetailViewController" bundle:nil];
    PostModel* data = [arrData objectAtIndex:indexPath.row];
    vc.postId = data.PostId;
    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
    [self.navigationController presentViewController:navCon animated:true completion:nil];
    
}


#pragma mark - tap gesture
-(void)imageZoomClicked:(UITapGestureRecognizer*) sender{
    UIButton* btnLike = sender;
    int index = btnLike.tag%like_tag;
    PostModel* data = [arrData objectAtIndex:index];
    imgViewToZoom= [[UIImageView alloc]initWithFrame:self.view.frame];
    [imgViewToZoom sd_setImageWithURL:[NSURL URLWithString:data.PostPic]];
    [imgViewToZoom addGestureRecognizer:cameraGesture];
    imgViewToZoom.userInteractionEnabled = true;
    [self.view addSubview:imgViewToZoom];
}
-(void)removeImage{
    [imgViewToZoom removeFromSuperview];
}

#pragma mark - Read More

- (void)addReadMoreStringToUILabel:(UILabel*)label withString:(NSString*)stringText
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = label.lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName : label.font,
                                 NSParagraphStyleAttributeName : paragraph};
    CGSize constrainedSize = CGSizeMake(label.bounds.size.width, NSIntegerMax);
    CGRect rect = [label.text boundingRectWithSize:constrainedSize
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes:attributes context:nil];
    if (rect.size.height > label.bounds.size.height) {
        NSLog(@"TOO MUCH");
    }
}

#pragma mark - Cell button actions
-(void) btnLikeTapped:(id) sender {
    UIButton* btnLike = sender;
    int index = btnLike.tag%like_tag;
    PostModel* data = [arrData objectAtIndex:index];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [self hitApiToLikeAPostWithPostId:data.PostId andIndex: index];
        
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
-(void) btnSaveTapped:(id) sender {
    UIButton* btnLike = sender;
    int index = btnLike.tag%like_tag;
    PostModel* data = [arrData objectAtIndex:index];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        if ([data.LibStatus  isEqual: @"1"]) {
            [self hitApiToSaveDeleteAPostWithPostId:data.PostId useractv:@"0" andIndex: index];
        }
        else
        {
            [self hitApiToSaveDeleteAPostWithPostId:data.PostId useractv:@"1" andIndex: index];
            
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
-(void) btnCommentTapped:(id) sender {
    UIButton* btnLike = sender;
    int index = btnLike.tag%like_tag;
    PostModel* data = [arrData objectAtIndex:index];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        CommentViewController* vc ;
        vc = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
        vc.postId = data.PostId;
        UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
        [self.navigationController presentViewController:navCon animated:true completion:nil];
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
-(void) btnShareTapped:(id) sender {
    
    UIButton* btnLike = sender;
    int index = btnLike.tag%like_tag;
    PostModel* data = [arrData objectAtIndex:index];
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        [self sharePostWithIndex:index];
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
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];

                }
                
            }
            else
            {
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
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
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];

                }
                
            }
            else
            {
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
            }
            
            
        }];
    } else {
        
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
    [dictRequest setValue:_postSubType forKey:@"postsubtype"];
    [dictRequest setValue:@"Article" forKey:@"posttype"];
    [dictRequest setValue:startPoint forKey:@"StrtPnt"];
    [dictRequest setValue:[NSString stringWithFormat:@"%d",startPoint.integerValue+20] forKey:@"EndPnt"];
    
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_POSTS]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                        
                        [arrData addObject:dataObj];
                    }];
                    if (tempArray.count!=0){
                        [_tblView reloadData];
                    }
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




-(void)hitApiToShareWithPostId:(NSString*)postId{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    
    [dictRequest setValue:postId forKey:@"PostId"];
    
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


-(void) sharePostWithIndex:(int) row {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Share post via"
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Share via apps"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
                                    /** What we write here???????? **/
                                    CGRect myRect = [_tblView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];//example 0,1,indexPath
                                    
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
                                   PostModel* data = [arrData objectAtIndex:row];
                                   [self hitApiToShareWithPostId:data.PostId];
                               }];
    
    UIAlertAction* canceloButton = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        /** What we write here???????? **/
                                        // call method whatever u need
                                        PostModel* data = [arrData objectAtIndex:row];
                                        [self hitApiToShareWithPostId:data.PostId];
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

#pragma  mark - Button Actions
- (void)backTapped {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}





@end

