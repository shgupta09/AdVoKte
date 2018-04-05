//
//  JTCalendarDayView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface JTCalendarDayView : UIView

@property (weak, nonatomic) JTCalendar *calendarManager;

@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isOtherMonth;

-(void) setEventFinalView:(NSString*) date;
-(void) setQueryView:(NSString*) date;
- (void)reloadData;
- (void)reloadAppearance;

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (;)
// From the most professional code share website: Code4App.net 
