//
//  AdvocateProfilePageViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 03/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "AdvocateProfilePageViewController.h"

@interface AdvocateProfilePageViewController ()

@end

@implementation AdvocateProfilePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    //To stop swipe gesture of Page view Controller
    //    self.dataSource = self;
    
    AdvocateProfileTabViewController *startingViewController= [[UIStoryboard storyboardWithName:@"AdvocateProfileStoryboard" bundle: nil] instantiateViewControllerWithIdentifier:@"AdvocateProfileTabViewController"];
    AdvocateAvailabilityTabViewController *secondViewController= [[UIStoryboard storyboardWithName:@"AdvocateProfileStoryboard" bundle: nil] instantiateViewControllerWithIdentifier:@"AdvocateAvailabilityTabViewController"];
    AdvocateAchievementTabViewController *thirdViewController= [[UIStoryboard storyboardWithName:@"AdvocateProfileStoryboard" bundle: nil] instantiateViewControllerWithIdentifier:@"AdvocateAchievementTabViewController"];
    
    self.viewControllerArray = [[NSMutableArray alloc] initWithObjects:startingViewController,secondViewController,thirdViewController, nil];
    
    [self setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(switchViewController:)
                                                 name:@"notification_Switch_To_Profile_Page"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(switchViewController:)
                                                 name:@"notification_Switch_To_Availability"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(switchViewController:)
                                                 name:@"notification_Switch_To_Achievement"
                                               object:nil];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.viewControllerArray indexOfObject:viewController];
    // get the index of the current view controller on display
    
    if (currentIndex > 0)
    {
        return [self.viewControllerArray objectAtIndex:currentIndex-1];
        // return the previous viewcontroller
    } else
    {
        return nil;
        // do nothing
    }
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.viewControllerArray indexOfObject:viewController];
    // get the index of the current view controller on display
    // check if we are at the end and decide if we need to present
    // the next viewcontroller
    if (currentIndex < [self.viewControllerArray count]-1)
    {
        return [self.viewControllerArray objectAtIndex:currentIndex+1];
        // return the next view controller
    } else
    {
        return nil;
        // do nothing
    }
}

-(void) switchViewController:(NSNotification*) notification{
    
    NSDictionary* userInfo = notification.userInfo;
    if ([notification.name isEqualToString:@"notification_Switch_To_Profile_Page"]){
        [self setViewControllers:@[[self.viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    }
    else if ([notification.name isEqualToString:@"notification_Switch_To_Availability"]){
        [self setViewControllers:@[[self.viewControllerArray objectAtIndex:1]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    }
    else if ([notification.name isEqualToString:@"notification_Switch_To_Achievement"]){
        [self setViewControllers:@[[self.viewControllerArray objectAtIndex:2]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    }
    
}
@end
