//
//  CommonFunction.m
//  ShreeAirlines
//
//  Created by NetprophetsMAC on 3/17/17.
//  Copyright © 2017 Netprophets. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

+(BOOL)isValidPassword:(NSString*)password
{
    //!~`@#$%^&*-+();:={}[],.<>?\\/\"\'
    //NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"^.*(?=.{6,})(?=.*[a-z])(?=.*[A-Z]).*$" options:0 error:nil];
//    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"^.*(?=.{6,})(?=.*[a-z])(?=.*[A-Z]).*(?=.[!,@,#,.,$,%,&,*,^])" options:0 error:nil];
    if (password.length<4){
        return false;
    }
    else
    {
        return true;
    }
//    return [regex numberOfMatchesInString:password options:0 range:NSMakeRange(0, [password length])] > 0;
}
+(UIView *)setStatusBarColor{
    UIApplication *app = [UIApplication sharedApplication];
    CGFloat statusBarHeight = app.statusBarFrame.size.height;
    
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, statusBarHeight)];
//    statusBarView.backgroundColor  =  [CommonFunction colorWithHexString:Primary_Blue];
     statusBarView.backgroundColor  =  [UIColor whiteColor];
    return statusBarView;
}

+(void)setNavToController:(UIViewController *)viewController title:(NSString *)title isCrossBusston:(BOOL)IsCross{
    //    title = [title capitalizedString];
    [viewController.view addSubview:[CommonFunction setStatusBarColor]];
    [viewController.navigationController setNavigationBarHidden:YES animated:NO];
    
    UINavigationBar *newNavBar;
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        if(((int)[[UIScreen mainScreen] nativeBounds].size.height)==2436) {
            if (@available(iOS 11.0, *)) {
                newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 44.0)];
            } else {
                // Fallback on earlier versions
            }
        }else{
             newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44.0)];
        }
    }
//    newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44.0)];
    newNavBar.barTintColor = [CommonFunction colorWithHexString:Primary_Blue];
//    newNavBar.barTintColor = [UIColor grayColor];

    newNavBar.translucent = false;
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    backgroundView.image = [UIImage imageNamed:@"Home_ Title bar graphic"];
    [newNavBar addSubview:backgroundView];
    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,(viewController.view.bounds.size.width/2)
                                                                    -20,[UIScreen mainScreen].bounds.size.width,40)];
    lbNavTitle.textAlignment = NSTextAlignmentLeft;
    lbNavTitle.text = title;
    lbNavTitle.textColor = [UIColor whiteColor];
    newItem.titleView = lbNavTitle;
    
    
    //    [[UIBarButtonItem alloc] initWithTitle:@"<"
    //                                     style:UIBarButtonItemStylePlain
    //                                    target:viewController
    //                                    action:@selector(backTapped)];
    UIBarButtonItem *dashboard;
    if (IsCross){
        dashboard = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cross-1"] style:UIBarButtonItemStylePlain target:viewController action:@selector(backTapped)];
    }else{
        dashboard = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:viewController action:@selector(backTapped)];
    }
    
    dashboard.tintColor = [UIColor colorWithRed:233.0f/255.0f green:141.0f/255.0f blue:25.0f/255.0f alpha:1];
    dashboard.tintColor = [UIColor whiteColor];
    newItem.leftBarButtonItem = dashboard;
    [newNavBar setItems:@[newItem]];
    
    //    UINavigationController *xyz = [[UINavigationController alloc] initWithRootViewController:<#(nonnull UIViewController *)#>];
    //    [xyz ]
    //
    //    xyz
    [viewController.view addSubview:newNavBar];
    
}

+(void)setNavToController:(UIViewController *)viewController title:(NSString *)title isCrossBusston:(BOOL)IsCross rightNavArray:(NSArray *)rightArray{
    //    title = [title capitalizedString];
    [viewController.view addSubview:[CommonFunction setStatusBarColor]];
    [viewController.navigationController setNavigationBarHidden:YES animated:NO];
    
    UINavigationBar *newNavBar;
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        if(((int)[[UIScreen mainScreen] nativeBounds].size.height)==2436) {
            if (@available(iOS 11.0, *)) {
                newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 44.0)];
            } else {
                // Fallback on earlier versions
            }
            
        }else{
            newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44.0)];
        }
    }
    //    newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44.0)];
    newNavBar.barTintColor = [CommonFunction colorWithHexString:Primary_Blue];
    newNavBar.translucent = false;
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    backgroundView.image = [UIImage imageNamed:@"Home_ Title bar graphic"];

    [newNavBar addSubview:backgroundView];
    
    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,(viewController.view.bounds.size.width/2)
                                                                    -20,[UIScreen mainScreen].bounds.size.width,40)];
    lbNavTitle.textAlignment = NSTextAlignmentLeft;
    lbNavTitle.text = title;
    lbNavTitle.textColor = [UIColor whiteColor];
    newItem.titleView = lbNavTitle;
    
    
    //    [[UIBarButtonItem alloc] initWithTitle:@"<"
    //                                     style:UIBarButtonItemStylePlain
    //                                    target:viewController
    //                                    action:@selector(backTapped)];
    UIBarButtonItem *dashboard;
    if (IsCross){
        dashboard = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cross-1"] style:UIBarButtonItemStylePlain target:viewController action:@selector(backTapped)];
        
    }else{
        dashboard = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:viewController action:@selector(backTapped)];
    }
    
