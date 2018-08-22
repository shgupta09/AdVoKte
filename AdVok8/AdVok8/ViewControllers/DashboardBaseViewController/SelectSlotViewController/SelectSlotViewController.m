//
//  SelectSlotViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 05/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "SelectSlotViewController.h"

@interface SelectSlotViewController ()
{

    NSMutableArray* arrDays;
    NSMutableArray* arrTime;
    UISwipeGestureRecognizer * swiperight;
    UISwipeGestureRecognizer * swipeleft;
    NSDate* selectedDate;
    NSString* dayName;
    NSString* dateString;
}
@end

@implementation SelectSlotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_imgViewProfile sd_setImageWithURL:[CommonFunction getProfilePicURLString:_obj.username]];
    
    selectedDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    dayName = [dateFormatter stringFromDate:selectedDate];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateString = [dateFormatter stringFromDate:selectedDate];
    
    _lblDay.text = dayName;
    _lblDate.text = [NSString stringWithFormat:@"%@", dateString];
    
    _lblUsername.text = [NSString stringWithFormat:@"%@ %@", _obj.fname,_obj.lname];
    _lblLawyertype.text = _obj.AOP;
    
    [CommonFunction setNavToController:self title:@"Appointment" isCrossBusston:false];

    swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    // SwipeRight
    
    swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SlotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SlotCollectionViewCell"];

    NSString* dayTime = _obj.DayTime;
    NSString* strDays = [[dayTime componentsSeparatedByString:@"#"] objectAtIndex:0];
    NSArray* arrDays = [strDays componentsSeparatedByString:@", "];
    NSString* strTime = [[dayTime componentsSeparatedByString:@"#"] objectAtIndex:1];
    
    NSDate *now = [CommonFunction convertTimeToDate: [[strTime componentsSeparatedByString:@"-"] objectAtIndex:0]];
    NSDate *end = [CommonFunction convertTimeToDate: [[strTime componentsSeparatedByString:@"-"] objectAtIndex:1]];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // get minute and hour from now
    NSDateComponents *nowComponents = [cal components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate: now];
    NSDateComponents *endComponents = [cal components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate: end];
    NSDate *currentDate;
    // if current minutes is not exactly 0 or 30 get back to the past half hour
    
    currentDate = now;
    
    arrTime = [NSMutableArray array];
    // loop and add 30 minutes until the end time (10:30 pm) is reached
    while ( nowComponents.hour != [[[[[strTime componentsSeparatedByString:@"-"] objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:0] integerValue]) {
        currentDate = [cal dateByAddingUnit:NSCalendarUnitMinute value: 30 toDate: currentDate options: NSCalendarMatchNextTime];
        
        // Convert to new Date Format
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *newDate = [dateFormatter stringFromDate:currentDate];
        
        nowComponents = [cal components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate: currentDate];
        
        [arrTime addObject:newDate];
        
        
    }
    
    
    [_collectionView reloadData];
  
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Swipe handlers
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    // get minute and hour from now
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:selectedDate options:0];
    
    selectedDate = nextDate;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    dayName = [dateFormatter stringFromDate:selectedDate];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateString = [dateFormatter stringFromDate:selectedDate];

    _lblDay.text = dayName;
    _lblDate.text = [NSString stringWithFormat:@"%@", dateString];
    NSLog(@"nextDate: %@ ...", nextDate);
    //Do what you want here
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    // get minute and hour from now
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:selectedDate options:0];
    
    selectedDate = nextDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    dayName = [dateFormatter stringFromDate:selectedDate];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateString = [dateFormatter stringFromDate:selectedDate];

    _lblDay.text = dayName;
    _lblDate.text = [NSString stringWithFormat:@"%@", dateString];
    NSLog(@"nextDate: %@ ...", nextDate);
    //Do what you want here
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}

#pragma mark - Collection View Delegates methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrTime.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SlotCollectionViewCell *cell = (SlotCollectionViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:@"SlotCollectionViewCell" forIndexPath:indexPath];
    
    cell.lblTime.text = [arrTime objectAtIndex:indexPath.item];
        
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 5 ; //Replace the divisor with the column count requirement. Make sure to have it in float.
    LawyerCategoryTableViewCell *cell = (LawyerCategoryTableViewCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    CGFloat maxLabelWidth = 100;
    Specialization* obj = [Specialization new];
    
    cell.lblName.text = obj.name;
    CGSize neededSize = [cell.lblName sizeThatFits:CGSizeMake(maxLabelWidth, CGFLOAT_MAX)];
    
    CGSize size = CGSizeMake(cellWidth, neededSize.height + 10 +60);
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ConfirmAppointmentViewController* vc = [[ConfirmAppointmentViewController alloc] init];
    vc.dayString = dateString;
    vc.dateString = [arrTime objectAtIndex:indexPath.item];
    vc.obj = _obj;
    [self.navigationController pushViewController:vc animated:true];
    
}




@end
