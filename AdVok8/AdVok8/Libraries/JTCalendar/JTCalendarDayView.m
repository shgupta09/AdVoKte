//
//  JTCalendarDayView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarDayView.h"

#import "JTCircleView.h"

@interface JTCalendarDayView (){
//    JTCircleView *circleView;
    
    UIView* myCircleView;
    UILabel *textLabel;
//    JTCircleView *dotView;
    // For requirement regarding events per date
    UILabel* dotView;
    
    
    BOOL isSelected;
    
    int cacheIsToday;
    NSString *cacheCurrentDateText;
}
@end

static NSString *kJTCalendarDaySelected = @"kJTCalendarDaySelected";

@implementation JTCalendarDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)commonInit
{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.9].CGColor;

    isSelected = NO;
    self.isOtherMonth = NO;
    
    {
//        circleView = [JTCircleView new];
//        [self addSubview:circleView];
        myCircleView = [UIView new];
        [self addSubview:myCircleView];
    }
    
    {
        textLabel = [UILabel new];
        textLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:textLabel];
    }
    
    {
//        dotView = [JTCircleView new];
        // For requirement to show number of events per date.
        dotView = [UILabel new];
        [self addSubview:dotView];
        dotView.hidden = YES;
    }
    
    {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouch)];

        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
    }
    
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDaySelected:) name:kJTCalendarDaySelected object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDaySelected:) name:@"EventFinal" object:nil];
    }
}

- (void)layoutSubviews
{
    [self configureConstraintsForSubviews];
    
    // No need to call [super layoutSubviews]
}

// Avoid to calcul constraints (very expensive)
- (void)configureConstraintsForSubviews
{
    textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 10);
    
    CGFloat sizeCircle = MIN(self.frame.size.width, self.frame.size.height);
    CGFloat sizeDot = sizeCircle;
    
    sizeCircle = sizeCircle * self.calendarManager.calendarAppearance.dayCircleRatio;
    sizeDot = sizeDot * self.calendarManager.calendarAppearance.dayDotRatio;
    
    sizeCircle = roundf(sizeCircle);
    sizeDot = roundf(sizeDot);
    
//    circleView.frame = CGRectMake(0, 0, sizeCircle, sizeCircle);
//    circleView.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
//    circleView.layer.cornerRadius = 0 ;
    
    myCircleView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    myCircleView.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    myCircleView.layer.cornerRadius = 0 ;
    
    dotView.frame = CGRectMake(5, self.frame.size.height - 18 , self.frame.size.width - 10, 15);
//    dotView.backgroundColor = [UIColor redColor];
//    dotView.center = CGPointMake(6, (self.frame.size.height / 2. +2) + sizeDot * 2.5);
    dotView.layer.cornerRadius = 0;
//    dotView.layer.borderColor = [UIColor darkGrayColor].CGColor;
//    dotView.layer.borderWidth = 0.5;
    dotView.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
}

- (void)setDate:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = self.calendarManager.calendarAppearance.calendar.timeZone;
        [dateFormatter setDateFormat:@"dd"];
    }
    
    self->_date = date;
    
    textLabel.text = [dateFormatter stringFromDate:date];
    
    cacheIsToday = -1;
    cacheCurrentDateText = nil;
}

- (void)didTouch
{
    [self setSelected:YES animated:YES];
    [self.calendarManager setCurrentDateSelected:self.date];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kJTCalendarDaySelected object:self.date];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowPopUp" object:self];
    
    [self.calendarManager.dataSource calendarDidDateSelected:self.calendarManager date:self.date];
    
    if(!self.isOtherMonth){
        return;
    }
    
    NSInteger currentMonthIndex = [self monthIndexForDate:self.date];
    NSInteger calendarMonthIndex = [self monthIndexForDate:self.calendarManager.currentDate];
        
    currentMonthIndex = currentMonthIndex % 12;
    
    if(currentMonthIndex == (calendarMonthIndex + 1) % 12){
        [self.calendarManager loadNextMonth];
    }
    else if(currentMonthIndex == (calendarMonthIndex + 12 - 1) % 12){
        [self.calendarManager loadPreviousMonth];
    }

}

- (void)didDaySelected:(NSNotification *)notification
{
        NSDate *dateSelected = [notification object];
        
        if([self isSameDate:dateSelected]){
            if(!isSelected){
                [self setSelected:YES animated:YES];
            }
        }
        else if(isSelected){
            [self setSelected:NO animated:YES];
        }
}

-(void) setEventFinalView:(NSString*) date {
//    NSLog(@"%@",date);
    
    myCircleView.transform = CGAffineTransformIdentity;
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGFloat opacity = 1.;
    
        myCircleView.backgroundColor = [UIColor redColor];
        textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorSelected];
        myCircleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        tr = CGAffineTransformIdentity;
    
        myCircleView.layer.opacity = opacity;
        myCircleView.transform = tr;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(isSelected == selected){
        animated = NO;
    }
    
    isSelected = selected;
    
