//
//  User_Profile_VC.m
//  AdVok8
//
//  Created by shubham gupta on 4/14/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "User_Profile_VC.h"
#import "Edit_UserProfile_VC.h"
@interface User_Profile_VC (){
    NSMutableArray *headerDataArray;
    NSMutableArray *headerArray;
    NSMutableArray *tempArray;
}
@end

@implementation User_Profile_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)setUpData{
    [CommonFunction setNavToController:self title:@"Profile" isCrossBusston:false];
    [self setHeaderDataArray];
    [self setUpTableView];
}
-(void)setHeaderDataArray{
    headerArray = [[NSMutableArray alloc]initWithObjects:@"PERSONAL DETAIL:",@"ADDRESS DETAIL", nil];
    headerDataArray = [NSMutableArray new];
    tempArray = [NSMutableArray new];
    tempArray = [[NSMutableArray alloc] initWithObjects:@"Name",@"Contact No",@"Alternate Contact No",@"Email ID",@"Gender",@"DOB", nil];
    [headerDataArray addObject:tempArray];
    tempArray = [[NSMutableArray alloc] initWithObjects:@"Address1",@"Address2",@"Street",@"Landmark",@"Locality",@"State",@"Country",@"Pin Code", nil];
    [headerDataArray addObject:tempArray];
    
}
#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"User_Profile_Cell" bundle:nil]forCellReuseIdentifier:@"User_Profile_Cell"];
    [_tblView registerNib:[UINib nibWithNibName:@"User_Header" bundle:nil] forHeaderFooterViewReuseIdentifier:kUser_HeaderReuseIdentifier];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 44;
    _tblView.multipleTouchEnabled = NO;
    _tblView.allowMultipleSectionsOpen = true;
    _tblView.keepOneSectionOpen = true;
    _tblView.initialOpenSections = [NSSet setWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1], nil];
    
    [CommonFunction setCornerRadius:_imgView Radius:50];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *temp =(NSMutableArray*)[headerDataArray objectAtIndex:section];
    return [temp count];
    //    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return headerArray.count;
    //    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kDefaulAUser_HeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User_Profile_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"User_Profile_Cell" forIndexPath:indexPath];
    cell.lbl_Title.text = [[headerDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    User_Header *accordiamViewObj = (User_Header *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kUser_HeaderReuseIdentifier];
    accordiamViewObj.lbl_headerTitle.text = [[headerArray objectAtIndex:section] capitalizedString];
    accordiamViewObj.backgroundColor = [UIColor lightGrayColor];
    return accordiamViewObj;
}

- (void) handleGesture:(UIGestureRecognizer *)gestureRecognizer;{
    
}


#pragma mark - btn Action

- (IBAction)btnAction_Edit:(id)sender {
    Edit_UserProfile_VC *profileObj = [[Edit_UserProfile_VC alloc]initWithNibName:@"Edit_UserProfile_VC" bundle:nil];
    [self.navigationController pushViewController:profileObj animated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
