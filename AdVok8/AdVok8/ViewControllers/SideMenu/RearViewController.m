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
    
//    _viewToClip.layer.cornerRadius = 5;
//    _viewToClip.layer.masksToBounds = true;
//    _viewToClip.layer.borderColor = [UIColor whiteColor].CGColor;
//    _viewToClip.layer.borderWidth = 1;
     [_tbl_View registerNib:[UINib nibWithNibName:@"RearCell" bundle:nil]forCellReuseIdentifier:@"RearCell"];
    _tbl_View.rowHeight = UITableViewAutomaticDimension;
    _tbl_View.estimatedRowHeight = 100;
    _tbl_View.multipleTouchEnabled = NO;
    
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
   
          return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    [revealController revealToggle:nil];
     if ([CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]) {
//    if (indexPath.row<categoryArray.count){
//        
//        DoctorListVC* vc ;
//        vc = [[DoctorListVC alloc] initWithNibName:@"DoctorListVC" bundle:nil];
//        vc.awarenessObj = [categoryArray objectAtIndex:indexPath.row];
//        [self.navigationController pushViewController:vc animated:true];
//    }else{
        
        if ([[CommonFunction getValueFromDefaultWithKey:loginuserType] isEqualToString:@"Patient"]) {
            switch (indexPath.row) {
                case 0:{
                    ChooseDependantViewController* vc ;
                    vc = [[ChooseDependantViewController alloc] initWithNibName:@"ChooseDependantViewController" bundle:nil];
                    vc.patientID = [CommonFunction getValueFromDefaultWithKey:loginuserId];
                    vc.classObj = self;
                    vc.isManageDependants = true;
                    [self.navigationController pushViewController:vc animated:true];
                }
                    break;
                    
                case 1:
                {
                    ChooseDependantViewController* vc ;
                    vc = [[ChooseDependantViewController alloc] initWithNibName:@"ChooseDependantViewController" bundle:nil];
                    vc.patientID = [CommonFunction getValueFromDefaultWithKey:loginuserId];
                    vc.classObj = self;
                    vc.isManageDependants = false;

                    [self.navigationController pushViewController:vc animated:true];
                }
                    break;
                case 2:{
                    PatientHomeVC* vc ;
                    vc = [[PatientHomeVC alloc] initWithNibName:@"PatientHomeVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:true];
                }
                    break;
                case 3:
                {
                    
                }
                    break;

                
                case 4:{
                }
                    break;
                case 5:{
                   }
                    break;

                default:
                    break;
            }
        }
        */
}



- (IBAction)btn_Logout:(id)sender {
     [revealController revealToggle:nil];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"LogOutTapped"
     object:self];
     
    /*
    UIAlertController * alert=   [UIAlertController
                                                                                    alertControllerWithTitle:@"Logout"
                                                                                    message:@"Are you sure you want to Logout?"
                                                                                    preferredStyle:UIAlertControllerStyleAlert];
                                  
                                                      UIAlertAction* ok = [UIAlertAction
                                                                           actionWithTitle:@"OK"
                                                                           style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action)
                                                                           {
                                                                               [revealController revealToggle:nil];

                                                                               [_tbl_View reloadData];
                                                                               [CommonFunction stroeBoolValueForKey:isLoggedIn withBoolValue:false];
                                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                                               [[NSNotificationCenter defaultCenter]
                                                                                postNotificationName:@"LogoutNotification"
                                                                                object:self];
                                  
                                                                           }];
                                                      UIAlertAction* cancel = [UIAlertAction
                                                                               actionWithTitle:@"Cancel"
                                                                               style:UIAlertActionStyleDefault
                                                                               handler:^(UIAlertAction * action)
                                                                               {
                                                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                                                   [[NSNotificationCenter defaultCenter]
                                                                                    postNotificationName:@"CancelNotification"
                                                                                    object:self];
                                                                                   
                                                                               }];
                                                      
                                                      [alert addAction:ok];
                                                      [alert addAction:cancel];
                                                      
                                                      [self presentViewController:alert animated:YES completion:nil];
*/

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
