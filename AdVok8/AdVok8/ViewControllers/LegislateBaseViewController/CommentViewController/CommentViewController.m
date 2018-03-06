//
//  CommentViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 05/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()
{
    NSMutableArray* arrData;
    LoderView *loderObj;
}
@end
//18574
@implementation CommentViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = false;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [CommonFunction colorWithHexString:@"28328C"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross-1"] style: UIBarButtonItemStyleBordered target:self action:@selector(backTapped)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.navigationController setTitle:@"Login"];
    [_tblView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil]forCellReuseIdentifier:@"CommentTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];
    
    [self hitApiToGetGetCommentsForPost];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    _const_bottomSpace.constant = -keyboardSize.height;
    [self.view layoutSubviews];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    _const_bottomSpace.constant = 0;
}

#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PostModel* data = [PostModel new];
    data = [arrData objectAtIndex:indexPath.row];

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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

#pragma  mark - Button Actions
- (void)backTapped {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}



@end
