//
//  NoOfLikesViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 21/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "NoOfLikesViewController.h"

@interface NoOfLikesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* arrData;
    LoderView *loderObj;
}

@end

@implementation NoOfLikesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

#pragma mark- Navigation
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Likes" isCrossBusston:false];
    arrData = [[NSMutableArray alloc ] init];
    
    [self hitApiToGetAllLikeList];
    [self setUpTableView];
}
-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"NoOfLikesTableViewCell" bundle:nil]forCellReuseIdentifier:@"NoOfLikesTableViewCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoOfLikesTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"NoOfLikesTableViewCell"];
    if (cell == nil) {
        cell = [[NoOfLikesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NoOfLikesTableViewCell"];
    }
    PostModel* event = [arrData objectAtIndex:indexPath.row];
    [cell.imgViewProfile sd_setImageWithURL:[CommonFunction getProfilePicURLString:event.UserId]];
    cell.lblUsername.text = event.UserName;
    cell.lblSubtitle.text = event.Type;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PostModel* event = [arrData objectAtIndex:indexPath.row];

    ProfileVC *profileObj = [[ProfileVC alloc]initWithNibName:@"ProfileVC" bundle:nil];
    profileObj.isFromMyActivity = true;
    profileObj.isOther = true;
    profileObj.userId = event.UserId;
    [self.navigationController pushViewController:profileObj animated:true];

}

#pragma mark - API related

-(void)hitApiToGetAllLikeList{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:_postId forKey:@"PostId"];
    
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_LIKE_LIST]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
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
                    [_tblView reloadData];
                }else
                {
                    [[FadeAlert getInstance] displayToastWithMessage:[json objectForKey:@"ErrMsg"]];

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
