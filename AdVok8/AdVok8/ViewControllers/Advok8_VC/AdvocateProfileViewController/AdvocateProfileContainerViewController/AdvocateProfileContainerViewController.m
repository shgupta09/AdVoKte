//
//  AdvocateProfileContainerViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateProfileContainerViewController.h"
#import "AdvocateProfileTabViewController.h"
#import "AdvocateAvailabilityTabViewController.h"
#import "AdvocateAchievementTabViewController.h"

@interface AdvocateProfileContainerViewController ()
{
    NSString* currentTabName;

}
@end

@implementation AdvocateProfileContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonFunction setNavToController:self title:@"Advocate Profile" isCrossBusston:NO];
    [self resetTabs];
   
    self.cons_activeTab.constant = -self.btnProfile.bounds.size.width;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) resetTabs {
   
    
    
}

- (IBAction)btnTabsPressed:(id)sender {
    UIButton* btn = (UIButton*) sender;
    switch (btn.tag) {
        case 100:
        {
            NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
            
             self.cons_activeTab.constant = -self.btnProfile.bounds.size.width;
            
                [userInfo setValue:[AdvocateProfileTabViewController new] forKey:@"ActiveViewController"];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_Switch_To_Profile_Page" object:self userInfo:userInfo];
            
        }
            break;
        case 101:
        {
            NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
            
            self.cons_activeTab.constant = 0;
                
            [userInfo setValue:[AdvocateAvailabilityTabViewController new] forKey:@"ActiveViewController"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_Switch_To_Availability" object:self userInfo:userInfo];
            
            
        }
            break;
        case 102:
        {
            NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
                    self.cons_activeTab.constant = self.btnProfile.bounds.size.width;
                [userInfo setValue:[AdvocateAchievementTabViewController new] forKey:@"ActiveViewController"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_Switch_To_Achievement" object:self userInfo:userInfo];
        }
            break;
            
        default:
            break;
    }
}

@end