//    dashboard.tintColor = [UIColor colorWithRed:233.0f/255.0f green:141.0f/255.0f blue:25.0f/255.0f alpha:1];
    dashboard.tintColor = [UIColor whiteColor];
    newItem.leftBarButtonItem = dashboard;
    NSMutableArray *rightItemArray = [NSMutableArray new];
    if (rightArray!= nil) {
        for (int i = 0; i<rightArray.count; i++) {
            dashboard = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:[rightArray objectAtIndex:i]] style:UIBarButtonItemStylePlain target:viewController action:@selector(rightBarAction:)];
            dashboard.tintColor = [UIColor whiteColor];
            dashboard.tag = i;
            [rightItemArray addObject:dashboard];
        }
          newItem.rightBarButtonItems = rightItemArray;
    }
  

    [newNavBar setItems:@[newItem]];
    
    //    UINavigationController *xyz = [[UINavigationController alloc] initWithRootViewController:<#(nonnull UIViewController *)#>];
    //    [xyz ]
    //
    //    xyz
    [viewController.view addSubview:newNavBar];
    
}


// For storing the value in default
+(void)storeValueInDefault:(NSString *)valueString andKey:(NSString *)keyString{
    
    [[NSUserDefaults standardUserDefaults]setValue:valueString forKey:keyString];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

// For reteriving the value in default
+(NSString *)getValueFromDefaultWithKey:(NSString *)keyString{
    
    return [[NSUserDefaults standardUserDefaults]valueForKey:keyString];
    
}


// For storing the Object in default
+(void)storeObjectInDefault:(NSDictionary * )valueDict andKey:(NSString *)keyString{
    [[NSUserDefaults standardUserDefaults]setObject:valueDict forKey:keyString];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

// For reteriving the object in default
+(NSDictionary *)getObjectFromDefaultWithKey:(NSString *)keyString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:keyString];
}


// For storing the bool value in default
+(void)stroeBoolValueForKey:(NSString *)keyString withBoolValue:(BOOL)boolValue{
    
    [[NSUserDefaults standardUserDefaults]setBool:boolValue forKey:keyString];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

// For reteriving the bool value in default
+(BOOL)getBoolValueFromDefaultWithKey:(NSString *)keyString{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:keyString];
    
}


//for validating the email

+(BOOL)validateEmailWithString:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:[CommonFunction trimString:email]];
}

//For validating mobile

+(BOOL)validateMobile:(NSString *)mobile{
    if (mobile.length == 0){
        return false;
    }
    NSString *emailRegex = @"[0-9]{8,11}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValidMobile = [emailTest evaluateWithObject:mobile];
    NSString *firstCharacter = [mobile substringToIndex:1];
    if (isValidMobile != true){
        return false;
    }else if ([firstCharacter isEqual: @"0"]){
        return false;
    }
    return true;
}


+(BOOL)validateName:(NSString *)name{
    NSString *nameExpression = @"[a-zA-Z. ]{2,50}";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameExpression];
    return [regex evaluateWithObject:[self trimString:name]];
   }

+(BOOL)validateAddress:(NSString *)name{
    NSString *nameExpression = @"[a-zA-Z0-9.,-_ ]{5,50}";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameExpression];
    return [regex evaluateWithObject:[self trimString:name]];
}
+(BOOL)validatePinCode:(NSString *)name{
    NSString *nameExpression = @"[0-9]{6,6}";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameExpression];
    return [regex evaluateWithObject:[self trimString:name]];
}


// set the User Interface
+(void)setResignTapGestureToView:(UIView *)view andsender:(id )sender{
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:sender action:@selector(resignResponder)];
    
    [view addGestureRecognizer:singleTap];
}

//For hiding the keyboard
+(void)resignFirstResponderOfAView:(UIView *)view{
    [view endEditing:YES];
}

+(NSString *)trimString:(NSString *)str{

    NSString *trimmedString = [str stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return trimmedString;
}


+(UIView *)loaderViewWithTitle:(NSString *)titleStr{
    UIView *loaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [loaderView setBackgroundColor:[UIColor blackColor]];
    loaderView.alpha = .9;
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2,( [UIScreen mainScreen].bounds.size.height-64)/2);
    [activityView startAnimating];
    [loaderView addSubview:activityView];
    UILabel *lblForTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, activityView.center.y+30, [UIScreen mainScreen].bounds.size.width-40, 30)];
    lblForTitle.textColor = [UIColor whiteColor];
    lblForTitle.font = [UIFont fontWithName:@"RobotoSlab-Bold" size:17];
    lblForTitle.textAlignment = NSTextAlignmentCenter;
    lblForTitle.text = titleStr;
    [loaderView addSubview:lblForTitle];
    return loaderView;
    
}