//    circleView.transform = CGAffineTransformIdentity;
    myCircleView.transform = CGAffineTransformIdentity;
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGFloat opacity = 1.;
    
    
    if(selected){
        if(!self.isOtherMonth){
//            circleView.color = [self.calendarManager.calendarAppearance dayCircleColorSelected];
            myCircleView.backgroundColor = [self.calendarManager.calendarAppearance dayCircleColorSelected];
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorSelected];
            
        }
        else{
//            circleView.color = [self.calendarManager.calendarAppearance dayCircleColorSelectedOtherMonth];
            myCircleView.backgroundColor = [self.calendarManager.calendarAppearance dayCircleColorSelectedOtherMonth];
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorSelectedOtherMonth];
//            dotView.color = [self.calendarManager.calendarAppearance dayDotColorSelectedOtherMonth];
        }
        
//        circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
//        dotView.textColor = [UIColor colorWithRed:159.0/255.0 green:14.0/255.0 blue:3.0/255.0 alpha:1.0];
        myCircleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        tr = CGAffineTransformIdentity;
    }
    else if([self isToday]){
        if(!self.isOtherMonth){
//            circleView.color = [self.calendarManager.calendarAppearance dayCircleColorToday];
            myCircleView.backgroundColor = [self.calendarManager.calendarAppearance dayCircleColorToday];
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorToday];
//            dotView.color = [self.calendarManager.calendarAppearance dayDotColorToday];
        }
        else{
//            circleView.color = [self.calendarManager.calendarAppearance dayCircleColorTodayOtherMonth];
            myCircleView.backgroundColor = [self.calendarManager.calendarAppearance dayCircleColorTodayOtherMonth];
            
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorTodayOtherMonth];
//            dotView.color = [self.calendarManager.calendarAppearance dayDotColorTodayOtherMonth];
        }
    }
    else{
        if(!self.isOtherMonth){
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColor];
        }
        else{
            textLabel.textColor = [self.calendarManager.calendarAppearance dayTextColorOtherMonth];
        }
        
        opacity = 0.;
    }
    
    if(animated){
        [UIView animateWithDuration:.3 animations:^{
            myCircleView.layer.opacity = opacity;
            myCircleView.transform = tr;
        }];
    }
    else{
        myCircleView.layer.opacity = opacity;
        myCircleView.transform = tr;
    }
    
    
     int count;
    count = [self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:self.date];
    if (count>0) {
        dotView.hidden = NO;
        dotView.text = [NSString stringWithFormat:@"%d",count] ;
        dotView.textColor = [UIColor colorWithRed:159.0/255.0 green:14.0/255.0 blue:3.0/255.0 alpha:1.0];
        self.backgroundColor = [UIColor whiteColor];
        textLabel.textColor = [UIColor darkGrayColor];
    }
    else if (count ==0){
        dotView.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        dotView.hidden = NO;
        dotView.textColor = [UIColor lightGrayColor];
        dotView.text = [NSString stringWithFormat:@"%d",abs(count)] ;
        self.backgroundColor = [UIColor colorWithRed:159.0/255.0 green:14.0/255.0 blue:3.0/255.0 alpha:1.0];
    }

}

- (void)setIsOtherMonth:(BOOL)isOtherMonth
{
    self->_isOtherMonth = isOtherMonth;
    [self setSelected:isSelected animated:NO];
}

- (void)reloadData
{
   
    
    BOOL selected = [self isSameDate:[self.calendarManager currentDateSelected]];
    [self setSelected:selected animated:NO];
    
    
    
}

- (BOOL)isToday
{
    if(cacheIsToday == 0){
        return NO;
    }
    else if(cacheIsToday == 1){
        return YES;
    }
    else{
        if([self isSameDate:[NSDate date]]){
            cacheIsToday = 1;
            return YES;
        }
        else{
            cacheIsToday = 0;
            return NO;
        }
    }
}

- (BOOL)isSameDate:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = self.calendarManager.calendarAppearance.calendar.timeZone;
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    }
    
    if(!cacheCurrentDateText){
        cacheCurrentDateText = [dateFormatter stringFromDate:self.date];
    }
    
    NSString *dateText2 = [dateFormatter stringFromDate:date];
    
    if ([cacheCurrentDateText isEqualToString:dateText2]) {
        return YES;
    }
    
    return NO;
}

- (NSInteger)monthIndexForDate:(NSDate *)date
{
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:date];
    return comps.month;
}

- (void)reloadAppearance
{
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = self.calendarManager.calendarAppearance.dayTextFont;
    
    [self configureConstraintsForSubviews];
    [self setSelected:isSelected animated:NO];
}

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
