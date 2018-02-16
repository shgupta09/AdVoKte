//
//  FeedViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController (){
    UIRefreshControl* refreshControl;
    NSMutableArray* arrData;
    LoderView *loderObj;

}

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tblView registerNib:[UINib nibWithNibName:@"FeedMainTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeedMainTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];
    refreshControl = [[UIRefreshControl alloc]init];
    [_tblView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
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
    cell.lblLikes.text = [NSString stringWithFormat:@"%@ likes", data.cntlike ];
    cell.lblComments.text = [NSString stringWithFormat:@"%@ comments",data.cntcmt];

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



#pragma mark - Api Related
-(void)hitApiForAllPosts:(NSString*) startPoint{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:@"0" forKey:@"UserId"];
    [dictRequest setValue:@"Feed" forKey:@"postsubtype"];
    [dictRequest setValue:@"Feed" forKey:@"posttype"];
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
