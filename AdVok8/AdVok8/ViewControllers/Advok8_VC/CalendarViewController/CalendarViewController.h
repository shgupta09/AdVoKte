//
//  CalendarViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 31/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import <JTCalendar/JTCalendar.h>

@interface CalendarViewController : UIViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UITableView *tblEvents;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@end
