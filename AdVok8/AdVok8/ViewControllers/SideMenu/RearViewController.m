//
//  RearViewController.m
//  TatabApp
//
//  Created by NetprophetsMAC on 10/3/17.
//  Copyright © 2017 Shagun Verma. All rights reserved.
//

#import "RearViewController.h"
@interface RearViewController ()
{
    NSMutableArray *titleArray;
    NSMutableArray *titleImageArray;
     SWRevealViewController *revealController;
   // NSMutableArray *categoryArray;
    LoderView *loderObj;

    

}
@property (weak, nonatomic) IBOutlet UIView *lblSectionSeparator;
@end

@implementation RearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     revealController = [self revealViewController];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"RefreshViews"
                                               object:nil];

    
     [_tbl_View registerNib:[UINib nibWithNibName:@"RearCell" bundle:nil]forCellReuseIdentifier:@"RearCell"];
    _tbl_View.rowHeight = UITableViewAutomaticDimension;
    _tbl_View.estimatedRowHeight = 100;
    _tbl_View.multipleTouchEnabled = NO;
    
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        titleArray  = [[NSMutableArray alloc]initWithObjects:@"Logout",@"Home",@"Notification",@"Invite Friends",@"Rate Us",@"Call Request", nil];
        titleImageArray = [[NSMutableArray alloc] initWithObjects:@"logout",@"home",@"Notify-1",@"Invite Friend-1",@"rateUs",@"callrequest", nil];
    }
    else
    {
        titleArray  = [[NSMutableArray alloc]initWithObjects:@"Login",@"Home",@"Notification",@"Invite Friends",@"Rate Us",@"Call Request", nil];
        titleImageArray = [[NSMutableArray alloc] initWithObjects:@"Login-1",@"home",@"Notify-1",@"Invite Friend-1",@"rateUs",@"callrequest", nil];
    }
    //categoryArray = [AwarenessCategory sharedInstance].myDataArray;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn] == true){
        NSString* username = [CommonFunction getValueFromDefaultWithKey:@"loginUsername"];
        _lblNAme.text = [CommonFunction getValueFromDefaultWithKey:@"DisplayName"];
        [_imgView sd_setImageWithURL:[CommonFunction getProfilePicURLString:username] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
    }
    else
    {
        _lblNAme.text = @"Guest";
        _imgView.image = [UIImage imageNamed:@"dependentsuser"];
    }
    
}
-(void)viewDidLayoutSubviews{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RearCell *rearCell = [_tbl_View dequeueReusableCellWithIdentifier:@"RearCell"];
    
    rearCell.lbl_title.text = [titleArray objectAtIndex:indexPath.row];
    rearCell.imgView.image = [UIImage imageNamed:[titleImageArray objectAtIndex:indexPath.row]];
    
    rearCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rearCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [revealController revealToggle:nil];

    switch (indexPath.row) {
        case 0:
        {
             if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
             
                 [CommonFunction stroeBoolValueForKey:isLoggedIn withBoolValue:false];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshViews" object:nil];

             }
            else
            {
                LoginViewController* vc ;
                
                vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController* navCon = [[UINavigationController alloc ] initWithRootViewController:vc];

                [self.navigationController presentViewController:navCon animated:true completion:nil];
//                [self.navigationController pushViewController:vc animated:true];
            }
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
                NotificationListViewController* vc ;
                vc = [[NotificationListViewController alloc] initWithNibName:@"NotificationListViewController" bundle:nil];
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
            break;
        case 3:
        {
            NSString *textToShare = @"Android app : https://play.google.com/store/apps/details?id=com.advok8  and find iOS app on app store : https://itunes.apple.com/us/app/advok8/id1375029911?ls=1&mt=8";
            NSArray *objectsToShare = @[textToShare];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
            
            [self presentViewController:activityVC animated:YES completion:nil];
            
        }
            break;
        case 4:
        {
            NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1375029911";
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                str = @"itms-apps://itunes.apple.com/app/idyourAppIDHere";
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 5:
        {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"CallREQUEST"
             object:self];
            
        }
            break;
        case 6:
        {
            
        }
            break;

        default:
            break;
    }
}



#pragma mark - add loder

-(void)addLoder{
    self.view.userInteractionEnabled = NO;
    //  loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
    loderObj = [[LoderView alloc] initWithFrame:self.view.frame];
    loderObj.lbl_title.text = @"Fetching data...";
    [self.view addSubview:loderObj];
}

-(void)removeloder{
    //loderObj = nil;
    [loderObj removeFromSuperview];
    //[loaderView removeFromSuperview];
    self.view.userInteractionEnabled = YES;
}


#pragma mark - Notification


-(void)receiveNotification:(NSNotification*) notification{
    
    if ([notification.name  isEqual: @"RefreshViews"]) {
        if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
            if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn] == true){
                NSString* username = [CommonFunction getValueFromDefaultWithKey:@"loginUsername"];
                _lblNAme.text = [CommonFunction getValueFromDefaultWithKey:@"DisplayName"];
                [_imgView sd_setImageWithURL:[CommonFunction getProfilePicURLString:username] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
            }
            else
            {
                _lblNAme.text = @"Guest";
                _imgView.image = [UIImage imageNamed:@"dependentsuser"];
            }
            titleArray  = [[NSMutableArray alloc]initWithObjects:@"Logout",@"Home",@"Notification",@"Invite Friends",@"Rate Us",@"Call Request", nil];
            titleImageArray = [[NSMutableArray alloc] initWithObjects:@"logout",@"home",@"Notify-1",@"Invite Friend-1",@"rateUs",@"callrequest", nil];
            [_tbl_View reloadData];
        }
        else
        {
            _lblNAme.text = @"Guest";
            titleArray  = [[NSMutableArray alloc]initWithObjects:@"Login",@"Home",@"Notification",@"Invite Friends",@"Rate Us",@"Call Request", nil];
            titleImageArray = [[NSMutableArray alloc] initWithObjects:@"Login-1",@"home",@"Notify-1",@"Invite Friend-1",@"rateUs",@"callrequest", nil];
            [_tbl_View reloadData];

        }
    }
   
    
}


@end
