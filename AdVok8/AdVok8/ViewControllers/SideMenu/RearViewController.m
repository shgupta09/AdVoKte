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
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
