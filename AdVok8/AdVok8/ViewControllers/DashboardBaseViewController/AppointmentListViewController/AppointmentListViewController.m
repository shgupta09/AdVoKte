//
//  AppointmentListViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 05/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AppointmentListViewController.h"

@interface AppointmentListViewController (){
    NSMutableArray* arrData;
    LoderView *loderObj;
}

@end

@implementation AppointmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonFunction setNavToController:self title:@"Appointment" isCrossBusston:false];

    [_tblView registerNib:[UINib nibWithNibName:@"AppointmentListTableViewCell" bundle:nil]forCellReuseIdentifier:@"AppointmentListTableViewCell"];
    arrData = [[NSMutableArray alloc ] init];
    
//    [self hitApiForAllPosts:@"0"];
    
    // [self hitApitoDelete];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark- Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return arrData.count;
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentListTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentListTableViewCell"];
    
    if (cell == nil) {
        cell = [[AppointmentListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppointmentListTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    PostModel* data = [PostModel new];
//    data = [arrData objectAtIndex:indexPath.row];
//
//    cell.lblUserName.text = data.UserName;
//    cell.lblUserType.text = data.Details;
//    cell.lblPostCreatedTime.text = data.Days;
//    cell.lblPostNote.text = data.PostNote;
//
//
//    [cell.imgViewProfilePic sd_setImageWithURL:[CommonFunction getProfilePicURLString:data.UserId] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
//
//    if ([data.ArticleTitle  isEqual: @""]){
//        cell.lblHeading.text = @"";
//    }
//    else
//    {
//        cell.lblHeading.text = data.ArticleTitle;
//    }
//    cell.lblPostNote.text = data.PostNote;
//    cell.lblLikes.text = [NSString stringWithFormat:@"%@ likes", data.cntlike ];
//    cell.lblComments.text = [NSString stringWithFormat:@"%@ comments",data.cntcmt];
//
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//


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