+(BOOL)reachability
{
    Reachability  *internetReachable = [Reachability reachabilityForInternetConnection:true];
    // Internet is reachable
    if([internetReachable currentReachabilityStatus]){
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
}

+(BOOL)reachabilityForIPV6
{
    Reachability  *internetReachable = [Reachability reachabilityForInternetConnection:false];
    // Internet is reachable
    if([internetReachable currentReachabilityStatus])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
}



+ (UIColor *)colorWithHexString:(NSString *)hexCode {
    NSString *noHashString = [hexCode stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

+(id)checkForNull:(id)tel{
    if([tel isKindOfClass:[NSNull class]]  || [tel isEqualToString:@""]){
        return @"";
    }
    else{
        return tel;
    }
//    return @"";
}

+(NSString *)ConvertDateTime:(NSString *)dateStr andTime:(NSString *)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-YYYY"];
    NSDate *dateTemp = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"MMM, dd YYYY"];
    NSString *newDate = [formatter stringFromDate:dateTemp];
    
    
   
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    
    
    dateFormatter1.dateFormat = @"HH:mm";
    NSDate *date = [dateFormatter1 dateFromString:time];
    dateFormatter1.dateFormat = @"hh:mm:ss a";
    NSString *timeStr = [dateFormatter1 stringFromDate:date];
    NSString *temp = [NSString stringWithFormat:@"%@ %@",newDate,timeStr];
    return temp;
}
+(NSString *)timeConverter:(NSString *)timeString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSDate *date = [dateFormatter dateFromString:timeString];
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *pmamDateString = [dateFormatter stringFromDate:date];
    return pmamDateString;
}

+(NSNumber *)convertStrToNumber:(NSString *)str{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:str];
    return myNumber;
}

+(NSDate *)convertStringToDate:(NSString *)dtrDate{
    
    NSString* substring = @"Dec 5 2012 12:08 PM";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:@"MMM d yyyy h:mm a EEEE"]; // not 'p' but 'a'
    NSDate *dateFromString = [dateFormatter dateFromString:dtrDate];
    return dateFromString;
}


+(NSDate *)convertStringddMMYYYYToDate:(NSString *)dtrDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"]; // not 'p' but 'a'
    NSDate *dateFromString = [dateFormatter dateFromString:dtrDate];
    return dateFromString;
}

+(NSString*)convertDDMMYYYYtoMMDDYYYY:(NSString*) string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [formatter dateFromString:string];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *output = [formatter stringFromDate:date];
    return output;
}

+(NSDate *)convertTimeToDate:(NSString *)dtrDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"]; // not 'p' but 'a'
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];

    NSDate *dateFromString = [dateFormatter dateFromString:dtrDate];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    dateFromString = [dateFromString dateByAddingTimeInterval:timeZoneSeconds];
    return dateFromString;
}

+(void) setViewBackground:(UIView*) view withImage:(UIImage*) background {
   
    view.backgroundColor = [UIColor whiteColor];
    UIGraphicsBeginImageContext(view.frame.size);
    [background drawInRect:view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

+(NSString *)getThePrice:(NSString *)price{
    NSLog(@"%@",price);
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:price];
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle]; // Here you can choose the style
    
    NSString *formatted = [numberFormatter stringFromNumber:myNumber];
    NSLog(@"%@",formatted);
    return formatted;
}


+(void)addNoDataLabel:(UIView*)view{

    UILabel *lbl = [UILabel new];
    [lbl sizeToFit];
    lbl.frame = CGRectMake(0, 0, 100, 50);
    lbl.center = view.center;
    lbl.text = @"No Data";
    lbl.textColor = [UIColor blackColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.tag = 500;
    [view addSubview:lbl];
}


+(NSString *)checkEmptyString:(NSString *)str{
    if ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]) {
        return @"N/A";
    }
    return str;
}

+(NSURL*) getProfilePicURLString:(NSString*) userName{
    NSString* str = [NSString stringWithFormat:@"https://s3-ap-southeast-2.amazonaws.com/advok8/%@/ProfilePic",userName];
    return [NSURL URLWithString:str];
}

+(BOOL)isadvoK8{
    if ([[CommonFunction getValueFromDefaultWithKey:@"loginUsertype"]  isEqual:  @"advocate"]&&[CommonFunction getBoolValueFromDefaultWithKey:isLoggedIn]){
        return true;
    }
    return false;
}

+(void)setShadowOpacity:(UIView *)view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 3.0;
}

+(void)setCornerRadius:(UIView *)view Radius:(CGFloat)radius{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = true;
}

+ (NSUserDefaults *) defaults {
    return [NSUserDefaults standardUserDefaults];
}

+ (void) persistObj:(id)value forKey:(NSString *)key {
    [self.defaults setObject:value  forKey:key];
    [self.defaults synchronize];
}

+ (void) persistObjAsData:(id)encodableObject forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:encodableObject];
    [self persistObj:data forKey:key];
}

+ (id) objectFromDataWithKey:(NSString*)key {
    NSData *data = [self.defaults objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


@end
