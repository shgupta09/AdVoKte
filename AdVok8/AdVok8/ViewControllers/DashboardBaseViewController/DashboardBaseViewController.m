//
//  DashboardBaseViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "DashboardBaseViewController.h"
#import "CauseBaseVC.h"
#import "TaskListVC.h"
#import "AppealAlertVC.h"
#import "Me_VC.h"

@interface DashboardBaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray* arrOptions;
    NSArray* arrImages;
}
@end

@implementation DashboardBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_collectionView registerNib:[UINib nibWithNibName:@"DashboardHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DashboardHomeCollectionViewCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"RefreshViews"
                                               object:nil];
}

-(void)setData{
     if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
         
         if ([CommonFunction isadvoK8]){
             arrImages = [[NSArray alloc] initWithObjects:@"cause_list_icon.png",@"matter_icon.png",@"calendar_icon.png",@"task_icon.png",@"Appointment-1.png",@"Me.png",@"task_icon.png",@"display_board_icon.png",@"appeal_alert_icon.png", nil];
             arrOptions = [[NSArray alloc] initWithObjects:@"Cause List",@"Matters",@"Calendar",@"Task",@"Appointment",@"Me",@"My Activity",@"Display Board",@"Appeal Alert", nil];
             //        arrImages = [[NSArray alloc] initWithObjects:@"CaseTracking.png",@"Appointment-1.png",@"CaseTracking.png",@"CaseTracking.png", nil];
             //        arrOptions = [[NSArray alloc] initWithObjects:@"Task",@"Appointment",@"My Activity",@"Appeal Alert", nil];
         }
         else
         {
             arrImages = [[NSArray alloc] initWithObjects:@"find_lawyers_icon",@"case_tracking_icon",@"task_icon",@"appointment_icon",@"Me.png", nil];
             arrOptions = [[NSArray alloc] initWithObjects:@"Find Lawyers",@"Case Tracking",@"My Activity",@"Appointment",@"Me", nil];
         }
         
     }
    else
    {
        arrImages = [[NSArray alloc] initWithObjects:@"cause_list_icon.png",@"matter_icon.png",@"calendar_icon.png",@"task_icon.png",@"Appointment-1.png",@"Me.png",@"task_icon.png",@"display_board_icon.png",@"appeal_alert_icon.png", nil];
        arrOptions = [[NSArray alloc] initWithObjects:@"Cause List",@"Matters",@"Calendar",@"Task",@"Appointment",@"Me",@"My Activity",@"Display Board",@"Appeal Alert", nil];
    }
    
    [_collectionView reloadData];
}
#pragma mark - Notification


-(void)receiveNotification:(NSNotification*) notification{
    
    if ([notification.name  isEqual: @"RefreshViews"]) {
        [self setData];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self setData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegates methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return arrOptions.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashboardHomeCollectionViewCell *cell = (DashboardHomeCollectionViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:@"DashboardHomeCollectionViewCell" forIndexPath:indexPath];
    cell.imgView.layer.cornerRadius = 10;
    cell.imgView.clipsToBounds = true;
    CAShapeLayer* layering = [CAShapeLayer layer];
    [layering setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, cell.frame.size.width-20, cell.frame.size.height-20)] CGPath ]];
    [cell.imgView setImage:[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]]];
    cell.lblName.text = [arrOptions objectAtIndex:indexPath.row];
    
    //    [[cell.contentView layer] addSublayer:layering];
    //    [[cell.contentView layer] setMask:layering];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 3.0 ; //Replace the divisor with the column count requirement. Make sure to have it in float.
     DashboardHomeCollectionViewCell *cell = (DashboardHomeCollectionViewCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    CGFloat maxLabelWidth = 100;
    cell.lblName.text = [arrOptions objectAtIndex:indexPath.row];

    CGSize neededSize = [cell.lblName sizeThatFits:CGSizeMake(maxLabelWidth, CGFLOAT_MAX)];
    
    CGSize size = CGSizeMake(cellWidth, neededSize.height + 10 +cellWidth);
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        
        if ([CommonFunction isadvoK8]){
            switch (indexPath.row) {
                case 0:{
                    CauseBaseVC *causeOBJ = [[CauseBaseVC alloc]initWithNibName:@"CauseBaseVC" bundle:nil];
                    causeOBJ.isFirstSelected = true;
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:causeOBJ];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                    break;
                case 1:{
                    CauseBaseVC *causeOBJ = [[CauseBaseVC alloc]initWithNibName:@"CauseBaseVC" bundle:nil];
                    causeOBJ.isFirstSelected = false;
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:causeOBJ];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                    break;
                    
                case 2:
                {
                    CalendarViewController *vc = [[CalendarViewController alloc]initWithNibName:@"CalendarViewController" bundle:nil];
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                    break;
                case 3:{
                    
                    TaskListVC *taskObj = [[TaskListVC alloc]initWithNibName:@"TaskListVC" bundle:nil];
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:taskObj];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                    
                case 4:{
                    AppointmentListViewController *vc = [[AppointmentListViewController alloc]initWithNibName:@"AppointmentListViewController" bundle:nil];
                    vc.fromDashboard = @"Advocate";
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                case 5:{
                    
                    Me_VC *profileObj = [[Me_VC alloc]initWithNibName:@"Me_VC" bundle:nil];
                    
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:profileObj];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                case 6:{
                    ProfileVC *profileObj = [[ProfileVC alloc]initWithNibName:@"ProfileVC" bundle:nil];
                    profileObj.isFromMyActivity = false;
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:profileObj];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                    break;
                case 7:{
                    AppealAlertVC *appealObj = [[AppealAlertVC alloc]initWithNibName:@"AppealAlertVC" bundle:nil];
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:appealObj];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                default:
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 0:{
                    LawyersCategoryVC *lawyerVcOBJ = [[LawyersCategoryVC alloc]initWithNibName:@"LawyersCategoryVC" bundle:nil];
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:lawyerVcOBJ];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                    break;
                    
                case 1:{
                    CasePageListViewController *vc = [[CasePageListViewController alloc]initWithNibName:@"CasePageListViewController" bundle:nil];
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                    
                }
                    break;
                case 2:
                {
                    ProfileVC *profileObj = [[ProfileVC alloc]initWithNibName:@"ProfileVC" bundle:nil];
                    profileObj.isFromMyActivity = true;
                    [self.navigationController pushViewController:profileObj animated:true];
                    
                }
                    break;
                case 3:{
                    AppointmentListViewController *vc = [[AppointmentListViewController alloc]initWithNibName:@"AppointmentListViewController" bundle:nil];
                    vc.fromDashboard = @"User";
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                }
                    break;
                    
                case 4:{
                    Me_VC *profileObj = [[Me_VC alloc]initWithNibName:@"Me_VC" bundle:nil];
                    
                    UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:profileObj];
                    [self.navigationController presentViewController:navCon animated:true completion:nil];
                    
                }
                    break;
                default:
                    break;
            }
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


@end
